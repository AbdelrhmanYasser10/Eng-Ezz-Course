part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}


/// Pick image states
final class PickImageSuccessfully extends AuthState {}
final class NotPickingImage extends AuthState {}
final class PickImageLoading extends AuthState {}
final class EditImageSuccessfully extends AuthState {}
final class CancelEditing extends AuthState {}


/// Login States




/// Register States
final class UploadImageLoading extends AuthState {}
final class UploadImageSuccessfully extends AuthState {}
final class UploadImageError extends AuthState {}

final class RegisterUserDataLoading extends AuthState {}
final class RegisterUserDataSuccessfully extends AuthState {}
final class RegisterUserDataError extends AuthState {
  final String message;
  RegisterUserDataError({required this.message});
}

final class LoginUserDataLoading extends AuthState {}
final class LoginUserDataSuccessfully extends AuthState {
  final String accessToken;
  final String refreshToken;
  LoginUserDataSuccessfully({
  required this.accessToken,
  required this.refreshToken,
});
}
final class LoginUserDataError extends AuthState {
final String message;
LoginUserDataError({required this.message});
}


