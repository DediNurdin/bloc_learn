import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class LoadNewsEvent extends NewsEvent {
  @override
  List<Object?> get props => [];
}
