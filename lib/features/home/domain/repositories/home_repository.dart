import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/user_entity.dart';

abstract class HomeRepository {

  Future<Either<Failure,UserEntity>> getUserData();

}