import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/category_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/product_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/user_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, UserEntity>> getUserData();

  Future<Either<Failure, List<ProductEntity>>> getAllProducts();

  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();

  Future<Either<Failure, List<ProductEntity>>> getCategoryProducts(
      int categoryId);
}