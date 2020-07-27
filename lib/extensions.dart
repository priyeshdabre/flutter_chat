import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///extensions on String
extension StringExtensions on String {
  ///to check if Email is valid.
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }
}

extension GetPadding on double {
  EdgeInsets get addPadding {
    return EdgeInsets.all(this);
  }
}

extension ShowSnackBar on String {
  SnackBar get showSnackBar {
    return SnackBar(
      content: Text(this),
      behavior: SnackBarBehavior.floating,
    );
  }
}
