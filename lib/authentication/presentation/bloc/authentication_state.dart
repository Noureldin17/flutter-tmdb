part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class LoginSuccessState extends AuthenticationState {}

class LoginLoadingState extends AuthenticationState {}

class LogoutLoadingState extends AuthenticationState {}

class GuestLoginSuccessState extends AuthenticationState {}

class GuestLogoutSuccessState extends AuthenticationState {}

class LogoutSuccessState extends AuthenticationState {}

class LoginErrorState extends AuthenticationState {
  final String message;

  const LoginErrorState(this.message);
}

class LogoutErrorState extends AuthenticationState {
  final String message;

  const LogoutErrorState(this.message);
}

class GuestLoginErrorState extends AuthenticationState {
  final String message;

  const GuestLoginErrorState(this.message);
}

class LoginStatesCheckedState extends AuthenticationState {
  final bool isOnBoard;
  final bool keepSignedIn;

  const LoginStatesCheckedState(this.isOnBoard, this.keepSignedIn);
}

class KeepSignedInCheckedState extends AuthenticationState {
  final bool keepSignedIn;

  const KeepSignedInCheckedState(this.keepSignedIn);
}

class WatchListSuccess extends AuthenticationState {
  final List<Movie> watchList;

  const WatchListSuccess(this.watchList);
}

class WatchListLoading extends AuthenticationState {}

class WatchListError extends AuthenticationState {
  final String message;

  const WatchListError(this.message);
}

class AddToWatchListSuccess extends AuthenticationState {
  final bool value;

  const AddToWatchListSuccess(this.value);
}

class AddToWatchListError extends AuthenticationState {
  final String message;

  const AddToWatchListError(this.message);
}

class AddToWatchListLoading extends AuthenticationState {}

class AddRatingSuccess extends AuthenticationState {}

class AddRatingError extends AuthenticationState {
  final String message;

  const AddRatingError(this.message);
}

class DeleteRatingError extends AuthenticationState {
  final String message;

  const DeleteRatingError(this.message);
}

class DeleteRatingSuccess extends AuthenticationState {}

class UserDetailsSuccess extends AuthenticationState {
  final TMDBUser user;

  const UserDetailsSuccess(this.user);
}

class UserDetailsLoading extends AuthenticationState {}

class UserDetailsError extends AuthenticationState {
  final String message;

  const UserDetailsError(this.message);
}
