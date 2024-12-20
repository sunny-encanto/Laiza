import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashSuccess extends SplashState {
  const SplashSuccess();

  @override
  List<Object> get props => [];
}
