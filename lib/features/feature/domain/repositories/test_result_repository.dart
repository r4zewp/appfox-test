import 'package:appfox_test/features/feature/core/failure/failure.dart';
import 'package:appfox_test/features/feature/data/models/test_result_model.dart';
import 'package:dartz/dartz.dart';

abstract class TestResultRepository {
  Future<Either<Failure, void>> uploadResults(TestResultModel result);
  Future<Either<Failure, List<TestResultModel>>> getAllResults();
}
