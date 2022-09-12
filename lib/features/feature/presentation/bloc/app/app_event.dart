part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppInitialized extends AppEvent {
  @override
  List<Object> get props => [];
}

class AppQuestionsInitialized extends AppEvent {
  final String category;
  final String difficulty;

  AppQuestionsInitialized({required this.category, required this.difficulty});

  @override
  List<Object> get props => [];
}

class AppTestResultUploadInitialized extends AppEvent {
  final List<AnswerModel> answers;
  final String category;
  final String difficulty;

  AppTestResultUploadInitialized({
    required this.answers,
    required this.category,
    required this.difficulty,
  });

  @override
  List<Object> get props => [];
}

class AppTestResultUploadFinished extends AppEvent {
  @override
  List<Object> get props => [];
}
