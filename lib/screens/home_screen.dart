import 'package:chat_app/bloc/chats/chats_bloc.dart';
import 'package:chat_app/bloc/conversation/conversation_bloc.dart';
import 'package:chat_app/bloc/search/search_bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/log_out.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<ConversationBloc>(context).add(GetConversations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Chat'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.power_settings_new),
              onPressed: () => logOut(context),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          onPressed: () {
            BlocProvider.of<SearchBloc>(context).add(GetUserList());
            Navigator.of(context).pushNamed(searchRoute);
          },
        ),
        body: BlocBuilder<ConversationBloc, ConversationState>(
          builder: (context, state) {
            if (state is FetchingConversations) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FetchedConversations) {
              return StreamBuilder<QuerySnapshot>(
                  stream: state.convos,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            itemCount: snapshot.data.documents.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                endIndent: 20,
                                indent: 70,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  child: Text(snapshot
                                      .data.documents[index].data['chatroomId']
                                      .replaceAll('_', '')
                                      .replaceAll(
                                          repository.queries.username, '')
                                      .substring(0, 1)),
                                ),
                                title: Text(snapshot
                                    .data.documents[index].data['chatroomId']
                                    .replaceAll('_', '')
                                    .replaceAll(
                                        repository.queries.username, '')),
                                onTap: () {
                                  BlocProvider.of<ChatsBloc>(context).add(
                                      GetChats(snapshot.data.documents[index]
                                          .data['chatroomId']
                                          .replaceAll('_', '')
                                          .replaceAll(
                                              repository.queries.username,
                                              '')));
                                  Navigator.of(context).pushNamed(chatsRoute,
                                      arguments: snapshot.data.documents[index]
                                          .data['chatroomId']
                                          .replaceAll('_', '')
                                          .replaceAll(
                                              repository.queries.username, ''));
                                },
                              );
                            },
                          )
                        : Container();
                  });
            }
            return Container();
          },
        ));
  }
}
