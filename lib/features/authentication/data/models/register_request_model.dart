import '../../domain/entities/register_request_body.dart';

class RegisterRequestModel extends RegisterRequestBody{

  const RegisterRequestModel({required super.avatar,
  required super.email,
    required super.username,
    required super.password
  });


  Map<String,dynamic> toJson()=>{
    "email":email,
    "avatar":avatar,
    "name":username,
    "password":password,
    "role":"customer"
  };

}