import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/login_request_body.dart';

class LoginRequestBodyModel extends LoginRequestBody {
  LoginRequestBodyModel({required super.email, required super.password});


 Map<String,dynamic> toJson()=>{
   "email":email,
   "password":password,
 };
}