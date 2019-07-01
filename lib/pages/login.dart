import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuegosoft_ayuda_services/blocs/bloc/bloc.dart';
import 'package:fuegosoft_ayuda_services/repositories/user_repository.dart';
import 'package:fuegosoft_ayuda_services/util/validators/validator.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();
  String tagLineFamily = 'Gafata';

  var _username = TextEditingController();
  var _password = TextEditingController();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String errorDisplay = '';
  String validatorText = '';

  // bloc
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(OnNavigateLoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (BuildContext context) => _authenticationBloc,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            backgroundColor: Color.fromRGBO(44, 88, 113, 1.0),
            elevation: 0.0,
          ),
        ),
        body: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is InitializedAuthentication) {
              return _loadingLogin();
            }
            return loginComponent();
          },
        ),
      ),
    );
  }

  Widget _loadingLogin() {
    return Center(
      child: Container(
        height: 150,
        width: 150,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget loginComponent() {
    return Stack(
      children: <Widget>[
        backgroundGradient(),
        baseComponents(),
      ],
    );
  }

  Widget baseComponents() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          logo(),
          SizedBox(
            height: 10,
          ),
          appName(),
          tagLine(),
          loginForm(),
        ],
      ),
    );
  }

  Widget loginForm() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 20.0,
        ),
        child: Column(
          children: <Widget>[
            errorTextDisplay(errorDisplay),
            SizedBox(
              height: 10,
            ),
            usernameText(),
            SizedBox(
              height: 5,
            ),
            passwordText(),
            SizedBox(
              height: 5,
            ),
            forgotPasswordButton(),
            SizedBox(
              height: 10,
            ),
            signInButton(),
            SizedBox(
              height: 10,
            ),
            signInOption(),
            SizedBox(
              height: 10,
            ),
            logoSignInOptions(),
          ],
        ),
      ),
    );
  }

  Widget errorTextDisplay(String error) {
    return Container(
      child: Text(
        error,
        style: TextStyle(
          fontFamily: tagLineFamily,
          color: Theme.of(context).errorColor,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget usernameText() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(
            fontFamily: tagLineFamily,
            fontSize: 25,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
          ),
          controller: _username,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Your Username',
            hintStyle: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.email,
              color: Theme.of(context).primaryColor,
              size: 38,
            ),
          ),
          validator: (String value) {
            if (!isEmail(value)) {
              validatorText = validatorText.replaceAll('Invalid Email', '');
              validatorText += 'Invalid Email';
            } else {
              validatorText = validatorText.replaceAll('Invalid Email', '');
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

  Widget forgotPasswordButton() {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: () {
          // navigate to forgot password form.
          _forgotPassword();
        },
        child: Text(
          'Forgot your password?',
          style: TextStyle(
            fontFamily: tagLineFamily,
            color: Color.fromRGBO(101, 200, 208, 1.0),
            fontSize: 18,
          ),
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
          color: Theme.of(context).primaryColor,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(left: 25.0),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: tagLineFamily,
            fontSize: 25,
            color: Theme.of(context).primaryColor,
          ),
          controller: _password,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Your Password',
            hintStyle: TextStyle(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            icon: Icon(
              Icons.vpn_key,
              color: Theme.of(context).primaryColor,
              size: 38,
            ),
          ),
          obscureText: true,
          validator: (String value) {
            validatorText = validatorText.replaceAll(
                ' and Password must at least 8 characters', '');
            validatorText = validatorText.replaceAll(
                'Password must at least 8 characters', '');
            if (value.length < 7) {
              if (validatorText.isNotEmpty) {
                validatorText = validatorText.replaceAll(
                    ' and Password must at least 8 characters', '');
                validatorText += ' and Password must at least 8 characters';
              } else {
                validatorText = validatorText.replaceAll(
                    'Password must at least 8 characters', '');
                validatorText += 'Password must at least 8 characters';
              }
            }
          },
          onFieldSubmitted: (value) {
            _passwordFocus.unfocus();
          },
          keyboardType: TextInputType.text,
          focusNode: _passwordFocus,
        ),
      ),
    );
  }

  Widget signInButton() {
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
          'Sign In'.toUpperCase(),
          style: TextStyle(
            color: Color.fromRGBO(101, 200, 208, 1.0),
            fontFamily: tagLineFamily,
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        onPressed: () {
          // perform sign in using email/password
          // and navigate to the dashboard form.

          _signInEmailPassword();
        },
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Widget signInOption() {
    return Text(
      '- or sign in with -',
      style: TextStyle(
        fontFamily: tagLineFamily,
        color: Color.fromRGBO(101, 200, 208, 1.0),
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget logoSignInOptions() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          googleLogoSignIn(),
          SizedBox(
            width: 10,
          ),
          facebookLogoSignIn(),
        ],
      ),
    );
  }

  Widget googleLogoSignIn() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: FlatButton(
        shape: CircleBorder(
          side: BorderSide(
            width: 2.0,
            color: Color.fromRGBO(101, 200, 208, 1.0),
          ),
        ),
        onPressed: () {
          // open google sign in form.
          // upon successful sign in, navigate to dashboard.
          _signInWithGoogle();
        },
        child: Image.asset(
          'assets/icons/google.png',
          color: Color.fromRGBO(101, 200, 208, 1.0),
          fit: BoxFit.cover,
          width: 50,
        ),
      ),
    );
  }

  Widget facebookLogoSignIn() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: FlatButton(
        shape: CircleBorder(
          side: BorderSide(
            width: 2.0,
            color: Color.fromRGBO(101, 200, 208, 1.0),
          ),
        ),
        onPressed: () {
          // popup facebook sign in form.
          // upon successful sign in, navigate to dashboard.
          _signInWithFacebook();
        },
        child: Image.asset(
          'assets/icons/facebook.png',
          fit: BoxFit.cover,
          height: 40,
          color: Color.fromRGBO(101, 200, 208, 1.0),
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

  Widget appName() {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Text(
        'AYUDA',
        style: TextStyle(
          fontFamily: tagLineFamily,
          fontSize: 50,
          color: Color.fromRGBO(101, 200, 208, 1.0),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget tagLine() {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: Text(
        'Find professionals near you now!',
        style: TextStyle(
          fontFamily: tagLineFamily,
          fontSize: 20,
          color: Colors.white,
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

  /* Functions */
  void _forgotPassword() {
    print('forgot password is clicked!');
  }

  void _signInEmailPassword() {
    if (_formKey.currentState.validate()) {
      if (validatorText.isEmpty) {
        setState(() {
          errorDisplay = '';

          var nothing = BlocProvider.of<AuthenticationBloc>(context).dispatch(
            SignInWithEmailAndPassword(
                username: _username.text, password: _password.text),
          );
        });
      } else {
        setState(() {
          errorDisplay = validatorText;
        });
      }
      print('sign in with email and password is clicked!');
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/dashboard', (Route<dynamic> route) => false);
    }
  }

  void _signInWithGoogle() {
    print('sign in with google is clicked!');
  }

  void _signInWithFacebook() {
    print('sign in with facebook is clicked!');
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}
