import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuegosoft_ayuda_services/animations/screen_transitions/screen_pop.dart';

import 'pages.dart';

class Landing extends StatefulWidget {
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  double fontSizeTagLine = 25;
  double fontSizeTagLine2 = 40;
  double fontSizeTagLine3 = 28;
  String tagLineFamily = 'Gafata';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: landingContainer(),
    );
  }

  Widget landingContainer() {
    return Stack(
      children: <Widget>[
        blurredBackgroundImage(),
        baseComponents(),
      ],
    );
  }

  Widget baseComponents() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          frontComponents(),
          bottomComponents(),
        ],
      ),
    );
  }

  Widget frontComponents() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          logo(),
          appName(),
          tagLine(),
          learnMoreButton(),
        ],
      ),
    );
  }

  Widget bottomComponents() {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          loginButton(),
          registerButton(),
        ],
      ),
    );
  }

  Widget learnMoreButton() {
    return Container(
      height: 75,
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        child: new Text(
          'Learn More',
          style: TextStyle(
              fontSize: fontSizeTagLine, color: Theme.of(context).primaryColor),
        ),
        onPressed: () {
          print('hala!');
        },
      ),
    );
  }

  Widget registerButton() {
    return Container(
      height: 75,
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        child: Text(
          'Not yet a member? Sign up now!',
          style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
        ),
        onPressed: () {
          Navigator.push(context, ScaleRoute(widget: Register()));
        },
      ),
    );
  }

  Widget loginButton() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(35),
      ),
      height: 75,
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        child: Text(
          'Sign In',
          style: TextStyle(
              fontSize: fontSizeTagLine, color: Theme.of(context).primaryColor),
        ),
        onPressed: () {
          Navigator.push(context, ScaleRoute(widget: Login()));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
    );
  }

  Widget appName() {
    return Container(
      alignment: Alignment.center,
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Text(
        'AYUDA',
        style: TextStyle(
          fontFamily: tagLineFamily,
          fontSize: 50,
          color: Color.fromRGBO(127, 207, 209, 1.0),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget tagLine() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Column(
        children: <Widget>[
          taglineFirstLine(),
          taglineSecondLine(),
          SizedBox(
            height: 10,
          ),
          taglineThirdLine(),
          taglineForthLine(),
          taglineLast(),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  Widget taglineFirstLine() {
    return Container(
      height: 28,
      width: MediaQuery.of(context).size.width,
      child: Text(
        'Can’t fix your own?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSizeTagLine,
          fontFamily: tagLineFamily,
        ),
      ),
    );
  }

  Widget taglineSecondLine() {
    return Container(
      height: 28,
      width: MediaQuery.of(context).size.width,
      child: Text(
        'Need assistance?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSizeTagLine,
          fontFamily: tagLineFamily,
        ),
      ),
    );
  }

  Widget taglineThirdLine() {
    return Container(
      height: 28,
      width: MediaQuery.of(context).size.width,
      child: Text(
        'Finding professional assistance',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: fontSizeTagLine,
          fontFamily: tagLineFamily,
        ),
      ),
    );
  }

  Widget taglineForthLine() {
    return Container(
      height: 28,
      width: MediaQuery.of(context).size.width,
      child: Text(
        'was never been this so',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: fontSizeTagLine,
          fontFamily: tagLineFamily,
        ),
      ),
    );
  }

  Widget taglineLast() {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: Text(
        'easy!',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: fontSizeTagLine2,
          fontWeight: FontWeight.w700,
          fontFamily: tagLineFamily,
        ),
      ),
    );
  }

  Widget logo() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 25),
        child: CircleAvatar(
          backgroundColor: Colors.black.withOpacity(0.5),
          radius: 100,
          child: Image.asset(
            'assets/logo/logo.png',
            height: 120,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }

  Widget blurredBackgroundImage() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).backgroundColor,
            Theme.of(context).primaryColor
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(51, 57, 52, 0.5),
          ),
        ),
      ),
    );
  }
}
