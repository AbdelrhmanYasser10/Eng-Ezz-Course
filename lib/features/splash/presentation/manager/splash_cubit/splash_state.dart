part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class GetAccessTokenSuccessfully extends SplashState {}
final class GetAccessTokenError extends SplashState {}


final class PassOnBoardingSuccessFully extends SplashState {}
final class PassOnBoardingError extends SplashState {}

final class SaveOnBoardingSuccessfully extends SplashState {}
final class SaveOnBoardingError extends SplashState {}
