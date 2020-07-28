part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class OnRegisterButtonTapped extends RegisterEvent {
  final String email;
  final String password;
  final String name;
  OnRegisterButtonTapped(this.email, this.password, this.name);
  @override
  List<Object> get props => [email, password];
}
