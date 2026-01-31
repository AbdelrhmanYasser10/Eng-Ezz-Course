import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/data/data_sources/local_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/data/data_sources/remote_data_source.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/data/models/message_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/message_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/user_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/repositories/chat_repository.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataSource chatLocalDataSource;
  final ChatApiDataSource chatApiDataSource;
  final ChatFirebaseDataSource chatFirebaseDataSource;

  const ChatRepositoryImpl({
    required this.chatLocalDataSource,
    required this.chatFirebaseDataSource,
    required this.chatApiDataSource,
  });

  @override
  Stream<QuerySnapshot<dynamic>> getAllChatMessages(String senderId,String receiverId) {
    return chatFirebaseDataSource.reterieveMessages(senderId.toString(), receiverId.toString());
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final response = await chatApiDataSource.getAllUsers();
      return Right(response);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(MessageEntity message) async {
    try {
      MessageModel messageModel = MessageModel(
        content: message.content,
        id: message.id,
        dateTime: message.dateTime,
        senderId: message.senderId,
        recieverId: message.recieverId,
        media: message.media,
        localMediaLink: message.localMediaLink,
      );
      await chatFirebaseDataSource.sendMessage(messageModel);
      return Right(unit);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, CroppedFile>> cropImage(XFile image) async{
    try {
      final response = await chatLocalDataSource.cropImageFunction(image);
      return Right(response!);
    }on Failure catch(err){
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, XFile>> pickImage(String source) async{
    try {
      final response = await chatLocalDataSource.pickImageFunction(source);
      return Right(response!);
    }on Failure catch(err){
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, String>> uploadFileToServer(File file) async{
    try {
      final response = await chatApiDataSource.uploadFile(file);
      return Right(response);
    }on Failure catch(err){
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, File>> pickFile() async{
    try {
      final response = await chatLocalDataSource.pickFile();
      return Right(response!);
    }on Failure catch(err){
      return Left(err);
    }
  }
}
