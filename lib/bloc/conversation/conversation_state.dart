part of 'conversation_bloc.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();
}

class ConversationInitial extends ConversationState {
  @override
  List<Object> get props => [];
}

class FetchedConversations extends ConversationState {
  final Stream<QuerySnapshot> convos;

  FetchedConversations(this.convos);
  @override
  List<Object> get props => [convos];
}

class FetchingConversations extends ConversationState {
  @override
  List<Object> get props => [];
}
