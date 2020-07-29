import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
    debugPrint('bloc: ${cubit.runtimeType}, error: $error');
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    debugPrint('bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('bloc: ${bloc.runtimeType}, transition: $transition');
  }
}
