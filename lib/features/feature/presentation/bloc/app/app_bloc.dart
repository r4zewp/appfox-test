import 'package:appfox_test/features/feature/common/constants.dart';
import 'package:appfox_test/features/feature/core/failure/failure.dart';
import 'package:appfox_test/features/feature/data/models/answer_model.dart';
import 'package:appfox_test/features/feature/data/models/test_result_model.dart';
import 'package:appfox_test/features/feature/domain/entities/answer_entity.dart';
import 'package:appfox_test/features/feature/domain/entities/question_entity.dart';
import 'package:appfox_test/features/feature/domain/usecases/get_all_results_usecase.dart';
import 'package:appfox_test/features/feature/domain/usecases/get_questions_by_cat_and_dif_usecase.dart';
import 'package:appfox_test/features/feature/domain/usecases/upload_results_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final GetQuestionsByCategoryAndDifficultyUsecase
      getQuestionsByCategoryAndDifficultyUsecase;
  final UploadResultsUsecase uploadResultsUsecase;

  AppBloc(
      {required this.getQuestionsByCategoryAndDifficultyUsecase,
      required this.uploadResultsUsecase})
      : super(AppInitialState()) {
    on<AppInitialized>(
      (event, emit) async {
        await Future.delayed(
          const Duration(milliseconds: 2000),
          () => emit(AppMainPageLoaded()),
        );
      },
    );

    /// Triggers when quiz is requested.
    on<AppQuestionsInitialized>(
      (event, emit) async {
        emit(AppLoadingQuestions());

        /// Get failure or questions
        final failureOrQuestions =
            await getQuestionsByCategoryAndDifficultyUsecase.call(
          QuestionQueryParams(
              category: event.category, difficulty: event.difficulty),
        );

        /// Folds the result.
        failureOrQuestions.fold(
          (error) {
            emit(AppError(errorMessage: _failureToMessage(error)));
          },
          (questions) {
            emit(AppLoadedQuestions(questions: questions));
          },
        );
      },
    );

    /// Triggers when upload is requested.
    on<AppTestResultUploadInitialized>(
      (event, emit) async {
        emit(AppSavingResultsInitialized());

        TestResultModel? testResultModel;
        int correctAnswersAmount = 0;
        int incorrectAnswersAmount = 0;

        for (var answer in event.answers) {
          if (answer.isUserCorrect) {
            correctAnswersAmount++;
          } else {
            incorrectAnswersAmount++;
          }
        }

        final date = DateTime.now();
        testResultModel = TestResultModel(
          category: event.category,
          correctAnswersAmount: correctAnswersAmount,
          date: date,
          difficulty: event.difficulty,
          incorrectAnswersAmount: incorrectAnswersAmount,
          userAnswers:
              event.answers.map((answer) => answer.toFirestore()).toList(),
        );

        final failureOrSuccess = await uploadResultsUsecase
            .call(ResultParams(result: testResultModel));

        failureOrSuccess.fold(
          (failure) => emit(AppError(errorMessage: _failureToMessage(failure))),
          (success) => emit(AppResultsSaved()),
        );
      },
    );

    on<AppTestResultUploadFinished>(
      (event, emit) async {
        emit(AppResultsUploadingFinished());
      },
    );
  }

  /// Failure runtimeType to String method.
  String _failureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppConstants.serverFailureMessage;
      default:
        return AppConstants.unexpectedFailureMessage;
    }
  }
}
