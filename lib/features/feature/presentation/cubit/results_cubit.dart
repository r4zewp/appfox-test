import 'package:appfox_test/features/feature/domain/entities/test_result_entity.dart';
import 'package:appfox_test/features/feature/domain/usecases/get_all_results_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'results_state.dart';

class ResultCubit extends Cubit<ResultState> {
  final GetAllResultsUsecase getAllResultsUsecase;

  ResultCubit({required this.getAllResultsUsecase}) : super(ResultInitial());

  void getPreviousResults() async {
    emit(ResultLoading());

    final failureOrResults =
        await getAllResultsUsecase.call(const ResultParams());

    failureOrResults.fold(
      (failure) => emit(ResultError()),
      (results) => emit(ResultLoaded(results: results)),
    );
  }
}
