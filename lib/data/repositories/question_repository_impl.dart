import 'package:nigeria_trivia/data/models/question_model.dart';
import 'package:nigeria_trivia/data/sources/question_local_data_source.dart';

import '../../domain/entities/question.dart';


class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionLocalDataSource localDataSource;
  QuestionRepositoryImpl({required this.localDataSource});

  Future<List<Question>> getQuestions({required String category, required String difficulty}) async {
    List<QuestionModel> questions = await localDataSource.loadQuestions();
    // Filter by category and difficulty.
    return questions.where((q) => q.category == category && q.difficulty == difficulty).toList();
  }

  Future<List<String>> getCategories() async {
    List<QuestionModel> questions = await localDataSource.loadQuestions();
    return questions.map((q) => q.category).toSet().toList();
  }
}
