import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/product_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/repositories/home_repository.dart';

class GetCategoryProductsUseCase {
  final HomeRepository repository;

  GetCategoryProductsUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call(int categoryId) {
    return repository.getCategoryProducts(categoryId);
  }
}
