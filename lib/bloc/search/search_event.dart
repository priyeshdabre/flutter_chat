part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class GetUserList extends SearchEvent {
  @override
  List<Object> get props => [];
}

class GetUser extends SearchEvent {
  final String query;

  GetUser(this.query);
  @override
  List<Object> get props => [];
}
