import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuegosoft_ayuda_services/routes/routes.dart';

class AyudaApp extends StatefulWidget {
  AyudaApp({Key key}) : super(key: key);

  _AyudaAppState createState() => _AyudaAppState();
}

class _AyudaAppState extends State<AyudaApp> {
  // color theme
  final Color _unselectedColor = Color.fromRGBO(101, 200, 208, 1.0);
  final Color _darkBlue = Color.fromRGBO(44, 88, 113, 1.0);
  final Color _fadeDarkBlue = Color.fromRGBO(71, 145, 152, 1.0);
  final Color _fairLightBlue = Color.fromRGBO(48, 182, 195, 1.0);
  final Color _lightBlue = Color.fromRGBO(101, 200, 208, 1.0);
  final Color _bottomBGColor = Color.fromRGBO(42, 46, 67, 1.0);
  final String _gafata = 'Gafata';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      theme: ThemeData(
        fontFamily: _gafata,
        primaryIconTheme: IconThemeData(color: _lightBlue),
        backgroundColor: _darkBlue,
        accentColor: _fadeDarkBlue,
        primaryColor: _lightBlue,
        cursorColor: _lightBlue,
        errorColor: Colors.amber,
        buttonColor: _fairLightBlue,
        primarySwatch: Colors.lightBlue,
        bottomAppBarColor: _bottomBGColor,
        unselectedWidgetColor: _unselectedColor.withOpacity(0.4),
        canvasColor: Colors.transparent,
      ),
      initialRoute: '/',
      routes: routes,
    );
  }
}
