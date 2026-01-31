import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.id, required super.name, required super.email, required super.role, required super.avatarLink});


  factory UserModel.fromJson(Map<String,dynamic>json){
    return UserModel(
        id: json["id"].toString(),
        name: json["name"],
        email: json["email"],
        role: json["role"],
        avatarLink: json["avatar"],
    );
  }

}