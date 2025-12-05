part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class GetAllProductsLoading extends ProductState {}
final class GetAllProductsSuccessfully extends ProductState {
  final List<ProductModel> allProducts;
  GetAllProductsSuccessfully({required this.allProducts});
}
final class GetAllProductsError extends ProductState {}
