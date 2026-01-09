import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';

abstract class SettingsRepository {


  Future<Either<Failure,Unit>> changeLocale(String languageCode);

  Future<Either<Failure,Unit>> changeTheme(bool isDark);

  Future<Either<Failure,Unit>> logOut();

  Either<Failure,String> getAppLocale();
  Either<Failure,bool> isDark();



}