import 'package:appfox_test/features/feature/data/models/question_model.dart';

abstract class QuestionRemoteDatasource {
  Future<List<QuestionModel>> getQuestionsByCategoryAndDifficulty(
      String category, String difficulty);
}
