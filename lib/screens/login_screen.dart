import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:bloc_learn/blocs/login/login_bloc.dart';
import 'package:bloc_learn/blocs/login/login_events.dart';
import 'package:bloc_learn/blocs/login/login_states.dart';
import 'package:bloc_learn/model/users_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view_data_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    getId();
    super.initState();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController deviceIdController = TextEditingController();

  Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;

      setState(() {
        deviceIdController.text = iosDeviceInfo.identifierForVendor.toString();
      });
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      setState(() {
        deviceIdController.text = androidDeviceInfo.id.toString();
      });
      return androidDeviceInfo.id;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          const Text('hola');
          if (state is LoginLoadedState) {
            UserModel usuario = state.user;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewData(userdata: usuario)));
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is LoginInitial) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'username',
                    labelText: 'Username',
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'insgresa la contraseña',
                    labelText: 'password',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    BlocProvider.of<LoginBloc>(context).add(LoadLoginEvent(
                        emailController.text,
                        passwordController.text,
                        deviceIdController.text));
                    await Future.delayed(const Duration(seconds: 3));
                  },
                  child: const Text("Login"),
                ),
              ],
            );
          }
          if (state is LoginLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoginErrorState) {
            return Column(children: [
              const Text(
                "Error",
                style: TextStyle(color: Colors.black, fontSize: 50),
              ),
              GestureDetector(
                onTap: () => {},
                child: Container(
                  width: 50,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: const Center(child: Text('atras')),
                ),
              ),
            ]);
          }
          return Container();
        }),
      ),
    );
  }
}
