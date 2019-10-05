import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class SignInEvent extends LoginEvent {
  final String email;
  final String password;

  SignInEvent({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
