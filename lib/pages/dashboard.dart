import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fuegosoft_ayuda_services/animations/screen_transitions/screen_pop.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'pages.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Google maps
  Completer<GoogleMapController> _controller = Completer();
  // remove this and use gps system instead
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(10.320177, 123.899788), zoom: 18.0);
  final String tagLineFamily = 'Gafata';

  // search text controller
  var _searchText = TextEditingController();

  // drawer key
  final GlobalKey<ScaffoldState> _scaffoldDrawerKey =
      GlobalKey<ScaffoldState>();

  bool onPressedViewAllContractor = false;

  @override
  void initState() {
    super.initState();

    // when init, fetch data from firebase
    // and fetch if there are any uploaded
    // picture from user, if not then put
    // default picture instead.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldDrawerKey,
      drawer: _menuDrawer(),
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          _ayudaMapComponents(),
          _appBar(),
        ],
      ),
      bottomSheet: _bottomViewComponents(),
    );
  }

  Widget _appBar() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [BoxShadow(color: Colors.transparent)],
        ),
        child: Center(
          child: _searchTextField(),
        ),
      ),
    );
  }

  Widget _searchTextField() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      alignment: Alignment.center,
      height: 50,
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            spreadRadius: 0.25,
            offset: Offset(0.5, 0.5),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(
          width: 1.0,
          color: Colors.black26.withOpacity(0.3),
        ),
      ),
      child: TextField(
        cursorColor: Theme.of(context).backgroundColor,
        style: TextStyle(
          fontFamily: tagLineFamily,
          fontSize: 16,
          color: Theme.of(context).backgroundColor,
          fontWeight: FontWeight.w600,
        ),
        controller: _searchText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Need a Contractor?',
          hintStyle: TextStyle(
            color: Theme.of(context).backgroundColor,
          ),
          icon: _baseMenuIcon(),
        ),
      ),
    );
  }

  Widget _baseMenuIcon() {
    return Container(
      height: 50,
      width: 60,
      child: Row(
        children: <Widget>[
          _menuIconButton(),
          _separator(),
        ],
      ),
    );
  }

  Widget _separator() {
    return Text(
      '|',
      style: TextStyle(
        color: Colors.black26.withOpacity(0.1),
        fontSize: 25,
      ),
    );
  }
  /* menu drawers */

  Widget _menuDrawer() {
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: _drawerComponents(),
      ),
    );
  }

  Widget _drawerComponents() {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: <Widget>[
        _drawerHeader(),
        _profileSetting(
            'assets/settings/profile.png', 'Profile', _goToUserProfileSettings),
        _profileSetting(
            'assets/settings/promo.png', 'Promo', _goToPromoSettings),
        _profileSetting('assets/settings/history.png', 'History', _goToHistory),
        _drawSettingsDivider(),
        _profileSetting(
            'assets/settings/contacts.png', 'Contacts', _goToContacts),
        _profileSetting(
            'assets/settings/setting.png', 'Settings', _goToSettings),
        _profileSetting('assets/settings/info.png', 'About Us', _goToAboutUs),
        _drawSettingsDivider(),
        _profileSetting('assets/settings/worker.png', 'Be a Contractor!',
            _goToBeAContractor),
        _drawSettingsDivider(),
        _profileSetting('assets/settings/logout.png', 'Logout', _logout),
      ],
    );
  }

  Widget _drawSettingsDivider() {
    return Container(
      height: 5,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Divider(
        color: Colors.blueGrey,
      ),
    );
  }

  Widget _profileSetting(String image, String text, Function callback) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Image.asset(
              image,
              height: 35,
              width: 35,
              color: Theme.of(context).backgroundColor,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).backgroundColor, fontSize: 18),
            ),
          ],
        ),
        onPressed: callback,
      ),
    );
  }

  // Drawer header
  Widget _drawerHeader() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _drawerHeaderBG(),
        _drawerHeaderBottomLineColors(),
        _drawerMainComponents()
      ],
    );
  }

  Widget _drawerMainComponents() {
    return Container(
      padding: EdgeInsets.only(left: 25.0),
      alignment: Alignment.centerLeft,
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: _profileComponents(),
    );
  }

  Widget _profileComponents() {
    return Row(
      children: <Widget>[
        _profilePicture(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _profileName(),
            _profileUsername(),
          ],
        )
      ],
    );
  }

  Widget _profileName() {
    // fetch real name on file base
    return Container(
      padding: EdgeInsets.only(
        left: 25,
        bottom: 5,
      ),
      child: Text(
        'Juan dela Cruz',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 25,
          fontFamily: tagLineFamily,
          shadows: [
            Shadow(
              color: Colors.black26.withOpacity(0.5),
              blurRadius: 2.0,
              offset: Offset(3, 3),
            )
          ],
        ),
      ),
    );
  }

  Widget _profileUsername() {
    return Container(
      padding: EdgeInsets.only(
        left: 25,
        bottom: 5,
      ),
      child: Text(
        '@' + 'username',
        style: TextStyle(
          fontFamily: tagLineFamily,
          fontSize: 20,
          color: Theme.of(context).buttonColor,
          shadows: [
            Shadow(
              color: Colors.black26.withOpacity(0.5),
              blurRadius: 2.0,
              offset: Offset(3, 3),
            )
          ],
        ),
      ),
    );
  }

  Widget _profilePicture() {
    return Container(
      height: 75,
      width: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey.withOpacity(0.5),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1.5,
        ),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/profile/man.png',
          ),
        ),
      ),
    );
  }

  // drawer color headers
  Widget _drawerHeaderBottomLineColors() {
    return Container(
      alignment: Alignment.topCenter,
      height: 12.5,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _headerColor1(),
          _headerColor2(),
          _headerColor3(),
          _headerColor4(),
        ],
      ),
    );
  }

  Widget _headerColor1() {
    return Expanded(
      child: Container(
        height: 15,
        width: MediaQuery.of(context).size.width / 4,
        color: Theme.of(context).backgroundColor,
      ),
    );
  }

  Widget _headerColor2() {
    return Expanded(
      child: Container(
        height: 15,
        width: MediaQuery.of(context).size.width / 4,
        color: Theme.of(context).accentColor,
      ),
    );
  }

  Widget _headerColor3() {
    return Expanded(
      child: Container(
        height: 15,
        width: MediaQuery.of(context).size.width / 4,
        color: Theme.of(context).buttonColor,
      ),
    );
  }

  Widget _headerColor4() {
    return Expanded(
      child: Container(
        height: 15,
        width: MediaQuery.of(context).size.width / 4,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _drawerHeaderBG() {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/drawer_header/drawer_header_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _menuIconButton() {
    return IconButton(
      onPressed: _openMenuDrawer,
      icon: Image.asset(
        'assets/icon_buttons/icon_button_settings.png',
        color: Theme.of(context).backgroundColor,
        height: 25,
        width: 25,
      ),
    );
  }

  void _openMenuDrawer() {
    _scaffoldDrawerKey.currentState.openDrawer();
  }

  /* bottom view */

  Widget _bottomViewComponents() {
    return Stack(
      children: <Widget>[
        _bottomBG(),
        _headerColors(),
        _bottomViewMainComponents(),
      ],
    );
  }

  Widget _bottomViewMainComponents() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _arrowUpViewAll(),
          _infoNearByComponent(),
          _countResultComponents(),
        ],
      ),
    );
  }

  Widget _arrowUpViewAll() {
    return Container(
      height: 120,
      width: 60,
      child: IconButton(
        icon: Icon(
            !onPressedViewAllContractor
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
            color: Colors.blueGrey),
        onPressed: _onPressedViewAllContractor,
      ),
    );
  }

  Widget _infoNearByComponent() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 120,
      width: MediaQuery.of(context).size.width / 1.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _textNearBy(),
          _listOfContractorByProfessionNearBy(),
        ],
      ),
    );
  }

  Widget _textNearBy() {
    return Text(
      'Nearby',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 18,
        fontFamily: tagLineFamily,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _listOfContractorByProfessionNearBy() {
    // fetch on live data
    // this is only test

    List<String> _listOfContractorByProfession = [];
    for (int i = 0; i < 10; i++) {
      _listOfContractorByProfession.add("Contractor" + i.toString());
    }
    _listOfContractorByProfession.join(", ");
    return Text(
      _listOfContractorByProfession
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", ""),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.blueGrey,
        fontSize: 15,
      ),
    );
  }

  Widget _countResultComponents() {
    return Container(
      height: 120,
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _totalFoundResult(),
          _textResult(),
        ],
      ),
    );
  }

  Widget _textResult() {
    return Text(
      'Found',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.blueGrey,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _totalFoundResult() {
    // must count from the live data
    return Text(
      '109', // this must be taken from the live data
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // header color bg

  Widget _headerColors() {
    return Container(
      alignment: Alignment.topCenter,
      height: 15,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _color1(),
          _color2(),
          _color3(),
          _color4(),
        ],
      ),
    );
  }

  Widget _color1() {
    return Container(
      height: 15,
      width: MediaQuery.of(context).size.width / 4,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
        ),
      ),
    );
  }

  Widget _color2() {
    return Container(
      height: 15,
      width: MediaQuery.of(context).size.width / 4,
      color: Theme.of(context).accentColor,
    );
  }

  Widget _color3() {
    return Container(
      height: 15,
      width: MediaQuery.of(context).size.width / 4,
      color: Theme.of(context).buttonColor,
    );
  }

  Widget _color4() {
    return Container(
      height: 15,
      width: MediaQuery.of(context).size.width / 4,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
        ),
      ),
    );
  }

  Widget _bottomBG() {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(15.0),
          topRight: const Radius.circular(15.0),
        ),
      ),
    );
  }

  // Google Maps

  Widget _ayudaMapComponents() {
    return Stack(
      children: <Widget>[
        _ayudaMap(),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _filterMapSettings(),
            _getMyLocation(),
          ],
        )
      ],
    );
  }

  Widget _getMyLocation() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        height: 195,
        width: 75,
        alignment: Alignment.topRight,
        padding: EdgeInsets.only(right: 10.0),
        child: Container(
          height: 50,
          width: 50,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            child: Image.asset(
              'assets/google_maps_icon/icons-gps.png',
              color: Theme.of(context).backgroundColor,
            ),
            onPressed: _getMyCurrentLocation,
          ),
        ),
      ),
    );
  }

  Widget _filterMapSettings() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        height: 55,
        width: 75,
        alignment: Alignment.topRight,
        padding: EdgeInsets.only(right: 10.0),
        child: Container(
          height: 50,
          width: 50,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            child: Image.asset(
              'assets/google_maps_icon/icons-filter-map.png',
              color: Theme.of(context).backgroundColor,
            ),
            onPressed: _getFilterMapSettings,
          ),
        ),
      ),
    );
  }

  Widget _ayudaMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: _initialPosition,
    );
  }

  // Google Maps controller
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onPressedViewAllContractor() {
    setState(() {
      onPressedViewAllContractor = !onPressedViewAllContractor;
    });
  }

  /* Map settings */
  Widget _ayudaMapSettings(String image, String text, Function callback) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Image.asset(
              image,
              height: 30,
              width: 30,
              color: Theme.of(context).backgroundColor,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).backgroundColor, fontSize: 18),
            ),
          ],
        ),
        onPressed: callback,
      ),
    );
  }

  void _getMyCurrentLocation() {
    print('get my location is pressed!');
  }

  void _getFilterMapSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            color: Colors.white,
          ),
          height: 215,
          child: Column(
            children: <Widget>[
              _headerColors(),
              _ayudaMapSettings(
                  'assets/settings/plus.png', 'Add Stop', _goToAddStop),
              _ayudaMapSettings('assets/settings/share-symbol.png',
                  'Share Location', _goToShareYourLocation),
              _ayudaMapSettings('assets/settings/layers.png',
                  'Satellite & Traffic', _goToSatelliteAndTraffic),
              _ayudaMapSettings(
                  'assets/settings/cancel.png', 'Cancel', _cancel),
            ],
          ),
        );
      },
    );
  }

  void _goToUserProfileSettings() {
    Navigator.of(context).pop();
    Navigator.push(context, ScaleRoute(widget: Profile()));
  }

  void _goToPromoSettings() {
    print('go to promo settings!');
  }

  void _goToHistory() {
    print('go to history!');
  }

  void _goToContacts() {
    print('go to contacts!');
  }

  void _goToSettings() {
    print('go to settings!');
  }

  void _goToAboutUs() {
    Navigator.of(context).pop();
    Navigator.push(context, ScaleRoute(widget: AboutUs()));
  }

  void _goToBeAContractor() {
    print('go to contractor registration');
  }

  void _logout() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  /* bottom sheet settings */

  void _goToAddStop() {
    print('go to add stop!');
  }

  void _goToShareYourLocation() {
    print('go to share your location!');
  }

  void _goToSatelliteAndTraffic() {
    print('go to satellite and traffic settings');
  }

  void _cancel() {
    Navigator.pop(context);
  }
}
