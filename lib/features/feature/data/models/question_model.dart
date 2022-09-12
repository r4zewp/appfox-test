import 'package:appfox_test/features/feature/domain/entities/question_entity.dart';

class QuestionModel extends QuestionEntity {
  const QuestionModel({
    required super.id,
    required super.question,
    required super.description,
    required super.answers,
    required super.isMultiple,
    required super.correctAnswers,
    required super.category,
    required super.difficulty,
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
        difficulty
      ];

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json["id"],
      question: json["question"],
      description: json["description"],
      answers: json["answers"],
      isMultiple:
          json["multiple_correct_answers"].toString().toLowerCase() == "true"
              ? true
              : false,
      correctAnswers: json["correct_answers"],
      category: json["category"],
      difficulty: json["difficulty"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "question": question,
      "description": description,
      "answers": answers,
      "is_multiple": isMultiple,
      "correct_answers": correctAnswers,
      "category": category,
      "difficulty": difficulty,
    };
  }
}
