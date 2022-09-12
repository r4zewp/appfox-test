part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class AppInitialState extends AppState {
  @override
  List<Object> get props => [];
}

class AppMainPageLoaded extends AppState {
  AppMainPageLoaded();

  @override
  List<Object> get props => [];
}

class AppError extends AppState {
  final String errorMessage;

  AppError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class AppLoadingQuestions extends AppState {
  AppLoadingQuestions();

  @override
  List<Object> get props => [];
}

class AppLoadedQuestions extends AppState {
  final List<QuestionEntity> questions;

  AppLoadedQuestions({required this.questions});

  @override
  List<Object> get props => [questions];
}

class AppSavingResultsInitialized extends AppState {
  @override
  List<Object> get props => [];
}

class AppResultsSaved extends AppState {
  @override
  List<Object> get props => [];
}

class AppResultsUploadingFinished extends AppState {
  @override
  List<Object> get props => [];
}
