part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {}

class AppStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  final bool token;

  LoggedIn(this.token);

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
