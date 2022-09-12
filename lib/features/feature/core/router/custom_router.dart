import 'package:appfox_test/features/feature/core/router/page_routes.dart';
import 'package:appfox_test/features/feature/presentation/pages/error/error_page.dart';
import 'package:appfox_test/features/feature/presentation/pages/home/home_page.dart';
import 'package:appfox_test/features/feature/presentation/pages/questions/questions_page_view.dart';
import 'package:appfox_test/features/feature/presentation/pages/results/results_page.dart';
import 'package:appfox_test/features/feature/presentation/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(
      RouteSettings settings, BuildContext context) {
    debugPrint('*** CURRENT ROUTE: ${settings.name}');

    switch (settings.name) {
      case PageRoutes.savedResults:
        return MaterialPageRoute(
          builder: (_) => const ResultsPage(),
        );
      case PageRoutes.questions:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => QuestionsPageView(
            questions: (settings.arguments as Map)["questions"],
          ),
        );
      case PageRoutes.initial:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
      case PageRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const Home(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const ErrorPage(),
        );
    }
  }
}
