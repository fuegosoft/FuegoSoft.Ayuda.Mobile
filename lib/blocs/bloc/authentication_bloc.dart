import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './bloc.dart';
import 'package:fuegosoft_ayuda_services/repositories/user_repository.dart';
import 'package:fuegosoft_ayuda_services/models/login.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => InitializedAuthentication();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is OnNavigateLoginPage) {
      yield* _onAppStarted();
    } else if (event is SignInWithEmailAndPassword) {
      yield* _onSignInWithEmailAndPassword(event.username, event.password);
    } else if (event is SignInWithGoogle) {
      yield* _onSignInWithGoogle();
    } else if (event is SignOut) {
      yield* _onSignedOut();
    }
  }

  Stream<AuthenticationState> _onAppStarted() async* {
    try {
      yield InitializedAuthentication();
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final userId = await _userRepository.getCurrentUser();
        var login = Login(token: userId);
        yield UserAuthenticated(login);
      } else {
        yield UserUnauthenticated();
      }
    } catch (_) {
      yield UserUnauthenticated();
    }
  }

  Stream<AuthenticationState> _onSignInWithEmailAndPassword(
      String username, String password) async* {
    try {
      yield UserUnauthenticated();
      final user =
          await _userRepository.signInWithCredentials(username, password);
      if (user.uid.isNotEmpty) {
        var login = Login(token: user.uid);
        yield UserAuthenticated(login);
      } else {
        yield UserUnauthenticated();
      }
    } catch (_) {
      yield UserUnauthenticated();
    }
  }

  Stream<AuthenticationState> _onSignInWithGoogle() async* {
    try {
      yield UserUnauthenticated();
      final user = await _userRepository.signInWithGoogle();
      if (user.uid.isNotEmpty) {
        var login = Login(token: user.uid);
        yield UserAuthenticated(login);
      } else {
        yield UserUnauthenticated();
      }
    } catch (_) {
      yield UserUnauthenticated();
    }
  }

  Stream<AuthenticationState> _onSignedOut() async* {
    yield UserUnauthenticated();
    await _userRepository.signOut();
  }
}
