import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/repositories.dart';
import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _loginRepository;
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  LoginBloc(this._loginRepository) : super(LoginInitial()) {
    on<LoadLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final user = await _loginRepository.login(
            event.email, event.password, event.deviceId);

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
