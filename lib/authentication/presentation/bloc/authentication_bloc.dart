// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/faliures.dart';
import '../../domain/models/login_request_params.dart';
import '../../domain/usecases/add_rating_usecase.dart';
import '../../domain/usecases/add_to_watchlist_usecase.dart';
import '../../domain/usecases/check_onboard_usecase.dart';
import '../../domain/usecases/delete_rating_usecase.dart';
import '../../domain/usecases/get_user_details_usecase.dart';
import '../../domain/usecases/get_watchlist_usecase.dart';
import '../../domain/usecases/guest_login_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/onboard_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase loginUseCase;
  final GuestLoginUseCase guestLoginUseCase;
  final LogoutUseCase logoutUseCase;
  final OnBoardUseCase onBoardUseCase;
  final CheckOnBoardUseCase checkOnBoardUseCase;
  final GetWatchListUsecase getWatchListUsecase;
  final AddToWatchListUsecase addToWatchListUsecase;
  final AddRatingUsecase addRatingUsecase;
  final DeleteRatingUsecase deleteRatingUsecase;
  final GetUserDetailsUsecase getUserDetailsUsecase;
  AuthenticationBloc(
      {required this.loginUseCase,
      required this.guestLoginUseCase,
      required this.checkOnBoardUseCase,
      required this.getUserDetailsUsecase,
      required this.onBoardUseCase,
      required this.addToWatchListUsecase,
      required this.getWatchListUsecase,
      required this.addRatingUsecase,
      required this.deleteRatingUsecase,
      required this.logoutUseCase})
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>(transformer: sequential(), (event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoadingState());
        final response = await loginUseCase.call(LoginRequestParams(
            event.username, event.password, event.keepMeSignedIn));

        response.fold((l) {
          emit(LoginErrorState(_mapErrorToMessage(l)));
        }, (r) {
          emit(LoginSuccessState());
        });
      } else if (event is GuestLoginEvent) {
        emit(LoginLoadingState());
        final response = await guestLoginUseCase.call();

        response.fold((l) => emit(GuestLoginErrorState(_mapErrorToMessage(l))),
            (r) {
          emit(GuestLoginSuccessState());
        });
      } else if (event is LogoutEvent) {
        emit(LogoutLoadingState());
        final response = await logoutUseCase.call();
        response.fold((l) => emit(LogoutErrorState(_mapErrorToMessage(l))),
            (r) => emit(LogoutSuccessState()));
      } else if (event is OnBoardEvent) {
        // ignore: unused_local_variable
        final response = await onBoardUseCase.call();
      } else if (event is CheckLoginStatesEvent) {
        final response = await checkOnBoardUseCase.call();
        response.fold((l) => null, (r) {
          emit(LoginStatesCheckedState(r.isOnboard, r.keepSignedIn));
        });
      } else if (event is GetWatchListEvent) {
        emit(WatchListLoading());
        final response = await getWatchListUsecase.call();

        response.fold((l) => emit(WatchListError(_mapErrorToMessage(l))),
            (r) => emit(WatchListSuccess(r)));
      } else if (event is AddToWatchListEvent) {
        emit(AddToWatchListLoading());

        final response =
            await addToWatchListUsecase.call(event.movieId, event.value);

        response.fold((l) => emit(AddToWatchListError(_mapErrorToMessage(l))),
            (r) {
          emit(AddToWatchListSuccess(event.value));
        });
      } else if (event is AddRatingEvent) {
        final response =
            await addRatingUsecase.call(event.movieId, event.value);
        response.fold((l) => emit(AddRatingError(_mapErrorToMessage(l))),
            (r) => emit(AddRatingSuccess()));
      } else if (event is DeleteRatingEvent) {
        final response = await deleteRatingUsecase.call(event.movieId);
        response.fold((l) => emit(DeleteRatingError(_mapErrorToMessage(l))),
            (r) => emit(DeleteRatingSuccess()));
      } else if (event is GetUserDetailsEvent) {
        emit(UserDetailsLoading());
        final response = await getUserDetailsUsecase.call();
        response.fold((l) => emit(UserDetailsError(_mapErrorToMessage(l))),
            (r) => emit(UserDetailsSuccess(r)));
      }
    });
  }

  String _mapErrorToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "An error has occured with the server";
      case InvalidCredentialsFailure:
        return "Invalid username or password";
      case UnAuthorizedFailure:
        return "Guests are not authorized to access this feature";
      case NetworkFailure:
        return "Connection Error";
      default:
        return "An error has occured ";
    }
  }
}
