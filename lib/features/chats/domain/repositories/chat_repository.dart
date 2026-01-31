import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/message_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/user_entity.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class ChatRepository {


  Future<Either<Failure,List<UserEntity>>> getAllUsers();

  Stream<QuerySnapshot<dynamic>> getAllChatMessages(String senderId,String recieverId);

  Future<Either<Failure,Unit>> sendMessage(MessageEntity message);

  Future<Either<Failure,XFile>> pickImage(String source);

  Future<Either<Failure,CroppedFile>> cropImage(XFile image);

  Future<Either<Failure,String>> uploadFileToServer(File file);

  // Files
  // 1. Only one function for the files (Multiple files , or single file)
  // 2. Media String ?? ==> Multiple files (json Encode , json Decode)
  Future<Either<Failure,File>> pickFile();


}