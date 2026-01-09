import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/settings/domain/repositories/settings_repository.dart';

class ChangeLocale {

  final SettingsRepository repository;
  ChangeLocale(this.repository);

  Future<Either<Failure,Unit>> call(String languageCode)async => repository.changeLocale(languageCode);

}