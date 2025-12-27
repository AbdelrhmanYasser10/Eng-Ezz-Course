import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/domain/repositories/splash_repository.dart';

import '../../../../core/error/failure.dart';

class PassOnBoardingUseCase {
  final SplashRepository repository;
  const PassOnBoardingUseCase(this.repository);


  Future<Either<Unit,Failure>> call(bool passOnBoarding)async{
    return await repository.saveOnBoardingPass(passOnBoarding);
  }


}