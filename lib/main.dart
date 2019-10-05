import 'package:bloc_youtube/bloc/bloc.dart';
import 'package:bloc_youtube/bloc/login_bloc.dart';
import 'package:bloc_youtube/login.dart';
import 'package:bloc_youtube/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: <String, WidgetBuilder>{
        MyHomePage.routeName: (context) =>
            MyHomePage(title: 'Flutter Demo Home Page'),
        LoginPage.routeName: (context) => LoginPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            builder: (context) => LoginBloc(),
          ),
        ],
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is StartLoginState)
              return Center(child: CircularProgressIndicator());

            if (state is ErrorLoginState)
              return LoginPage(errorMessage: state.message);

            if (state is SuccessLoginState)
              return MyHomePage(title: 'Bem Vindo', user: state.user);

            return LoginPage();
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = 'HOME_PAGE';

  MyHomePage({Key key, this.title, this.user}) : super(key: key);

  final String title;
  final User user;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bem vindo, ${widget.user.name}!!!',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
