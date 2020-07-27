import 'package:flutter/material.dart';
import 'constants.dart';
import 'main.dart';

Future<void> logOut(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.black),
          ),
          content: Text(
            'Are you sure you want to Logout?',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop(true);
                await repository.queries.deleteSettingsData();
                RestartWidget.restartApp(context);
              },
            ),
          ],
        );
      });
}
