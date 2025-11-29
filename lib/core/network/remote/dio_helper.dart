import 'package:dio/dio.dart';

abstract class DioHelper{

  static late Dio _dio;

  static void initialize(){
    // 1 instance of http client,
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://api.escuelajs.co/api/v1",
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20), // time out
        validateStatus: (status) => status! <= 505,
      ),
    );
  }

  //CRUD
  // Json request
  static Future<Response> postData({
  required String endPoint,
  required Map<String,dynamic> data,

}){
    _dio.options.headers = {
      "Content-Type":"application/json",
    };
    return _dio.post(endPoint,data: data);
  }

  static Future<Response> getData({
    required String endPoint,
    String? accessToken,

  }){
    _dio.options.headers = {
      "Content-Type":"application/json",
      "Authorization":"Bearer $accessToken",
    };
    return _dio.get(endPoint);
  }

  // Upload file
  static Future<Response> uploadFile({
  required String endPoint,
   required FormData file,
})async{
    _dio.options.headers = {
      "Content-Type":"multipart/form-data",
    };
    return await _dio.post(endPoint,data: file);
  }


}