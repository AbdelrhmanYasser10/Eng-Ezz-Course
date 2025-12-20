import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/LoginResponseBody.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/login_request_body.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/repositories/authentication_repository.dart';

class LoginWithEmailAndPassword {
  final AuthenticationRepository repository;
  LoginWithEmailAndPassword({required this.repository});

  Future<Either<Failure,LoginResponseBody>> execute(LoginRequestBody request) async {
    return repository.login(request);
  }
}
