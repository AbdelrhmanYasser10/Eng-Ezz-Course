import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/category_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/repositories/home_repository.dart';

class GetAllCategoriesUseCase {
  final HomeRepository repository;

  GetAllCategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call() {
    return repository.getAllCategories();
  }
}
