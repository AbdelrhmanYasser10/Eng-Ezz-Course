import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/domain/repositories/splash_repository.dart';

class IsPassedOnBoardingUseCase {

  final SplashRepository repository;
  const IsPassedOnBoardingUseCase({required this.repository});


  Future<Either<bool?,Failure>> call()async{
    return await repository.isPassOnBoarding();
  }


}