import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class SignInWithEmailAndPassword extends AuthenticationEvent {
  final String username;
  final String password;

  SignInWithEmailAndPassword(
      {@required this.username, @required this.password});
}

class OnNavigateLoginPage extends AuthenticationEvent {}

class SignInWithGoogle extends AuthenticationEvent {}

class CheckUserIsActive extends AuthenticationEvent {}

class SignOut extends AuthenticationEvent {}
