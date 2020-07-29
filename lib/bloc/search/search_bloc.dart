import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());
  QuerySnapshot userList;
  List<DocumentSnapshot> sortedList;
  List<DocumentSnapshot> users;
  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is GetUserList) {
      yield FetchingUser();
      userList = await repository.remoteApis.getUserList();
      users = userList.documents
          .where((element) =>
              element.data['username'] != repository.queries.username)
          .toList();
      yield FetchedUserList(list: users);
    }
    if (event is GetUser) {
      // yield FetchingUser();
      sortedList = users
          .where((element) => element.data['username']
              .toLowerCase()
              .contains(event.query.toLowerCase()))
          .toList();
      yield FetchedUserList().copyWith(ulist: sortedList ?? []);
    }
  }
}
