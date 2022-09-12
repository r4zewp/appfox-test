import 'package:appfox_test/features/feature/core/failure/failure.dart';
import 'package:appfox_test/features/feature/core/usecase/usecase.dart';
import 'package:appfox_test/features/feature/data/models/test_result_model.dart';
import 'package:appfox_test/features/feature/domain/entities/test_result_entity.dart';
import 'package:appfox_test/features/feature/domain/repositories/test_result_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllResultsUsecase
    extends UseCase<List<TestResultEntity>, ResultParams> {
  final TestResultRepository testResultRepository;

  GetAllResultsUsecase({required this.testResultRepository});

  @override
  Future<Either<Failure, List<TestResultEntity>>> call(
          ResultParams params) async =>
      await testResultRepository.getAllResults();
}

class ResultParams extends Equatable {
  final TestResultModel? result;

  const ResultParams({this.result});

  @override
  List<Object?> get props => [];
}
