import 'package:appfox_test/features/feature/domain/entities/answer_entity.dart';

class AnswerModel extends AnswerEntity {
  const AnswerModel({
    required super.isUserCorrect,
    super.question,
    required super.userAnswer,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "is_user_correct": isUserCorrect,
      "user_answer": userAnswer,
      "question": question!.toFirestore(),
    };
  }

  @override
  List<Object> get props => [];
}
