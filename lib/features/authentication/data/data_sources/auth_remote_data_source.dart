import 'package:dio/dio.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/models/login_request_body_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/models/login_respones_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/models/register_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestBodyModel request);
  Future<void> register(RegisterRequestModel model);
}

class AuthRemoteDataSourceWithDio implements AuthRemoteDataSource{

  final Dio dio;
  const AuthRemoteDataSourceWithDio({required this.dio});

  @override
  Future<LoginResponseModel> login(LoginRequestBodyModel request) async{
    try{
      final Response response = await dio.post(
          "/auth/login",
        data: request.toJson(),
      );
      if(response.statusCode == 201) {
        final loginResponse = LoginResponseModel.fromJson(response.data);
        return loginResponse;
      }
      else{
        throw(NetworkFailure(message: "Bad Request"));
      }
    }
    catch(err){
        throw(ServerFailure(message: "Error, while connecting with server"));
    }
  }

  @override
  Future<void> register(RegisterRequestModel model) {
    // TODO: implement register
    throw UnimplementedError();
  }
}

