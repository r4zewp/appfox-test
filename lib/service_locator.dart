import 'package:appfox_test/features/feature/core/dio/dio_singleton.dart';
import 'package:appfox_test/features/feature/core/platform/network_information.dart';
import 'package:appfox_test/features/feature/core/platform/network_information_impl.dart';
import 'package:appfox_test/features/feature/data/datasources/question_remote_ds/question_remote_ds.dart';
import 'package:appfox_test/features/feature/data/datasources/question_remote_ds/question_remote_ds_impl.dart';
import 'package:appfox_test/features/feature/data/datasources/result_remote_ds/test_result_remote_ds.dart';
import 'package:appfox_test/features/feature/data/datasources/result_remote_ds/test_result_remote_ds_impl.dart';
import 'package:appfox_test/features/feature/data/repositories/questions_repository_impl.dart';
import 'package:appfox_test/features/feature/data/repositories/test_result_repository_impl.dart';
import 'package:appfox_test/features/feature/domain/repositories/questions_repository.dart';
import 'package:appfox_test/features/feature/domain/repositories/test_result_repository.dart';
import 'package:appfox_test/features/feature/domain/usecases/get_all_results_usecase.dart';
import 'package:appfox_test/features/feature/domain/usecases/get_questions_by_cat_and_dif_usecase.dart';
import 'package:appfox_test/features/feature/domain/usecases/upload_results_usecase.dart';
import 'package:appfox_test/features/feature/presentation/bloc/app/app_bloc.dart';
import 'package:appfox_test/features/feature/presentation/cubit/results_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final locator = GetIt.instance;

Future<void> init() async {
  /// BLoC
  locator.registerFactory(
    () => AppBloc(
      getQuestionsByCategoryAndDifficultyUsecase: locator(),
      uploadResultsUsecase: locator(),
    ),
  );
  locator.registerFactory(
    () => ResultCubit(
      getAllResultsUsecase: locator(),
    ),
  );

  /// Usecases
  locator.registerLazySingleton(
    () => GetQuestionsByCategoryAndDifficultyUsecase(
        questionsRepository: locator()),
  );
  locator.registerLazySingleton(
      () => GetAllResultsUsecase(testResultRepository: locator()));
  locator.registerLazySingleton(
      () => UploadResultsUsecase(testResultRepository: locator()));

  /// Repos
  locator.registerLazySingleton<QuestionsRepository>(
    () => QuestionsRepositoryImpl(
      remoteDatasource: locator(),
      networkInformation: locator(),
    ),
  );
  locator.registerLazySingleton<TestResultRepository>(
    () => TestResultRepositoryImpl(
      remoteDatasource: locator(),
      networkInformation: locator(),
    ),
  );

  /// Datasources
  locator.registerLazySingleton<QuestionRemoteDatasource>(
      () => QuestionRemoteDatasourceImpl());
  locator.registerLazySingleton<TestResultRemoteDatasource>(
      () => TestResultRemoteDatasourceImpl());

  /// Core
  locator.registerLazySingleton<NetworkInformation>(
    () => NetworkInformationImpl(checker: locator()),
  );

  /// External
  locator.registerLazySingleton(() => DioSingleton().instance());
  locator.registerLazySingleton(() => InternetConnectionChecker());

  await Firebase.initializeApp();
}
