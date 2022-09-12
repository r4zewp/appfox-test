import 'package:appfox_test/features/feature/core/config/config.dart';
import 'package:appfox_test/features/feature/core/firebase_service/firebase_service.dart';
import 'package:appfox_test/features/feature/data/datasources/result_remote_ds/test_result_remote_ds.dart';
import 'package:appfox_test/features/feature/data/models/test_result_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestResultRemoteDatasourceImpl extends TestResultRemoteDatasource {
  //final firestore = GetIt.I.get<FirebaseService>();
  final firestore = FirebaseFirestore.instance;

  @override
  Future<List<TestResultModel>> getAllResults() async {
    final documents = await firestore.collection(Config.resultCollection).get();
    final testResults = documents.docs
        .map((e) => TestResultModel.fromFirestore(e.data()))
        .toList();
    return testResults;
  }

  @override
  Future<void> uploadTestResults(TestResultModel result) async {
    await firestore
        .collection(Config.resultCollection)
        .add(result.toFirestore());
  }
}
