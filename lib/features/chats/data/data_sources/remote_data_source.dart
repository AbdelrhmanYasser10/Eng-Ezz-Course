import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app_session_it_sharks/core/utils/startegy_handler.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/data/models/message_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/data/models/user_model.dart';
import 'package:firebase_ai/firebase_ai.dart';

import '../../../../core/network/remote/send_notification_service.dart';

abstract class ChatApiDataSource {
  Future<List<UserModel>> getAllUsers();
  Future <String> uploadFile(File file);
}

abstract class ChatFirebaseDataSource {
  Future<Unit> sendMessage(MessageModel message);
  Stream<QuerySnapshot<dynamic>> reterieveMessages(String senderId,String receiverId);
}

class ChatApiDataSourceImplWithDio implements ChatApiDataSource {
  final DioHelper dio;
  final Cloudinary cloudinaryClient;
  const ChatApiDataSourceImplWithDio(this.dio,this.cloudinaryClient);
  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await dio.getData(endPoint: "/users/");
      return response.data
          .map<UserModel>((element) => UserModel.fromJson(element))
          .toList();
    } catch (err) {
      throw ServerFailure(message: "Error while getting data");
    }
  }

  @override
  Future<String> uploadFile(File file) async{
    final response = await
    cloudinaryClient.upload
      (
        file: file.path,
        fileBytes: file.readAsBytesSync(),
        resourceType: CloudinaryResourceType.auto,
        folder: "E-commerce App file",
        fileName: file.path.split("/").last,
    );

    if(response.isSuccessful) {
      return response.secureUrl!;
    }
    else{
      throw ServerFailure(message: "error while uploading the file");
    }
  }
}

class ChatFirebaseDataSourceImpl implements ChatFirebaseDataSource{
  final FirebaseFirestore firebaseFirestore; // instance of db
  final GenerativeModel aiModel;
  const ChatFirebaseDataSourceImpl(this.firebaseFirestore,this.aiModel);
  @override
  Future<Unit> sendMessage(MessageModel message)async {
    // User --> AI Model
    if(message.recieverId == "-1"){
      // I send my message
      await firebaseFirestore
          .collection("users")
          .doc(message.senderId) // 1 Abdelrhman
          .collection("chats")
          .doc(message.recieverId) // 2 Ezz
          .collection("messages")
          .add(message.toJson());

      List<Content> prompt = [];

      if(message.media == null) {
        prompt = [Content.text(message.content)];
      }
      else{
        final textPart = TextPart(message.content);
        final file = await File(message.localMediaLink!).readAsBytes();
        final fileExtension = message.localMediaLink!.split("/").last.split(".").last;
        String fileType =getFileType(fileExtension);

        final filePart  = InlineDataPart(getMimeType(fileExtension, fileType), file);
         prompt = [Content.multi([textPart,filePart])];
      }
      final response = await aiModel.generateContent(prompt);

      MessageModel aiResponse = MessageModel(
          content: response.text ?? "Gemini cannot respond on this prompt",
          dateTime: Timestamp.now(),
          senderId: "-1",
          recieverId: message.senderId,
      );
      try {
        SendNotificationService().sendNotification(
          token:
          (await firebaseFirestore
              .collection("users")
              .doc(message.senderId).get())["fcmToken"],
          title: "Gemini Response",
          body: "${response.text }",
          data: {},
        );
      }catch(err){}
      // Gemini respond
      await firebaseFirestore
          .collection("users")
          .doc(message.senderId) // 1 Abdelrhman
          .collection("chats")
          .doc(message.recieverId) // 2 Ezz
          .collection("messages")
          .add(aiResponse.toJson());
    }
    // User ---> User
    else {
      await firebaseFirestore
          .collection("users")
          .doc(message.senderId) // 1 Abdelrhman
          .collection("chats")
          .doc(message.recieverId) // 2 Ezz
          .collection("messages")
          .add(message.toJson());
      try {
        SendNotificationService().sendNotification(
          token:
          (await firebaseFirestore
              .collection("users")
              .doc(message.recieverId).get())["fcmToken"],
          title: "New Message!!",
          body: message.content,
          data: {},
        );
      }catch(err){}
      await firebaseFirestore
          .collection("users")
          .doc(message.recieverId) // 2 Ezz
          .collection("chats")
          .doc(message.senderId) // 1 Abdelrhman
          .collection("messages")
          .add(message.toJson());
    }

    return unit;
  }

  Stream<QuerySnapshot<dynamic>> reterieveMessages(String senderId,String receiverId){
     return  firebaseFirestore
        .collection("users")
        .doc(senderId) // 1 Abdelrhman
        .collection("chats")
        .doc(receiverId) // 2 Ezz
        .collection("messages")
         .orderBy("dateTime")
         .snapshots();

  }


}