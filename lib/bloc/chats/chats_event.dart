part of 'chats_bloc.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();
}

class GetChats extends ChatsEvent {
  final String user2;

  GetChats(this.user2);
  @override
  List<Object> get props => [user2];
}

// class SendChat extends ChatsEvent {
//   @override
//   List<Object> get props => [];
// }
