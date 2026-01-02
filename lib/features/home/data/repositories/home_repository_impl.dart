import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/data_sources/loca_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/data_sources/remote_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/category_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/product_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/user_entity.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    try {
      final accessToken = await localDataSource.getAccessToken();
      final user = await remoteDataSource.getUserData(accessToken);
      return Right(user);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final products = await remoteDataSource.getAllProducts();
      return Right(products);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try {
      final categories = await remoteDataSource.getAllCategories();
      return Right(categories);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getCategoryProducts(
      int categoryId) async {
    try {
      final products = await remoteDataSource.getCategoryProducts(categoryId);
      return Right(products);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchForProducts(String name) async {
    try {
      final products = await remoteDataSource.searchedProducts(name);
      return Right(products);
    } on Failure catch (err) {
      return Left(err);
    }
  }
}