part of 'results_cubit.dart';

abstract class ResultState extends Equatable {
  const ResultState();

  @override
  List<Object> get props => [];
}

class ResultInitial extends ResultState {
  @override
  List<Object> get props => [];
}

class ResultLoading extends ResultState {
  @override
  List<Object> get props => [];
}

class ResultLoaded extends ResultState {
  final List<TestResultEntity> results;

  const ResultLoaded({required this.results});

  @override
  List<Object> get props => [results];
}

class ResultError extends ResultState {
  @override
  List<Object> get props => [];
}
