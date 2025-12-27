import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/splash/domain/repositories/splash_repository.dart';

import '../data_sources/splash_local_data_source.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource splashLocalDataSource;
  const SplashRepositoryImpl({required this.splashLocalDataSource});

  @override
  Future<Either<String?, Failure>> getAccessToken() async {
    try {
      final accessToken = await splashLocalDataSource.getAccessToken();
      return Left(accessToken);
    } on Failure catch (err) {
      return Right(err);
    }
  }

  @override
  Future<Either<bool?, Failure>> isPassOnBoarding() async {
    try {
      final passOnBoarding = await splashLocalDataSource.isPassOnBoarding();
      return Left(passOnBoarding);
    } on Failure catch (err) {
      return Right(err);
    }
  }

  @override
  Future<Either<Unit, Failure>> saveOnBoardingPass(bool passOnBoarding) async {
    try {
      await splashLocalDataSource.savePassOnBoarding(passOnBoarding);
      return Left(unit);
    } on Failure catch (err) {
      return Right(err);
    }
  }
}
