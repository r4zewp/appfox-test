import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final int id;
  final String question;
  final String? description;
  final Map<String, dynamic> answers;
  final bool isMultiple;
  final Map<String, dynamic> correctAnswers;
  final String category;
  final String difficulty;

  const QuestionEntity({
    required this.id,
    required this.question,
    required this.description,
    required this.answers,
    required this.isMultiple,
    required this.correctAnswers,
    required this.category,
    required this.difficulty,
  });

  @override
  List<Object?> get props => [
        id,
        question,
        description,
        answers,
        isMultiple,
        correctAnswers,
        category,
        difficulty,
      ];
}
