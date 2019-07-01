import 'package:flutter/material.dart';

class AuthProvider extends InheritedWidget {
  AuthProvider({Key key, this.child}) : super(key: key, child: child);

  final Widget child;

  static AuthProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AuthProvider) as AuthProvider);
  }

  @override
  bool updateShouldNotify(AuthProvider oldWidget) {
    return true;
  }
}
