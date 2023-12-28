// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoadLoginEvent extends LoginEvent {
  String email;
  String password;
  String deviceId;

  LoadLoginEvent(this.email, this.password, this.deviceId);

  @override
  List<Object?> get props => [email, password, deviceId];
}
