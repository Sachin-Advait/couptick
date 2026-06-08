part of 'splash_bloc.dart';

sealed class SplashState {}

final class SplashInitial extends SplashState {}

sealed class SplashActionState extends SplashState {}

final class NavigateToHomeActionState extends SplashActionState {}

final class NavigateToLoginActionState extends SplashActionState {}
