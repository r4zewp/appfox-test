import 'package:appfox_test/features/feature/domain/entities/answer_entity.dart';
import 'package:equatable/equatable.dart';

class TestResultEntity extends Equatable {
  final List<Map<String, dynamic>>? userAnswers;
  final int correctAnswersAmount;
  final int incorrectAnswersAmount;
  final DateTime date;
  final String category;
  final String difficulty;

  const TestResultEntity({
    required this.userAnswers,
    required this.correctAnswersAmount,
    required this.incorrectAnswersAmount,
    required this.date,
    required this.category,
    required this.difficulty,
  });

  @override
  List<Object> get props => [
        correctAnswersAmount,
        incorrectAnswersAmount,
        date,
        category,
        difficulty,
      ];
}
