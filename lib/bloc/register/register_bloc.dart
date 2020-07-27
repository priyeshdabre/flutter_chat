import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is OnRegisterButtonTapped) {
      yield RegisterInProgress();
      try {
        final response = await repository.remoteApis
            .register(email: event.email, password: event.password);
        if (response.uid != null) {
          yield RegisterSuccess();
        } else {
          yield RegisterFailure();
        }
      } catch (e) {
        yield RegisterFailure();
      }
    }
  }
}
