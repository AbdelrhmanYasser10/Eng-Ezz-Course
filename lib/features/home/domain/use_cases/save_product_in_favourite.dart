import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/product_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failure.dart';

class SaveProductInFavourite {
  final HomeRepository repository;
  SaveProductInFavourite({required this.repository});


  Future<Either<Failure,Unit>> call (ProductEntity product)async{
    return await repository.saveToFavourite(product);
  }
}