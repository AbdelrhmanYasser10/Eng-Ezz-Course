import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/register_request_body.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/repositories/authentication_repository.dart';

class RegisterUserData {

  final AuthenticationRepository repository;
  const RegisterUserData({required this.repository});

  Future<Either<Failure,Unit>> call(RegisterRequestBody request)async{
    return repository.register(request);
  }

}