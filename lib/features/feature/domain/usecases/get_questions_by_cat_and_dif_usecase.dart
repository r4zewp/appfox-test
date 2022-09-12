import 'package:appfox_test/features/feature/core/failure/failure.dart';
import 'package:appfox_test/features/feature/core/usecase/usecase.dart';
import 'package:appfox_test/features/feature/domain/entities/question_entity.dart';
import 'package:appfox_test/features/feature/domain/repositories/questions_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetQuestionsByCategoryAndDifficultyUsecase
    extends UseCase<List<QuestionEntity>, QuestionQueryParams> {
  final QuestionsRepository questionsRepository;

  GetQuestionsByCategoryAndDifficultyUsecase(
      {required this.questionsRepository});

  @override
  Future<Either<Failure, List<QuestionEntity>>> call(
      QuestionQueryParams params) async {
    return await questionsRepository.getQuestionsByCategoryAndDifficulty(
        params.category, params.difficulty);
  }
}

class QuestionQueryParams extends Equatable {
  final String category;
  final String difficulty;

  const QuestionQueryParams({
    required this.category,
    required this.difficulty,
  });

  @override
  List<Object> get props => [];
}
