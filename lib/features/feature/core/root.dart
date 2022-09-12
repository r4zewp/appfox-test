import 'package:appfox_test/features/feature/core/router/custom_router.dart';
import 'package:appfox_test/features/feature/core/router/page_routes.dart';
import 'package:appfox_test/features/feature/presentation/bloc/app/app_bloc.dart';
import 'package:appfox_test/features/feature/presentation/cubit/results_cubit.dart';
import 'package:appfox_test/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<AppBloc>()..add(AppInitialized()),
        ),
        BlocProvider(
          create: (context) => locator<ResultCubit>()..getPreviousResults(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) =>
            CustomRouter.generateRoute(settings, context),
        initialRoute: PageRoutes.initial,
        onUnknownRoute: (settings) =>
            CustomRouter.generateRoute(settings, context),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[700],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[800],
            elevation: 0.0,
            centerTitle: false,
          ),
        ),
      ),
    );
  }
}
