import 'package:appfox_test/features/feature/core/dio/dio_singleton.dart';
import 'package:appfox_test/features/feature/core/dio/endpoints.dart';
import 'package:appfox_test/features/feature/core/exception/exceptions.dart';
import 'package:appfox_test/features/feature/data/datasources/question_remote_ds/question_remote_ds.dart';
import 'package:appfox_test/features/feature/data/models/question_model.dart';
import 'package:dio/dio.dart';

class QuestionRemoteDatasourceImpl extends QuestionRemoteDatasource {
  final Dio _dio = DioSingleton().instance();

  @override
  Future<List<QuestionModel>> getQuestionsByCategoryAndDifficulty(
      String category, String difficulty) async {
    /// Adding queryParameters in order to get specified response
    _dio.options.queryParameters.addAll(
      {
        'category': category,
        'difficulty': difficulty,
        'limit': 5,
      },
    );

    final response = await _dio.get("${Endpoints.root}/${Endpoints.questions}");

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => QuestionModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
