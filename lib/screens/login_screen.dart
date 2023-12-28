import 'package:bloc_learn/blocs/login/login_bloc.dart';
import 'package:bloc_learn/blocs/login/login_events.dart';
import 'package:bloc_learn/blocs/login/login_states.dart';
import 'package:bloc_learn/cubit/device/device_cubit.dart';
import 'package:bloc_learn/model/users_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'view_data_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late DeviceCubit _deviceCubit;

  @override
  void initState() {
    super.initState();
    _deviceCubit = context.read<DeviceCubit>();
    _deviceCubit.getDeviceId();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController deviceIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: BlocBuilder<DeviceCubit, String>(
        builder: (context, state) {
          deviceIdController.text = state;
          return const Text('');
        },
      )),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
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
            return Center(
              child: Container(
                margin: const EdgeInsets.all(30),
                child: Card(
                  color: Colors.blue.shade800,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Login to continue',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            textStyle:
                                Theme.of(context).textTheme.displayMedium,
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: emailController,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            hintText: 'Username',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.yellow.shade800, width: 1.5),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.all(18),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.password,
                              color: Colors.white,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.yellow.shade800, width: 1.5),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.all(18),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(50),
                          ),
                          onPressed: () async {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoadLoginEvent(
                                      emailController.text,
                                      passwordController.text,
                                      deviceIdController.text));
                              await Future.delayed(const Duration(seconds: 3));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Lengkapi Data')),
                              );
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          if (state is LoginLoadingState) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.blue.shade800,
            ));
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
