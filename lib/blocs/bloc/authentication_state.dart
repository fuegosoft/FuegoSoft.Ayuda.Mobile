import 'package:equatable/equatable.dart';
import 'package:fuegosoft_ayuda_services/models/login.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}

// will on start of the app
class InitializedAuthentication extends AuthenticationState {}

// redirect user to dashboard
class UserAuthenticated extends AuthenticationState {
  final Login login;

  UserAuthenticated(this.login) : super([login]);
}

// redirect user to login
class UserUnauthenticated extends AuthenticationState {}

class InitializeLogin extends AuthenticationState {}

// perform circular loading screen and check user is authenticated or not
class CheckUserAuthentication extends AuthenticationState {}
