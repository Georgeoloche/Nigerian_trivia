import '../entities/question.dart';

abstract class QuestionRepository {
  Future<List<Question>> getQuestions({required String category, required String difficulty});
  Future<List<String>> getCategories();
}
