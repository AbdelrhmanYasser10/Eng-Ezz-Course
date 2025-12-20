import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/data_sources/auth_local_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/models/login_request_body_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/models/login_respones_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/models/register_request_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/LoginResponseBody.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/login_request_body.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/register_request_body.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/image_upload_response.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementer implements AuthenticationRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  const AuthenticationRepositoryImplementer({required this.authRemoteDataSource , required this.authLocalDataSource});
  @override
  Future<Either<Failure,LoginResponseBody>> login(LoginRequestBody request) async{
    try {
      LoginRequestBodyModel myRequest = LoginRequestBodyModel(
          email: request.email, password: request.password);
      final response = await authRemoteDataSource.login(myRequest);
      await authLocalDataSource.saveTokens(response.accessToken, response.refreshToken);
      return Right(response);
    }on Failure catch  (err){
      return Left(err);
    }
  }

  @override
  Future<Either<Failure,Unit>> register(RegisterRequestBody request) async {
    try {
      RegisterRequestModel myRequest = RegisterRequestModel(
        avatar: request.avatar,
        email: request.email,
        username: request.username,
        password: request.password,
      );
      await authRemoteDataSource.register(myRequest);
      return const Right(unit);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, ImageUploadResponse>> uploadImage(String filePath) async {
    try {
      final response = await authRemoteDataSource.uploadImage(filePath);
      return Right(response);
    } on Failure catch (err) {
      return Left(err);
    }
  }

}