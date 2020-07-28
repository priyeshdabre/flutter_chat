import 'package:flutter/material.dart';

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
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    child: Text('A'),
                  ),
                  title: Text('Apha Chemist'),
                  subtitle: Text('alphaexample.com'),
                  trailing:
                      IconButton(icon: Icon(Icons.message), onPressed: null),
                ),
              )),
          Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
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
