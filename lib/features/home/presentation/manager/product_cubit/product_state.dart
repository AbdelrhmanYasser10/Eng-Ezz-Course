part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class GetAllProductsLoading extends ProductState {}
final class GetAllProductsSuccessfully extends ProductState {}
final class GetAllProductsError extends ProductState {}

final class GetCategoryProductsLoading extends ProductState {}
final class GetCategoryProductsSuccessfully extends ProductState {
}
final class GetCategoryProductsError extends ProductState {}


final class GetSimilarProductsLoading extends ProductState {}
final class GetSimilarProductsSuccessfully extends ProductState {}
final class GetSimilarProductsError extends ProductState {}
