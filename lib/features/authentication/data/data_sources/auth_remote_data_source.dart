import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/models/login_request_body_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/models/login_respones_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/models/register_request_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/data/models/image_upload_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestBodyModel request);
  Future<void> register(RegisterRequestModel model);
  Future<ImageUploadResponseModel> uploadImage(String filePath);
}

class AuthRemoteDataSourceWithDio implements AuthRemoteDataSource{

  final DioHelper dio;
  const AuthRemoteDataSourceWithDio({required this.dio});

  @override
  Future<LoginResponseModel> login(LoginRequestBodyModel request) async{
    try{
      final Response response = await dio.postData(
          endPoint: "/auth/login",
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
  Future<void> register(RegisterRequestModel model) async {
    try {
      final Response response = await dio.postData(
        endPoint: "/users",
        data: model.toJson(),
      );
      if (response.statusCode != 201) {
        throw (NetworkFailure(message: "Bad Request"));
      }
    } catch (err) {
      if (err is Failure) {
        rethrow;
      }
      throw (ServerFailure(message: "Error, while connecting with server"));
    }
  }

  @override
  Future<ImageUploadResponseModel> uploadImage(String filePath) async {
    try {
      var multiPartFile = await MultipartFile.fromFile(filePath);
      var formData = FormData.fromMap({
        "file": multiPartFile,
      });

      final Response response = await dio.uploadFile(
        endPoint: "/files/upload",
        file: formData,
      );

      if (response.statusCode == 201) {
        return ImageUploadResponseModel.fromJson(response.data);
      } else {
        throw (NetworkFailure(message: "Upload Failed"));
      }
    } catch (err) {
      if (err is Failure) {
        rethrow;
      }
      throw (ServerFailure(message: "Error, while connecting with server"));
    }
  }
}
