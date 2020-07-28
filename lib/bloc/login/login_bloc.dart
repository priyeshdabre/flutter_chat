import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        final response = await repository.remoteApis
            .login(email: event.email, password: event.password);
        if (response.uid != null) {
          repository.queries.saveToken(token: true);

          yield LoginSuccess();
        } else {
          yield LoginFailure(error: '');
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
    if (event is LoginWithGoogle) {
      yield LoginLoading();
      try {
        final response = await repository.remoteApis.signInwithGoogle();
        if (response.uid != null) {
          repository.queries.saveToken(token: true);
          if (!repository.remoteApis.checkIfUserExist(response.email)) {
            repository.remoteApis
                .uploadUserData(response.email, response.displayName);
          }
          yield LoginSuccess();
        } else {
          yield LoginFailure(error: '');
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
