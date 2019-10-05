import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_youtube/user.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SignInEvent) {
      try {
        yield StartLoginState();
        final user = await authenticate(event.email, event.password);
        if (user == null) {
          yield ErrorLoginState(message: 'E-mail ou senha inválidos.');
        } else {
          yield SuccessLoginState(user: user);
        }
      } catch (e) {
        yield ErrorLoginState(message: 'Ops! Algo deu errado.');
        print(e);
      }
    }
  }

  Future<User> authenticate(String email, String password) {
    return Future.delayed(Duration(seconds: 3), () {
      if (email == 'contato@manacespereira.com.br' && password == '123123')
        return User(email: email, name: 'Manacés Pereira');
      return null;
    });
  }
}
