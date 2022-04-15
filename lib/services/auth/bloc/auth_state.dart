import 'package:flutter/cupertino.dart';
import 'package:touchandlist/services/auth/auth_user.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized();
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering(this.exception);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

//We build our exception on the loggedOut because it will be
//the first state that any new user will be at, we use the equatable
//dependency to override different states in this class that should be
//reconognizable

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  final bool isLoading;

  const AuthStateLoggedOut(
    this.exception,
    this.isLoading,
  );

  @override
  List<Object?> get props => [exception, isLoading];
}
