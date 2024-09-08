part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthenticationEvent {
  final String username, password;
  final bool keepMeSignedIn;

  const LoginEvent(this.username, this.password, this.keepMeSignedIn);

  @override
  List<Object> get props => [username, password];
}

class GuestLoginEvent extends AuthenticationEvent {}

class LogoutEvent extends AuthenticationEvent {}

class OnBoardEvent extends AuthenticationEvent {}

class CheckLoginStatesEvent extends AuthenticationEvent {}

class CheckKeepSignedInEvent extends AuthenticationEvent {}

class GetUserDetailsEvent extends AuthenticationEvent {}

class AddToWatchListEvent extends AuthenticationEvent {
  final int movieId;
  final bool value;

  const AddToWatchListEvent(this.movieId, this.value);
}

class GetWatchListEvent extends AuthenticationEvent {}

class AddRatingEvent extends AuthenticationEvent {
  final int movieId;
  final num value;

  const AddRatingEvent(this.movieId, this.value);
}

class DeleteRatingEvent extends AuthenticationEvent {
  final int movieId;

  const DeleteRatingEvent(this.movieId);
}
