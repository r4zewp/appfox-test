import 'package:appfox_test/features/feature/data/models/question_model.dart';
import 'package:appfox_test/features/feature/domain/entities/question_entity.dart';
import 'package:equatable/equatable.dart';

class AnswerEntity extends Equatable {
  final QuestionModel? question;
  final String userAnswer;
  final bool isUserCorrect;

  const AnswerEntity({
    required this.question,
    required this.userAnswer,
    required this.isUserCorrect,
  });

  @override
  List<Object> get props => [];
}
