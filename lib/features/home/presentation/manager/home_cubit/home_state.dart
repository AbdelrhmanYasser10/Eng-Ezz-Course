part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}


final class GetUserDataLoading extends HomeState {}
final class GetUserDataSuccessfully extends HomeState {}
final class GetUserDataError extends HomeState {}
