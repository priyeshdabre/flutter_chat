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
  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is GetUserList) {
      yield FetchingUser();
      userList = await repository.remoteApis.getUserList();
      yield FetchedUserList(list: userList.documents);
    }
    if (event is GetUser) {
      // yield FetchingUser();
      sortedList = userList.documents
          .where((element) => element.data['username'].contains(event.query))
          .toList();
      yield FetchedUserList().copyWith(ulist: sortedList ?? []);
    }
  }
}
