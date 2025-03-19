import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/question.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'quiz.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT,
        optionA TEXT,
        optionB TEXT,
        optionC TEXT,
        optionD TEXT,
        correctAnswer TEXT,
        category TEXT
      )
    ''');
    await loadJsonIntoDatabase(db);
  }

  Future<void> loadJsonIntoDatabase(Database db) async {
    String jsonString = await rootBundle.loadString('assets/nigeria_trivia_questions.json');
    List<dynamic> jsonData = json.decode(jsonString);
    Set<String> uniqueQuestions = {};

    for (var item in jsonData) {
      if (!uniqueQuestions.contains(item['question'])) {
        await db.insert('questions', {
          'question': item['question'],
          'optionA': item['optionA'],
          'optionB': item['optionB'],
          'optionC': item['optionC'],
          'optionD': item['optionD'],
          'correctAnswer': item['correctAnswer'],
          'category': item['category'],
        });
        uniqueQuestions.add(item['question']);
      }
    }
    print("✅ Loaded ${uniqueQuestions.length} unique questions from JSON");
  }

  Future<List<Question>> getQuestionsByCategory(String category) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM questions WHERE category = ? ORDER BY RANDOM() LIMIT 200', [category]);
    return maps.map((map) => Question.fromMap(map)).toList();
  }

  Future<List<String>> getCategories() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT DISTINCT category FROM questions');
    return maps.map((map) => map['category'] as String).toList();
  }

  Future<List<Question>> getAllQuestions() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('questions');
    print("✅ Total questions in DB: ${maps.length}");
    return maps.map((map) => Question.fromMap(map)).toList();
  }
}
