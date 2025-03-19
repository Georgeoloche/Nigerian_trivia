import 'package:flutter/material.dart';
import 'package:nigeria_trivia/screens/CategoryScreen.dart';
import 'database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // This will clear the current database and load questions from JSON.
  // Make sure your JSON file (assets/nigeria_trivia_questions.json) contains your 1,000 unique questions.
  await DatabaseHelper.instance.loadJsonIntoDatabase(await DatabaseHelper.instance.database);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nigeria Trivia',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const CategoryScreen(), // Start with the category selection screen
    );
  }
}
