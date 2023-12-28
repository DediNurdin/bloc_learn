//import 'package:bloc_learn/homepage.dart';
import 'package:bloc_learn/blocs/login/login_bloc.dart';
import 'package:bloc_learn/blocs/news/news_bloc.dart';
import 'package:bloc_learn/repository/repositories.dart';
import 'package:bloc_learn/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => LoginBloc(UserRepository()),
          ),
          BlocProvider<NewsBloc>(
            create: (BuildContext context) => NewsBloc(UserRepository()),
          ),
        ],
        child: const LoginPage(),
      ),
    );
  }
}
