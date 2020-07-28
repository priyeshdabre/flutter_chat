part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class FetchingUser extends SearchState {
  @override
  List<Object> get props => [];
}

// class FetchedUser extends SearchState {
//   @override
//   List<Object> get props => [];
// }

class FetchedUserList extends SearchState {
  final List<DocumentSnapshot> list;

  FetchedUserList({this.list});

  FetchedUserList copyWith({ulist}) => FetchedUserList(list: ulist);

  @override
  List<Object> get props => [list];
}
