import 'package:dartz/dartz.dart';

import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/data_sources/loca_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/data/data_sources/remote_data_source.dart';

import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/user_entity.dart';

import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository{

  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
});

  @override
  Future<Either<Failure, UserEntity>> getUserData() async{
    try{
      final accessToken = await localDataSource.getAccessToken();
      final user = await remoteDataSource.getUserData(accessToken);
      return Right(user);
    }
    on Failure catch(err){
      return Left(err);
    }
  }


}