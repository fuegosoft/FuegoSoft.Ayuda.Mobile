import 'package:flutter/material.dart';
import 'dart:math' as math;

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String _gafata = 'Gafata';
  String _countryDefaultValue = 'Philippines';
  bool onTapSave = false;
  final GlobalKey<ScaffoldState> _profileScaffoldKey =
      GlobalKey<ScaffoldState>();

  var _usernameTextEditing = TextEditingController();
  var _emailAddressTextEditing = TextEditingController();

  var _firstNameTextEditing = TextEditingController();
  var _middleNameTextEditing = TextEditingController();
  var _lastNameTextEditing = TextEditingController();

  var _streetAddressLine1TextEditing = TextEditingController();
  var _streetAddressLine2TextEditing = TextEditingController();
  var _cityTextEditing = TextEditingController();
  var _provinceTextEditing = TextEditingController();
  var _postalCodeTextEditing = TextEditingController();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailAddressFocus = FocusNode();

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _middleNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();

  final FocusNode _streetAddressLine1Focus = FocusNode();
  final FocusNode _streetAddressLine2Focus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _provinceFocus = FocusNode();
  final FocusNode _postalCodeFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _profileScaffoldKey,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildProfileSliverAppBar(),
          makeHeader(
            headerText: 'Account',
            leading: Icon(
              Icons.account_circle,
              color: Theme.of(context).primaryColor,
            ),
          ),
          _buildAccountComponents(),
          makeHeader(
            headerText: 'Full Name',
            leading: Icon(
              Icons.person_outline,
              color: Theme.of(context).primaryColor,
            ),
          ),
          _buildProfileListComponents(),
          makeHeaderWithTrailing(
            headerText: 'Address',
            leading: Icon(
              Icons.map,
              color: Theme.of(context).primaryColor,
            ),
            trailing: Container(
              padding: EdgeInsets.only(right: 15.0),
              height: 50,
              child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: _onGetMyLocation,
                icon: Icon(
                  Icons.my_location,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text(
                  'Locate Me!',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    // fontFamily: tagLineFamily,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          _buildAddressComponents(),
        ],
      ),
    );
  }

  Widget spacer() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget _buildAccountComponents() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          _buildAccount(),
        ],
      ),
    );
  }

  Widget _buildProfileListComponents() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          _buildFullName(),
        ],
      ),
    );
  }

  Widget _buildAddressComponents() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          _buildAddress(),
        ],
      ),
    );
  }

  Widget _buildAccount() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      color: Theme.of(context).backgroundColor,
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          username(),
          spacer(),
          emailAddress(),
        ],
      ),
    );
  }

  Widget _buildFullName() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      color: Theme.of(context).backgroundColor,
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          firstName(),
          spacer(),
          middleName(),
          spacer(),
          lastName(),
        ],
      ),
    );
  }

  Widget _buildAddress() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      color: Theme.of(context).backgroundColor,
      height: 450,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          streetAddressLine1(),
          spacer(),
          streetAddressLine2(),
          spacer(),
          city(),
          spacer(),
          province(),
          spacer(),
          postalCode(),
          spacer(),
          _country(),
        ],
      ),
    );
  }

  Widget username() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
          controller: _usernameTextEditing,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Username',
            hintStyle: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            icon: Text(
              '@',
              style: TextStyle(
                fontSize: 32,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          validator: (String value) {
            // var error = '';
            // if (value.isEmpty) {
            //   error = 'This field is required';
            // }

            // if (error.isNotEmpty) {
            //   setState(() {
            //     hasErrorFirstName = true;
            //     firstNameError = error;
            //   });
            // } else {
            //   hasErrorFirstName = false;
            // }
          },
          onFieldSubmitted: (value) {
            _fieldFocusChange(context, _usernameFocus, _emailAddressFocus);
          },
          keyboardType: TextInputType.text,
          focusNode: _usernameFocus,
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget emailAddress() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            // fontFamily: tagLineFamily,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
          controller: _emailAddressTextEditing,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Email Address',
            hintStyle: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.email,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
          ),
          validator: (String value) {
            // var error = '';
            // if (value.isEmpty) {
            //   error = 'This field is required';
            // }

            // if (error.isNotEmpty) {
            //   setState(() {
            //     hasErrorFirstName = true;
            //     firstNameError = error;
            //   });
            // } else {
            //   hasErrorFirstName = false;
            // }
          },
          onFieldSubmitted: (value) {
            _fieldFocusChange(context, _emailAddressFocus, _firstNameFocus);
          },
          keyboardType: TextInputType.text,
          focusNode: _emailAddressFocus,
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget _buildProfileSliverAppBar() {
    return SliverAppBar(
      actions: <Widget>[
        GestureDetector(
          onTap: _onSaveProfile,
          child: Center(
            child: Container(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                'Save',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: !onTapSave
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ),
      ],
      pinned: true,
      expandedHeight: 300.0,
      elevation: 0.0,
      backgroundColor: Theme.of(context).backgroundColor,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        "Profile Settings",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 25,
        ),
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: _userProfileHeader(),
      ),
    );
  }

  Widget _userProfileHeader() {
    return Container(
      padding: EdgeInsets.only(top: 55),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _profileAvatar(),
          _userFullName(),
          _username(),
          _address(),
        ],
      ),
    );
  }

  Widget _userFullName() {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      height: 30,
      child: Text(
        'Juan dela Cruz',
        textAlign: TextAlign.center,
        style: _profileNameStyle(),
      ),
    );
  }

  Widget _username() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 30,
      child: Text(
        '@juandelacruz',
        textAlign: TextAlign.center,
        style: _usernameStyle(),
      ),
    );
  }

  Widget _address() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 5.0),
        width: 200,
        child: Text(
          'Amorosa St., North Poblacion, Siquijor, Siquijor, 6225, Philippines',
          softWrap: true,
          textAlign: TextAlign.center,
          style: _addressStyle(),
        ),
      ),
    );
  }

  Widget _profileAvatar() {
    return Center(
      child: Container(
        height: 120,
        width: 120,
        child: CircleAvatar(
          backgroundImage: ExactAssetImage(
              'assets/profile/man.png'), // change with live data from firebase
          backgroundColor: Colors.blueGrey,
        ),
      ),
    );
  }

  TextStyle _usernameStyle() {
    return TextStyle(
      color: Theme.of(context).primaryColor.withOpacity(0.5),
      fontFamily: _gafata,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle _addressStyle() {
    return TextStyle(
      color: Theme.of(context).primaryColor.withOpacity(0.5),
      fontFamily: _gafata,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle _profileNameStyle() {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontFamily: _gafata,
      fontSize: 25,
      fontWeight: FontWeight.w600,
    );
  }

  SliverPersistentHeader makeHeader({String headerText, Widget leading}) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 50.0,
        maxHeight: 75.0,
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 20.0,
                ),
                leading,
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  headerText,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverPersistentHeader makeHeaderWithTrailing(
      {String headerText, Widget leading, Widget trailing}) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 50.0,
        maxHeight: 75.0,
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 20.0,
                ),
                leading,
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  headerText,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 10.0,
                  ),
                ),
                trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget firstName() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            // fontFamily: tagLineFamily,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
          controller: _firstNameTextEditing,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'First Name',
            hintStyle: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
          ),
          validator: (String value) {
            // var error = '';
            // if (value.isEmpty) {
            //   error = 'This field is required';
            // }

            // if (error.isNotEmpty) {
            //   setState(() {
            //     hasErrorFirstName = true;
            //     firstNameError = error;
            //   });
            // } else {
            //   hasErrorFirstName = false;
            // }
          },
          onFieldSubmitted: (value) {
            _fieldFocusChange(context, _firstNameFocus, _middleNameFocus);
          },
          keyboardType: TextInputType.text,
          focusNode: _firstNameFocus,
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget middleName() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            // fontFamily: tagLineFamily,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
          controller: _middleNameTextEditing,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Middle Name',
            hintStyle: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
          ),
          onFieldSubmitted: (value) {
            _fieldFocusChange(context, _middleNameFocus, _lastNameFocus);
          },
          keyboardType: TextInputType.text,
          focusNode: _middleNameFocus,
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget lastName() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            // fontFamily: tagLineFamily,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
          controller: _lastNameTextEditing,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Last Name',
            hintStyle: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
          ),
          validator: (String value) {
            var error = '';
            if (value.isEmpty) {
              error = 'This field is required';
            }

            if (error.isNotEmpty) {
              setState(() {
                // hasErrorLastName = true;
                // lastNameError = error;
              });
            } else {
              // hasErrorLastName = false;
            }
          },
          onFieldSubmitted: (value) {
            _fieldFocusChange(
                context, _lastNameFocus, _streetAddressLine1Focus);
          },
          keyboardType: TextInputType.text,
          focusNode: _lastNameFocus,
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget streetAddressLine1() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            // fontFamily: tagLineFamily,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
          controller: _streetAddressLine1TextEditing,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Street Address',
            hintStyle: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
          ),
          validator: (String value) {
            // var error = '';
            // if (value.isEmpty) {
            //   error = 'This field is required';
            // }

            // if (error.isNotEmpty) {
            //   setState(() {
            //     hasErrorFirstName = true;
            //     firstNameError = error;
            //   });
            // } else {
            //   hasErrorFirstName = false;
            // }
          },
          onFieldSubmitted: (value) {
            _fieldFocusChange(
                context, _streetAddressLine1Focus, _streetAddressLine2Focus);
          },
          keyboardType: TextInputType.text,
          focusNode: _streetAddressLine1Focus,
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget streetAddressLine2() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            // fontFamily: tagLineFamily,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
          controller: _streetAddressLine2TextEditing,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Street Address Line 2',
            hintStyle: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
          ),
          validator: (String value) {
            // var error = '';
            // if (value.isEmpty) {
            //   error = 'This field is required';
            // }

            // if (error.isNotEmpty) {
            //   setState(() {
            //     hasErrorFirstName = true;
            //     firstNameError = error;
            //   });
            // } else {
            //   hasErrorFirstName = false;
            // }
          },
          onFieldSubmitted: (value) {
            _fieldFocusChange(context, _streetAddressLine2Focus, _cityFocus);
          },
          keyboardType: TextInputType.text,
          focusNode: _streetAddressLine2Focus,
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget city() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            // fontFamily: tagLineFamily,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
          controller: _cityTextEditing,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'City',
            hintStyle: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
          ),
          validator: (String value) {
            // var error = '';
            // if (value.isEmpty) {
            //   error = 'This field is required';
            // }

            // if (error.isNotEmpty) {
            //   setState(() {
            //     hasErrorFirstName = true;
            //     firstNameError = error;
            //   });
            // } else {
            //   hasErrorFirstName = false;
            // }
          },
          onFieldSubmitted: (value) {
            _fieldFocusChange(context, _cityFocus, _provinceFocus);
          },
          keyboardType: TextInputType.text,
          focusNode: _cityFocus,
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget province() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            // fontFamily: tagLineFamily,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
          controller: _provinceTextEditing,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Province',
            hintStyle: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
          ),
          validator: (String value) {
            // var error = '';
            // if (value.isEmpty) {
            //   error = 'This field is required';
            // }

            // if (error.isNotEmpty) {
            //   setState(() {
            //     hasErrorFirstName = true;
            //     firstNameError = error;
            //   });
            // } else {
            //   hasErrorFirstName = false;
            // }
          },
          onFieldSubmitted: (value) {
            _fieldFocusChange(context, _provinceFocus, _postalCodeFocus);
          },
          keyboardType: TextInputType.text,
          focusNode: _provinceFocus,
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget postalCode() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            // fontFamily: tagLineFamily,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
          controller: _postalCodeTextEditing,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Postal / Zip Code',
            hintStyle: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
          ),
          validator: (String value) {
            // var error = '';
            // if (value.isEmpty) {
            //   error = 'This field is required';
            // }

            // if (error.isNotEmpty) {
            //   setState(() {
            //     hasErrorFirstName = true;
            //     firstNameError = error;
            //   });
            // } else {
            //   hasErrorFirstName = false;
            // }
          },
          onFieldSubmitted: (value) {
            _postalCodeFocus.unfocus();
          },
          keyboardType: TextInputType.text,
          focusNode: _postalCodeFocus,
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }

  Widget _country() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).backgroundColor,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              icon: Icon(
                Icons.place,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            value: _countryDefaultValue,
            onChanged: (String value) {
              setState(() {
                _countryDefaultValue = value;
              });
            },
            items: <String>['Philippines', 'Singapore', 'Hongkong', 'Japan']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    // fontFamily: tagLineFamily,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.none,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _onGetMyLocation() {
    print('get my location is clicked');
  }

  _onSaveProfile() {
    setState(() {
      onTapSave = !onTapSave;
    });

    if (onTapSave) {
      _profileScaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).accentColor,
          content: Text(
            'Your profile has been saved!',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.none,
            ),
          ),
          duration: Duration(seconds: 1, microseconds: 500),
        ),
      );
    }
  }
}

// delegate
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
