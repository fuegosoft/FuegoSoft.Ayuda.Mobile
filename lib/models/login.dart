import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String token;
  Login({@required this.token}) : super([token]);
}
