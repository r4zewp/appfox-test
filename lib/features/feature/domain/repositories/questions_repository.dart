import 'package:appfox_test/features/feature/core/failure/failure.dart';
import 'package:appfox_test/features/feature/data/models/question_model.dart';
import 'package:dartz/dartz.dart';

abstract class QuestionsRepository {
  Future<Either<Failure, List<QuestionModel>>>
      getQuestionsByCategoryAndDifficulty(String category, String difficulty);
}
