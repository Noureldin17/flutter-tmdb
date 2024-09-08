import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../authentication/data/datasources/auth_local_datasource.dart';
import '../../authentication/data/datasources/auth_remote_datasource.dart';
import '../../authentication/data/repositories/auth_repository_impl.dart';
import '../../authentication/domain/repositories/auth_repository.dart';
import '../../authentication/domain/usecases/add_rating_usecase.dart';
import '../../authentication/domain/usecases/add_to_watchlist_usecase.dart';
import '../../authentication/domain/usecases/check_onboard_usecase.dart';
import '../../authentication/domain/usecases/delete_rating_usecase.dart';
import '../../authentication/domain/usecases/get_user_details_usecase.dart';
import '../../authentication/domain/usecases/get_watchlist_usecase.dart';
import '../../authentication/domain/usecases/guest_login_usecase.dart';
import '../../authentication/domain/usecases/login_usecase.dart';
import '../../authentication/domain/usecases/logout_usecase.dart';
import '../../authentication/domain/usecases/onboard_usecase.dart';
import '../../authentication/presentation/bloc/authentication_bloc.dart';
import '../../movies/data/datasources/movies_local_datasource.dart';
import '../../movies/data/datasources/movies_remote_datasource.dart';
import '../../movies/data/repositories/movies_repository_impl.dart';
import '../../movies/domain/repositories/movies_repository.dart';
import '../../movies/domain/usecases/get_account_states_usecase.dart';
import '../../movies/domain/usecases/get_credits_usecase.dart';
import '../../movies/domain/usecases/get_details_usecase.dart';
import '../../movies/domain/usecases/get_movies_usecase.dart';
import '../../movies/domain/usecases/get_recommendations_usecase.dart';
import '../../movies/domain/usecases/get_trailer_usecase.dart';
import '../../movies/presentation/bloc/movies_bloc.dart';
import '../../search/data/datasources/search_remote_datasource.dart';
import '../../search/data/repositories/search_repository_impl.dart';
import '../../search/domain/repositories/search_repository.dart';
import '../../search/domain/usecases/search_movies_usecase.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

// feature - Authentication - Movie_Browsing
Future<void> init() async {
  // bloc
  sl.registerFactory(() => AuthenticationBloc(
      loginUseCase: sl(),
      guestLoginUseCase: sl(),
      getUserDetailsUsecase: sl(),
      logoutUseCase: sl(),
      addToWatchListUsecase: sl(),
      getWatchListUsecase: sl(),
      checkOnBoardUseCase: sl(),
      addRatingUsecase: sl(),
      deleteRatingUsecase: sl(),
      onBoardUseCase: sl()));
  sl.registerFactory(() => MoviesBloc(
      getRecommendationsUseCase: sl(),
      getCreditsUseCase: sl(),
      getMoviesUseCase: sl(),
      getTrailerUseCase: sl(),
      getAccountStatesUsecase: sl(),
      getMovieDetailsUseCase: sl()));

  // sl.registerFactory(() => SearchBloc(searchMoviesUsecase: sl()));
  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GuestLoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckOnBoardUseCase(sl()));
  sl.registerLazySingleton(() => OnBoardUseCase(sl()));
  sl.registerLazySingleton(() => AddToWatchListUsecase(sl()));
  sl.registerLazySingleton(() => GetWatchListUsecase(sl()));
  sl.registerLazySingleton(() => AddRatingUsecase(sl()));
  sl.registerLazySingleton(() => DeleteRatingUsecase(sl()));
  sl.registerLazySingleton(() => GetUserDetailsUsecase(sl()));

  sl.registerLazySingleton(() => GetCreditsUseCase(sl()));
  sl.registerLazySingleton(() => GetTrailerUseCase(sl()));
  sl.registerLazySingleton(() => GetMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetRecommendationsUseCase(sl()));
  sl.registerLazySingleton(() => GetAccountStatesUsecase(sl()));
  // sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
  // sl.registerLazySingleton(() => GetUpcomingMoviesUseCase(sl()));

  sl.registerLazySingleton(() => SearchMoviesUsecase(sl()));

  // repositories
  sl.registerLazySingleton<AuthenticationRepo>(
      () => AuthenticationRepoImpl(sl(), sl(), sl()));

  sl.registerLazySingleton<MoviesRepository>(
      () => MoviesRepoImpl(sl(), sl(), sl()));

  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(sl(), sl()));
  //datasource
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteImplWithHttp(sl()));
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalImpl(sl()));
  sl.registerLazySingleton<MoviesRemoteDatasource>(
      () => MoviesRemoteImplWithHttp(sl()));
  sl.registerLazySingleton<MoviesLocalDatasource>(() => MoviesLocalImpl(sl()));

  sl.registerLazySingleton<SearchRemoteDatasource>(
      () => SearchRemoteDatasourceImpl(sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
