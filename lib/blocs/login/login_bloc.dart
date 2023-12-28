import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/repositories.dart';
import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _loginRepository;

  LoginBloc(this._loginRepository) : super(LoginInitial()) {
    on<LoadLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final user = await _loginRepository.login(
            event.email, event.password, event.deviceId);
        if (kDebugMode) {
          print('emitiento loginLoadedState user:');
        }
        if (kDebugMode) {
          print(user);
        }
        emit(LoginLoadedState(user));
      } catch (e) {
        if (kDebugMode) {
          print('error_repository');
        }
        emit(LoginErrorState(('errorr en  bloc ')));
      }
    });
  }
}
