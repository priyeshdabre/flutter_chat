import 'package:chat_app/bloc/chats/chats_bloc.dart';
import 'package:chat_app/bloc/search/search_bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select contact'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 10,
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is FetchingUser) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FetchedUserList) {
                  return ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: CircleAvatar(
                        child: Text(
                            state.list[index].data['username'].substring(0, 1)),
                      ),
                      title: Text(state.list[index].data['username']),
                      subtitle: Text(state.list[index].data['email']),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.message,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          repository.remoteApis.createChatroom(
                              repository.queries.username,
                              state.list[index].data['username']);
                          BlocProvider.of<ChatsBloc>(context).add(
                              GetChats(state.list[index].data['username']));
                          Navigator.of(context).pushNamed(chatsRoute,
                              arguments: state.list[index].data['username']);
                        },
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  onChanged: (value) =>
                      BlocProvider.of<SearchBloc>(context).add(GetUser(value)),
                  decoration: InputDecoration(
                      hintText: 'Search',
                      icon: Icon(Icons.search),
                      border: InputBorder.none),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
