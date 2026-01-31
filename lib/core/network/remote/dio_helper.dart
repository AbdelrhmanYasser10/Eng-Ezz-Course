import 'package:dio/dio.dart';

class DioHelper{

   late Dio _dio;

  DioHelper(){
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
   Future<Response> postData({
  required String endPoint,
  required Map<String,dynamic> data,

}){
    _dio.options.headers = {
      "Content-Type":"application/json",
    };
    return _dio.post(endPoint,data: data);
  }

   Future<Response> getData({
    required String endPoint,
    String? accessToken,
    Map<String,dynamic>? queryParameters
  }){
    _dio.options.headers = {
      "Content-Type":"application/json",
      "Authorization":"Bearer $accessToken",
    };
    return _dio.get(endPoint,queryParameters: queryParameters);
  }

  // Upload file
   Future<Response> uploadFile({
  required String endPoint,
   required FormData file,
})async{
    _dio.options.headers = {
      "Content-Type":"multipart/form-data",
    };
    return await _dio.post(endPoint,data: file);
  }
   // Download file
   Future<Response> download({
     required String endPoint,

   })async{

     return await _dio.download(endPoint,"Downloads/");
   }


}