part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class OnRegisterButtonTapped extends RegisterEvent {
  final String email;
  final String password;

  OnRegisterButtonTapped(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}
