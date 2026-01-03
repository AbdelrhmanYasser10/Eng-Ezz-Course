import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{

  final int id;
  final String name;
  final String email;
  final String role;
  final String avatarLink;


  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.avatarLink,
  });
  @override
  List<Object?> get props => [
    id,
    name,
    email,
    role,
    avatarLink,
  ];

}