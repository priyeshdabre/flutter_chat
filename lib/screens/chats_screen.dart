import 'package:chat_app/bloc/chats/chats_bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChatScreen extends HookWidget {
  final String user2;

  const ChatScreen({Key key, this.user2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _messageController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: Row(
        //   children: <Widget>[
        //     IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
        //     CircleAvatar(
        //       radius: 10,
        //       child: Text(user2.substring(0, 1)),
        //     ),
        //   ],
        // ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              constraints: BoxConstraints.tight(Size.fromRadius(20)),
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CircleAvatar(
              radius: 18,
              child: Text(user2.substring(0, 1)),
            ),
            SizedBox(
              width: 10,
            ),
            Text(user2)
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
              flex: 10,
              child: BlocBuilder<ChatsBloc, ChatsState>(
                builder: (context, state) {
                  if (state is FetchingChatsInProgress) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FetchedChats) {
                    return StreamBuilder<QuerySnapshot>(
                        stream: state.chats,
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? ListView.builder(
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, index) => Container(
                                    alignment: snapshot.data.documents[index]
                                                .data['sentBy'] ==
                                            repository.queries.username
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    width: MediaQuery.of(context).size.width,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 16),
                                      decoration: BoxDecoration(
                                          color: snapshot.data.documents[index]
                                                      .data['sentBy'] ==
                                                  repository.queries.username
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey[600],
                                          borderRadius: snapshot
                                                      .data
                                                      .documents[index]
                                                      .data['sentBy'] ==
                                                  repository.queries.username
                                              ? BorderRadius.only(
                                                  topRight: Radius.circular(30),
                                                  topLeft: Radius.circular(30),
                                                  bottomLeft:
                                                      Radius.circular(30))
                                              : BorderRadius.only(
                                                  topRight: Radius.circular(30),
                                                  topLeft: Radius.circular(30),
                                                  bottomRight:
                                                      Radius.circular(30))),
                                      child: Text(
                                        snapshot.data.documents[index]
                                            .data['message'],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                )
                              : Container();
                        });
                  }
                  return Container();
                },
              )),
          Flexible(
            flex: 1,
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 7,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        controller: _messageController,
                        decoration: InputDecoration(
                            hintText: 'Type a message',
                            icon: Icon(Icons.sentiment_satisfied),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        repository.remoteApis.addChats(
                            repository.queries.username,
                            user2,
                            _messageController.text);
                        _messageController.clear();
                      },
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
