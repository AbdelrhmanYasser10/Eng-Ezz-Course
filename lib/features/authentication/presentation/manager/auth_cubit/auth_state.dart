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
final class RegisterUserDataError extends AuthState {}


