// ignore_for_file: void_checks

import 'package:appfox_test/features/feature/core/exception/exceptions.dart';
import 'package:appfox_test/features/feature/core/platform/network_information.dart';
import 'package:appfox_test/features/feature/data/datasources/result_remote_ds/test_result_remote_ds.dart';
import 'package:appfox_test/features/feature/data/models/test_result_model.dart';
import 'package:appfox_test/features/feature/core/failure/failure.dart';
import 'package:appfox_test/features/feature/domain/repositories/test_result_repository.dart';
import 'package:dartz/dartz.dart';

class TestResultRepositoryImpl extends TestResultRepository {
  final TestResultRemoteDatasource remoteDatasource;
  final NetworkInformation networkInformation;

  TestResultRepositoryImpl(
      {required this.remoteDatasource, required this.networkInformation});

  @override
  Future<Either<Failure, List<TestResultModel>>> getAllResults() async {
    if (await networkInformation.isConnected) {
      try {
        final results = await remoteDatasource.getAllResults();
        return Right(results);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> uploadResults(TestResultModel result) async {
    if (await networkInformation.isConnected) {
      try {
        await remoteDatasource.uploadTestResults(result);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
