import 'package:appfox_test/features/feature/core/platform/network_information.dart';
import 'package:appfox_test/features/feature/data/datasources/question_remote_ds/question_remote_ds.dart';
import 'package:appfox_test/features/feature/data/models/question_model.dart';
import 'package:appfox_test/features/feature/core/failure/failure.dart';
import 'package:appfox_test/features/feature/domain/repositories/questions_repository.dart';
import 'package:dartz/dartz.dart';

class QuestionsRepositoryImpl extends QuestionsRepository {
  final QuestionRemoteDatasource remoteDatasource;
  final NetworkInformation networkInformation;

  QuestionsRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInformation,
  });

  @override
  Future<Either<Failure, List<QuestionModel>>>
      getQuestionsByCategoryAndDifficulty(
    String category,
    String difficulty,
  ) async {
    if (await networkInformation.isConnected) {
      final questions = await remoteDatasource
          .getQuestionsByCategoryAndDifficulty(category, difficulty);
      return Right(questions);
    } else {
      return Left(ServerFailure());
    }
  }
}
