import '../../domain/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel({
    required int id,
    required String question,
    required List<String> options,
    required String answer,
    required String category,
    required String difficulty,
  }) : super(
          id: id,
          question: question,
          options: options,
          answer: answer,
          category: category,
          difficulty: difficulty,
        );

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? 0,
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
      category: json['category'],
      difficulty: json['difficulty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'answer': answer,
      'category': category,
      'difficulty': difficulty,
    };
  }
}
