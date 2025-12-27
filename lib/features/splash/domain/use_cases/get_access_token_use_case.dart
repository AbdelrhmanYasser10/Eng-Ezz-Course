import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/domain/repositories/splash_repository.dart';

class GetAccessTokenUseCase {


  final SplashRepository repository;

  const GetAccessTokenUseCase(this.repository);

  Future<Either<String?,Failure>> call()async{
    return await repository.getAccessToken();
  }
}