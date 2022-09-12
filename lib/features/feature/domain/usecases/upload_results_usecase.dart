import 'package:appfox_test/features/feature/core/failure/failure.dart';
import 'package:appfox_test/features/feature/core/usecase/usecase.dart';
import 'package:appfox_test/features/feature/domain/repositories/test_result_repository.dart';
import 'package:appfox_test/features/feature/domain/usecases/get_all_results_usecase.dart';
import 'package:dartz/dartz.dart';

class UploadResultsUsecase extends UseCase<void, ResultParams> {
  final TestResultRepository testResultRepository;

  UploadResultsUsecase({required this.testResultRepository});

  @override
  Future<Either<Failure, void>> call(ResultParams params) async =>
      await testResultRepository.uploadResults(params.result!);
}
