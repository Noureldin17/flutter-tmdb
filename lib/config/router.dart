import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_main_page.dart';
import '../authentication/presentation/pages/login_page.dart';
import '../authentication/presentation/pages/onboarding.dart';
import '../authentication/presentation/pages/welcome_page.dart';
import '../movies/domain/models/more_movies_args_model.dart';
import '../movies/domain/models/movie_detail_args_model.dart';
import '../movies/presentation/bloc/movies_bloc.dart';
import '../movies/presentation/pages/more_movies_page.dart';
import '../movies/presentation/pages/movie_detail_page.dart';
import '../utils/pages.dart' as pages;
import '../core/dependency_injection/dependency_injection.dart' as di;

class AppRouter {
  late Widget startScreen;

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case pages.welcomePage:
        return MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        );
      case pages.onBoardingPage:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingPage(),
        );
      case pages.loginPage:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case pages.appMainPage:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => di.sl<MoviesBloc>(),
              ),
            ],
            child: const AppMainPage(),
          ),
        );
      case pages.movieDetailPage:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => di.sl<MoviesBloc>(),
              ),
            ],
            child: MovieDetailPage(
                movieDetailArgs: settings.arguments as MovieDetailArgs),
          ),
        );
      case pages.moreMoviesPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => di.sl<MoviesBloc>(),
            child: MoreMoviesPage(
                moreMoviesArgs: settings.arguments as MoreMoviesArgs),
          ),
        );
      case pages.searchPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => di.sl<SearchBloc>(),
            child: const SearchPage(),
          ),
        );

      default:
        return null;
    }
  }
}
