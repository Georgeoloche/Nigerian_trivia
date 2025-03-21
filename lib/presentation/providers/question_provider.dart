import 'package:flutter/material.dart';
import '../../domain/entities/question.dart';
import '../../domain/usecases/get_questions_usecase.dart';

class QuestionProvider with ChangeNotifier {
  final GetQuestionsUseCase getQuestionsUseCase;
  List<Question> questions = [];
  int currentIndex = 0;
  int score = 0;

  QuestionProvider(this.getQuestionsUseCase);

  Future<void> loadQuestions({required String category, required String difficulty}) async {
    questions = await getQuestionsUseCase(category: category, difficulty: difficulty);
    currentIndex = 0;
    score = 0;
    notifyListeners();
  }

  void answerQuestion(String selectedAnswer) {
    if (selectedAnswer == questions[currentIndex].answer) {
      score++;
    }
    if (currentIndex < questions.length - 1) {
      currentIndex++;
    }
    notifyListeners();
  }
}
