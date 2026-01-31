part of 'fav_cubit.dart';

@immutable
sealed class FavState {}

final class FavInitial extends FavState {}
final class ChangeProductFavourite extends FavState {}
final class GetFavouritesLoading extends FavState {}
final class GetFavouritesSuccessfully extends FavState {}
final class GetFavouritesError extends FavState {}

