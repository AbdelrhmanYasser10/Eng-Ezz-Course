import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/user_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/domain/repositories/home_repository.dart';

class GetUserDataUseCase {

  final HomeRepository repository;
  const GetUserDataUseCase({required this.repository});


  Future<Either<Failure,UserEntity>> call() async{
    return await repository.getUserData();
  }
  

}