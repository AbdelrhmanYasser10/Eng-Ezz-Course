import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/settings/domain/repositories/settings_repository.dart';

class GetAppTheme {

  final SettingsRepository repository;
  GetAppTheme(this.repository);

  Either<Failure,bool> call( ) => repository.isDark();

}