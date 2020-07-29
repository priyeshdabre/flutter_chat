part of 'chats_bloc.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();
}

class ChatsInitial extends ChatsState {
  @override
  List<Object> get props => [];
}

class FetchingChatsInProgress extends ChatsState {
  @override
  List<Object> get props => [];
}

class FetchedChats extends ChatsState {
  final Stream<QuerySnapshot> chats;

  FetchedChats(this.chats);
  @override
  List<Object> get props => [chats];
}

// class SentChatState extends ChatsState {
//   @override
//   List<Object> get props => [];
// }
