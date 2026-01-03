import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/user_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/repositories/chat_repository.dart';

class GetAllUsers {
  final ChatRepository repository;
  const GetAllUsers(this.repository);

  Future<Either<Failure, List<UserEntity>>> call() async =>
      await repository.getAllUsers();
}
