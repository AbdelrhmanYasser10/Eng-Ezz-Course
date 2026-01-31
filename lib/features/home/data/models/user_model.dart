import 'package:e_commerce_app_session_it_sharks/features/home/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
        super.id,
        super.email,
        super.fcmToken,
        super.password,
        super.name,
        super.role,
        super.avatar,
        super.creationAt,
        super.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
    avatar = json['avatar'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['role'] = this.role;
    data['avatar'] = this.avatar;
    data['creationAt'] = this.creationAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}