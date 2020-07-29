import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc() : super(ChatsInitial());

  @override
  Stream<ChatsState> mapEventToState(
    ChatsEvent event,
  ) async* {
    if (event is GetChats) {
      yield FetchingChatsInProgress();
      final response = repository.remoteApis
          .getChats(repository.queries.username, event.user2);
      yield FetchedChats(response);
    }
    // if (event is SendChat) {
    //   yield SentChatState();
    // }
  }
}
