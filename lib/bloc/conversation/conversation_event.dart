part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();
}

class GetConversations extends ConversationEvent {
  @override
  List<Object> get props => [];
}
