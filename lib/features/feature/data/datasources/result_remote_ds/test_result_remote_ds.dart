import 'package:appfox_test/features/feature/data/models/test_result_model.dart';

abstract class TestResultRemoteDatasource {
  Future<void> uploadTestResults(TestResultModel result);
  Future<List<TestResultModel>> getAllResults();
}
