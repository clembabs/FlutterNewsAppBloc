import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  @override
  String toString() => 'AuthenticationInitial';
}

class Authenticated extends AuthenticationState {
  final String firebaseUser;

  Authenticated(this.firebaseUser);

  @override
  List<Object> get props => [firebaseUser];

  @override
  String toString() => "Authenticated {$firebaseUser}";
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}
