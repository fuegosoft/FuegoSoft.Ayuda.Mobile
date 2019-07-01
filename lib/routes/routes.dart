import 'package:flutter/widgets.dart';
import 'package:fuegosoft_ayuda_services/pages/pages.dart';

final routes = {
  '/': (BuildContext context) => Landing(),
  '/register': (BuildContext context) => Register(),
  '/login': (BuildContext context) => Login(),
  '/dashboard': (BuildContext context) => Dashboard()
};
