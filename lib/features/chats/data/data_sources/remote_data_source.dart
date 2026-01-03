import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/data/models/message_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/data/models/user_model.dart';

abstract class ChatApiDataSource {
  Future<List<UserModel>> getAllUsers();
}

abstract class ChatFirebaseDataSource {
  Future<Unit> sendMessage(MessageModel message);
}

class ChatApiDataSourceImplWithDio implements ChatApiDataSource {
  final DioHelper dio;
  const ChatApiDataSourceImplWithDio(this.dio);
  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await dio.getData(endPoint: "users/");
      return response.data
          .map<UserModel>((element) => UserModel.fromJson(element))
          .toList();
    } catch (err) {
      throw ServerFailure(message: "Error while getting data");
    }
  }
}

class ChatFirebaseDataSourceImpl implements ChatFirebaseDataSource{
  final FirebaseFirestore firebaseFirestore; // instance of db
  const ChatFirebaseDataSourceImpl(this.firebaseFirestore);
  @override
  Future<Unit> sendMessage(MessageModel message)async {
    await firebaseFirestore
        .collection("users")
        .doc(message.senderId) // 1 Abdelrhman
        .collection("chats")
        .doc(message.recieverId) // 2 Ezz
        .collection("messages")
        .add(message.toJson());

    await firebaseFirestore
        .collection("users")
        .doc(message.recieverId) // 2 Ezz
        .collection("chats")
        .doc(message.senderId) // 1 Abdelrhman
        .collection("messages")
        .add(message.toJson());

    return unit;
  }


}