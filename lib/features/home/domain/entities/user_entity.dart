import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  String? id;
  String? email;
  String? fcmToken;
  String? password;
  String? name;
  String? role;
  String? avatar;
  String? creationAt;
  String? updatedAt;

  UserEntity(
      {this.id,
        this.email,
        this.fcmToken,
        this.password,
        this.name,
        this.role,
        this.avatar,
        this.creationAt,
        this.updatedAt});
  @override
  List<Object?> get props => [
    id,
    email,
    password,
    name,
    role,
    avatar,
    creationAt,
    fcmToken,
    updatedAt,
  ];
}