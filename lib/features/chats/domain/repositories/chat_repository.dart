import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/message_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/user_entity.dart';

abstract class ChatRepository {


  Future<Either<Failure,List<UserEntity>>> getAllUsers();

  Future<Either<Failure,List<MessageEntity>>> getAllChatMessages(int userId);


  Future<Either<Failure,Unit>> sendMessage(MessageEntity message);



}