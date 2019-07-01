import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key key}) : super(key: key);

  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    final TextStyle _defaultTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: Theme.of(context).primaryColor,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'About Us',
          style: _defaultTextStyle,
        ),
        centerTitle: true,
      ),
      body: _mainComponents(),
    );
  }

  Widget _mainComponents() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        backgroundGradient(),
        _contentComponents(),
      ],
    );
  }

  Widget _contentComponents() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          logo(),
          appName(),
          SizedBox(
            height: 15.0,
          ),
          _aboutUs(),
          _aboutUsContent(),
          _divider(),
          _ourMission(),
          _ourMissionContent(),
          _divider(),
          _ourVision(),
          _ourVisionContent(),
          _divider(),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
      height: 3.0,
      width: MediaQuery.of(context).size.width / 1.15,
      color: Theme.of(context).accentColor,
    );
  }

  Widget _aboutUs() {
    return Container(
      padding: EdgeInsets.only(bottom: 15.0),
      child: Text(
        'About Ayuda',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 28,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _aboutUsContent() {
    return Container(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Text(
        'Hi eveyone, my name is Alvin J. Quezon, I am the sole programmer of this app called Ayuda in which you can find professional service in your community.  My goal to this app to give everyone access to professional services no matter where you on the go.  I\'ve been started this project since 2017 to address those issues to anyone who are in-need of urgent professional service at anytime you want with top-notch service.  \n\nI also want to give a chance to everybody who want a job.  The number 1 problem here in Philippines is lack of job which is why I want to address this in order to reduce poverty in our country.',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Theme.of(context).primaryColor,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _ourMission() {
    return Container(
      padding: EdgeInsets.only(bottom: 15.0),
      child: Text(
        'Our Mission',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 28,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _ourMissionContent() {
    return Container(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Text(
        'Our mission is to give access to all people to all available services around the community with full satisfaction.  We also want to give every people opportunity to get a job based on what skills they have with full commitment to satisfy it\'s customers.',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Theme.of(context).primaryColor,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _ourVision() {
    return Container(
      padding: EdgeInsets.only(bottom: 15.0),
      child: Text(
        'Our Vision',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 28,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _ourVisionContent() {
    return Container(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Text(
        'Our vision is to create a world that everyone is accessible to any services anywhere at anytime you want.  I want to give every person a job based on their specific professions to sustain their needs.',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Theme.of(context).primaryColor,
        ),
        textAlign: TextAlign.justify,
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

  Widget appName() {
    return Container(
      alignment: Alignment.center,
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Text(
        'AYUDA',
        style: TextStyle(
          fontFamily: 'Gafata',
          fontSize: 50,
          color: Color.fromRGBO(127, 207, 209, 1.0),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget backgroundGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(44, 88, 113, 1.0),
            Color.fromRGBO(71, 145, 152, 1.0)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
