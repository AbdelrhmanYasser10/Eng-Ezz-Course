part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class GetAllCategoriesLoading extends CategoriesState {}

final class GetAllCategoriesSuccessfully extends CategoriesState {
  final List<CategoryEntity> allCategoreies;
  GetAllCategoriesSuccessfully({required this.allCategoreies});
}

final class GetAllCategoriesError extends CategoriesState {}
