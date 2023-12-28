import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../model/users_model.dart';

@immutable
abstract class LoginState extends Equatable {
  Object? get user => null;
}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoadedState extends LoginState {
  @override
  final UserModel user;

  LoginLoadedState(this.user);
  @override
  List<Object?> get props => [user];
}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
