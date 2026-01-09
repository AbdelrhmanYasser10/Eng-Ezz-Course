import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/settings/data/data_sources/local_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {

  final SettingsLocalDataSource settingsLocalDataSource;
  const SettingsRepositoryImpl(this.settingsLocalDataSource);

  @override
  Future<Either<Failure, Unit>> changeLocale(String languageCode) async{
    try{
      await settingsLocalDataSource.saveNewLocality(languageCode);
      return Right(unit);
    }
        on Failure catch(err){
      return Left(err);
        }
  }

  @override
  Future<Either<Failure, Unit>> changeTheme(bool isDark) async{
    try{
      await settingsLocalDataSource.saveAppTheme(isDark);
      return Right(unit);
    }
    on Failure catch(err){
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async{
    try{
      await settingsLocalDataSource.logOut();
      return Right(unit);
    }
    on Failure catch(err){
      return Left(err);
    }
  }

  @override
  Either<Failure, String> getAppLocale() {
    try{
       final value = settingsLocalDataSource.getLocale();
      return Right(value);
    }
    on Failure catch(err){
      return Left(err);
    }
  }

  @override
  Either<Failure, bool> isDark() {
    try{
      final value = settingsLocalDataSource.isDark();
      return Right(value);
    }
    on Failure catch(err){
      return Left(err);
    }
  }


}