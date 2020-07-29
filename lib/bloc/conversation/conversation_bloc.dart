import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(ConversationInitial());

  @override
  Stream<ConversationState> mapEventToState(
    ConversationEvent event,
  ) async* {
    if (event is GetConversations) {
      yield FetchingConversations();
      final convos = repository.remoteApis.getConversations();
      yield FetchedConversations(convos);
    }
  }
}
