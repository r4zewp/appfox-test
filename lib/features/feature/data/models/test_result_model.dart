import 'package:appfox_test/features/feature/domain/entities/test_result_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestResultModel extends TestResultEntity {
  const TestResultModel({
    required super.category,
    required super.correctAnswersAmount,
    required super.date,
    required super.difficulty,
    required super.incorrectAnswersAmount,
    super.userAnswers,
  });

  @override
  List<Object> get props => [
        correctAnswersAmount,
        incorrectAnswersAmount,
        date,
        category,
        difficulty,
      ];

  Map<String, dynamic> toFirestore() => {
        "correct_answers_amount": correctAnswersAmount,
        "incorrect_answers_amount": incorrectAnswersAmount,
        "date": date,
        "difficulty": difficulty,
        "category": category,
        "userAnswers": userAnswers,
      };

  /// TODO: Implement fromJson for TestResultModel
  factory TestResultModel.fromFirestore(Map<String, dynamic> json) {
    return TestResultModel(
      category: json["category"],
      correctAnswersAmount: json["correct_answers_amount"],
      date: DateTime.fromMillisecondsSinceEpoch(
          (json["date"] as Timestamp).millisecondsSinceEpoch),
      difficulty: json["difficulty"],
      incorrectAnswersAmount: json["incorrect_answers_amount"],
    );
  }
}
