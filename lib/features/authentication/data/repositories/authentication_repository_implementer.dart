import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/models/login_request_body_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/LoginResponseBody.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/login_request_body.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/register_request_body.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementer implements AuthenticationRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  const AuthenticationRepositoryImplementer({required this.authRemoteDataSource});
  @override
  Future<Either<Failure,LoginResponseBody>> login(LoginRequestBody request) async{
    try {
      LoginRequestBodyModel myRequest = LoginRequestBodyModel(
          email: request.email, password: request.password);
      final response = await authRemoteDataSource.login(myRequest);
      return Right(response);
    }on Failure catch  (err){
      return Left(err);
    }
  }

  @override
  Future<Either<Failure,Unit>> register(RegisterRequestBody request) {
    // TODO: implement register
    throw UnimplementedError();
  }

}