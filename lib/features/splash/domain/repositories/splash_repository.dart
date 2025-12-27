import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class SplashRepository {

  Future<Either<String?,Failure>> getAccessToken();
  Future<Either<bool?,Failure>> isPassOnBoarding();
  Future<Either<Unit,Failure>> saveOnBoardingPass(bool passOnBoarding);

}