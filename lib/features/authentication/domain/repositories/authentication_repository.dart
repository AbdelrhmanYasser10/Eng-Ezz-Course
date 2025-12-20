import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/LoginResponseBody.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/login_request_body.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/register_request_body.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/image_upload_response.dart';
import "package:dartz/dartz.dart";

abstract class AuthenticationRepository {


  Future<Either<Failure,LoginResponseBody>> login(LoginRequestBody request);
  Future<Either<Failure,Unit>> register(RegisterRequestBody request);
  Future<Either<Failure, ImageUploadResponse>> uploadImage(String filePath);


}