import '../entities/question.dart';
import '../repositories/question_repository.dart';

class GetQuestionsUseCase {
  final QuestionRepository repository;
  GetQuestionsUseCase(this.repository);

  Future<List<Question>> call({required String category, required String difficulty}) {
    return repository.getQuestions(category: category, difficulty: difficulty);
  }
}
