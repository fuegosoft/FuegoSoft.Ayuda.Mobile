import 'dart:io';
import 'dart:ui';
import 'package:date_format/date_format.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:fuegosoft_ayuda_services/util/validators/validator.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String tagLineFamily = 'Gafata';
  bool notNull(Object o) => o != null;
  DateTime _initialSelectedBirthDate = DateTime.now();
  String groupGender = '';

  var _formKey = GlobalKey<FormState>();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _middleNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();

  var _username = TextEditingController();
  var _password = TextEditingController();
  var _firstName = TextEditingController();
  var _middleName = TextEditingController();
  var _lastName = TextEditingController();

  // Error flags
  bool hasErrorUsername = false;
  bool hasErrorPassword = false;
  bool hasErrorFirstName = false;
  bool hasErrorLastName = false;
  bool hasErrorBirthDate = false;
  bool hasErrorSelectGender = false;

  // Error message
  String usernameError = '';
  String passwordError = '';
  String firstNameError = '';
  String lastNameError = '';
  String birthDateError = '';
  String selectGenderError = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            iconTheme: IconThemeData(
              color: Theme.of(context).unselectedWidgetColor,
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            floating: false,
            pinned: true,
            snap: false,
            elevation: 0.0,
            flexibleSpace: FlexibleSpaceBar(
              title: appName(),
              background: logo(),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Stack(
                  children: <Widget>[
                    background(),
                    registrationForm(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget spacer() {
    return SizedBox(
      height: 5,
    );
  }

  Widget registrationForm() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Column(
          children: <Widget>[
            usernameTextField(),
            hasErrorUsername ? _errorEmail() : null,
            spacer(),
            passwordText(),
            hasErrorPassword ? _errorPassword() : null,
            spacer(),
            firstName(),
            hasErrorFirstName ? _errorFirstName() : null,
            spacer(),
            middleName(),
            spacer(),
            lastName(),
            hasErrorLastName ? _errorLastName() : null,
            spacer(),
            birthDate(),
            hasErrorBirthDate ? _errorBirthDate() : null,
            spacer(),
            _radioGender(),
            hasErrorSelectGender ? _errorSelectGender() : null,
            spacer(),
            spacer(),
            spacer(),
            _termsAndConditionNotes(),
            spacer(),
            _registerSubmitButton(),
            spacer(),
          ].where(notNull).toList(),
        ),
      ),
    );
  }

  Widget usernameTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).unselectedWidgetColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).unselectedWidgetColor,
          style: TextStyle(
            fontFamily: tagLineFamily,
            fontSize: 25,
            color: Theme.of(context).unselectedWidgetColor,
            fontWeight: FontWeight.w600,
          ),
          controller: _username,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Your Email',
            hintStyle: TextStyle(
              color: Theme.of(context).unselectedWidgetColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.email,
              color: Theme.of(context).unselectedWidgetColor,
              size: 38,
            ),
          ),
          validator: (String value) {
            var error = '';
            if (!isEmail(value)) {
              error = 'Invalid email address format';
            } else if (value.isEmpty || value.length < 5) {
              error = 'Field is required';
            }

            if (error.isNotEmpty) {
              setState(() {
                hasErrorUsername = true;
                usernameError = error;
              });
            } else {
              setState(() {
                hasErrorUsername = false;
              });
            }
          },
          textInputAction: TextInputAction.next,
          focusNode: _usernameFocus,
          onFieldSubmitted: (value) {
            _fieldFocusChange(context, _usernameFocus, _passwordFocus);
          },
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    );
  }

  Widget passwordText() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).unselectedWidgetColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).unselectedWidgetColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: tagLineFamily,
            fontSize: 25,
            color: Theme.of(context).unselectedWidgetColor,
          ),
          controller: _password,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Your Password',
            hintStyle: TextStyle(
              color: Theme.of(context).unselectedWidgetColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.vpn_key,
              color: Theme.of(context).unselectedWidgetColor,
              size: 38,
            ),
          ),
          obscureText: true,
          validator: (String value) {
            var error = '';
            if (value.length < 8) {
              error = 'Password must have at least 8 characters';
            }

            if (error.isNotEmpty) {
              setState(() {
                hasErrorPassword = true;
                passwordError = error;
              });
            } else {
              setState(() {
                hasErrorPassword = false;
              });
            }
          },
          onFieldSubmitted: (value) {
            _fieldFocusChange(context, _passwordFocus, _firstNameFocus);
          },
          keyboardType: TextInputType.text,
          focusNode: _passwordFocus,
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget firstName() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).unselectedWidgetColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).unselectedWidgetColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: tagLineFamily,
            fontSize: 25,
            color: Theme.of(context).unselectedWidgetColor,
          ),
          controller: _firstName,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'First Name',
            hintStyle: TextStyle(
              color: Theme.of(context).unselectedWidgetColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.person,
              color: Theme.of(context).unselectedWidgetColor,
              size: 38,
            ),
          ),
          validator: (String value) {
            var error = '';
            if (value.isEmpty) {
              error = 'This field is required';
            }

            if (error.isNotEmpty) {
              setState(() {
                hasErrorFirstName = true;
                firstNameError = error;
              });
            } else {
              hasErrorFirstName = false;
            }
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
          Radius.circular(30),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).unselectedWidgetColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).unselectedWidgetColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: tagLineFamily,
            fontSize: 25,
            color: Theme.of(context).unselectedWidgetColor,
          ),
          controller: _middleName,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Middle Name',
            hintStyle: TextStyle(
              color: Theme.of(context).unselectedWidgetColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.person,
              color: Theme.of(context).unselectedWidgetColor,
              size: 38,
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
          Radius.circular(30),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).unselectedWidgetColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).unselectedWidgetColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: tagLineFamily,
            fontSize: 25,
            color: Theme.of(context).unselectedWidgetColor,
          ),
          controller: _lastName,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Last Name',
            hintStyle: TextStyle(
              color: Theme.of(context).unselectedWidgetColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.person,
              color: Theme.of(context).unselectedWidgetColor,
              size: 38,
            ),
          ),
          validator: (String value) {
            var error = '';
            if (value.isEmpty) {
              error = 'This field is required';
            }

            if (error.isNotEmpty) {
              setState(() {
                hasErrorLastName = true;
                lastNameError = error;
              });
            } else {
              hasErrorLastName = false;
            }
          },
          onFieldSubmitted: (value) {
            _lastNameFocus.unfocus();
          },
          keyboardType: TextInputType.text,
          focusNode: _lastNameFocus,
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }

  Widget birthDate() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).unselectedWidgetColor,
          width: 2.0,
        ),
      ),
      child: FlatButton(
        onPressed: _onTapBirthDate,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 8.5),
              child: Icon(
                Icons.calendar_today,
                size: 38,
                color: Theme.of(context).unselectedWidgetColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text(
                formatDate(
                  _initialSelectedBirthDate,
                  [mm, '/', dd, '/', yyyy],
                ),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: tagLineFamily,
                  fontSize: 25,
                  color: Theme.of(context).unselectedWidgetColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerSubmitButton() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: Color.fromRGBO(101, 200, 208, 1.0),
            width: 2.0,
          ),
        ),
        child: Text(
          'register'.toUpperCase(),
          style: TextStyle(
            color: Color.fromRGBO(101, 200, 208, 1.0),
            fontFamily: tagLineFamily,
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        onPressed: __submitRegister,
      ),
    );
  }

  Widget _radioGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 15.0),
          child: _genderLabel('Select your gender'),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _genderLabel('Male'),
            _rowMale(),
            _genderLabel('Female'),
            _rowFemale(),
          ],
        ),
      ],
    );
  }

  Widget _genderLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Theme.of(context).unselectedWidgetColor,
        fontSize: 25,
        fontWeight: FontWeight.w600,
        fontFamily: tagLineFamily,
      ),
    );
  }

  /* Gender Row */
  Widget _rowMale() {
    return Radio(
      activeColor: Theme.of(context).unselectedWidgetColor,
      onChanged: (e) => _genderOnChange(e),
      value: 'Male',
      groupValue: groupGender,
    );
  }

  Widget _rowFemale() {
    return Radio(
      activeColor: Theme.of(context).unselectedWidgetColor,
      onChanged: (e) => _genderOnChange(e),
      value: 'Female',
      groupValue: groupGender,
    );
  }

  /* Terms and Condition Checkbox */

  // terms and condition notes
  // must fetch from live data
  Widget _termsAndConditionNotes() {
    return Text(
      '*By clicking REGISTER button, you are agreed to follow our terms and condition in using our service.',
      textAlign: TextAlign.center,
      softWrap: true,
      style: TextStyle(
        color: Theme.of(context).unselectedWidgetColor,
      ),
    );
  }

  /* Error Labels */

  Widget _errorEmail() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 5),
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: Text(
        usernameError,
        style: TextStyle(
          fontSize: 18,
          fontFamily: tagLineFamily,
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }

  Widget _errorPassword() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 5),
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: Text(
        passwordError,
        style: TextStyle(
          fontSize: 18,
          fontFamily: tagLineFamily,
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }

  Widget _errorFirstName() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 5),
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: Text(
        firstNameError,
        style: TextStyle(
          fontSize: 18,
          fontFamily: tagLineFamily,
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }

  Widget _errorLastName() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 5),
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: Text(
        lastNameError,
        style: TextStyle(
          fontSize: 18,
          fontFamily: tagLineFamily,
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }

  Widget _errorSelectGender() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 5),
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: Text(
        selectGenderError,
        style: TextStyle(
          fontSize: 18,
          fontFamily: tagLineFamily,
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }

  Widget _errorBirthDate() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 5),
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: Text(
        birthDateError,
        style: TextStyle(
          fontSize: 18,
          fontFamily: tagLineFamily,
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }

  Widget logo() {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 25),
      child: CircleAvatar(
        backgroundColor: Colors.black.withOpacity(0.5),
        radius: 40,
        child: Image.asset(
          'assets/logo/logo.png',
          height: 55,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  Widget appName() {
    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: Text(
        'REGISTER',
        style: TextStyle(
          fontFamily: tagLineFamily,
          fontSize: 40,
          color: Color.fromRGBO(101, 200, 208, 1.0),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget background() {
    return Container(
      height: MediaQuery.of(context).size.height * 1.5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(44, 88, 113, 1.0),
            Color.fromRGBO(71, 145, 152, 1.0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Future<Null> _materialSelectBirthDate() async {
    final DateTime pickedBirthDate = await showDatePicker(
      context: context,
      initialDate: _initialSelectedBirthDate,
      firstDate: new DateTime(1900),
      lastDate: new DateTime(DateTime.now().year + 5),
    );
    if (pickedBirthDate != null &&
        pickedBirthDate != _initialSelectedBirthDate) {
      var error = '';

      if (!isAge18AndUp(pickedBirthDate)) {
        error = 'You must be 18 years old and above';
      }

      if (error.isNotEmpty) {
        setState(() {
          hasErrorBirthDate = true;
          birthDateError = error;
        });
      } else {
        setState(() {
          hasErrorBirthDate = false;
          _initialSelectedBirthDate = pickedBirthDate;
        });
      }
    }
  }

  _cupertinoSelectBirthDate() {
    return DatePicker.showDatePicker(
      context,
      minTime: DateTime(1900),
      maxTime: DateTime(DateTime.now().year + 5),
      onChanged: (date) {
        _initialSelectedBirthDate = date;
      },
      onConfirm: (date) {
        var error = '';
        if (!isAge18AndUp(date)) {
          error = 'You must be 18 years old and above';
        }

        if (error.isNotEmpty) {
          setState(() {
            hasErrorBirthDate = true;
            birthDateError = error;
          });
        } else {
          setState(() {
            hasErrorBirthDate = false;
            _initialSelectedBirthDate = date;
          });
        }
      },
      currentTime: DateTime.now(),
    );
  }

  __submitRegister() {
    var error = '';
    var genderError = '';
    if (_formKey.currentState.validate()) {
      if (!isAge18AndUp(_initialSelectedBirthDate)) {
        error = 'You must be 18 years old and above';
      }

      if (groupGender.isEmpty) genderError = 'Please select your gender';

      setState(() {
        if (error.isNotEmpty) {
          hasErrorBirthDate = true;
          birthDateError = error;
        } else {
          hasErrorBirthDate = false;
          _initialSelectedBirthDate = _initialSelectedBirthDate;
        }

        if (genderError.isNotEmpty) {
          hasErrorSelectGender = true;
          selectGenderError = genderError;
        } else {
          hasErrorSelectGender = false;
        }
      });

      if (!hasErrorBirthDate && !hasErrorSelectGender) {
        // perform your logic here
        print('yeye!');
      }
    }
  }

  _genderOnChange(String value) {
    setState(() {
      groupGender = value;
    });
  }

  _onTapBirthDate() {
    if (!Platform.isIOS) {
      _materialSelectBirthDate();
    } else {
      _cupertinoSelectBirthDate();
    }
  }
}
