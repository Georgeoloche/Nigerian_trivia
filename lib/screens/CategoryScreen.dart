import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import '../database/database_helper.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    DatabaseHelper dbHelper = DatabaseHelper.instance;
    List<String> categories = await dbHelper.getCategories();
    setState(() => _categories = categories);
  }

  void _startQuiz(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizScreen(selectedCategory: category)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select a Category")),
      body: _categories.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_categories[index]),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () => _startQuiz(_categories[index]),
                );
              },
            ),
    );
  }
}
