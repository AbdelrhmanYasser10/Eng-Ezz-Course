import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/message_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/user_entity.dart';

abstract class ChatRepository {


  Future<Either<Failure,List<UserEntity>>> getAllUsers();

  Stream<QuerySnapshot<dynamic>> getAllChatMessages(int senderId,int recieverId);

  Future<Either<Failure,Unit>> sendMessage(MessageEntity message);



}