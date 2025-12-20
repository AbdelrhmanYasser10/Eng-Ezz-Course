import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/LoginResponseBody.dart';

class LoginResponseModel extends LoginResponseBody {
  LoginResponseModel({required super.accessToken, required super.refreshToken});
 factory LoginResponseModel.fromJson(Map<String,dynamic>json){
   return LoginResponseModel(
       accessToken: json["access_token"],
       refreshToken: json["refresh_token"],
   );
 }
}