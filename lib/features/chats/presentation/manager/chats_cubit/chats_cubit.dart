import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/data/models/message_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/message_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/user_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/use_cases/getAllMessages.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/use_cases/get_all_users.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/use_cases/send_message.dart';
import 'package:meta/meta.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  final GetAllUsers getAllUsers;
  final SendMessage sendMessage;
  final GetAllMessages getAllMessages;
  ChatsCubit({required this.sendMessage, required this.getAllUsers,required this.getAllMessages})
    : super(ChatsInitial());

  List<UserEntity> allUsers = [];
  List<MessageEntity> allMessages = [];

  void getAllUsersFunction(int currentUserId) async {
    emit(GetAllUsersLoading());
    final result = await getAllUsers();
    result.fold((l) => emit(GetAllUsersErr()), (r) {
      r.removeWhere((element) => element.id == currentUserId);
      allUsers = r;
      emit(GetAllUsersSuccessfully());
    });
  }

  void sendMessageFunction(
    int currentUserId,
    int recieverId,
    String content, [
    String? media,
  ]) async {
    MessageEntity messageEntity = MessageEntity(
      content: content,
      dateTime: Timestamp.now(),
      senderId: currentUserId.toString(),
      recieverId: recieverId.toString(),
    );
    final result = await sendMessage(messageEntity);
    result.fold((l) => emit(SendMessageError()), (r) {
      emit(SendMessageSuccessfully());
    });
  }

  void getAllMessagesFunction(int senderId, int recieverId){
    getAllMessages(senderId,recieverId).listen(
          (event) {
            print(event.docs.length);
            print("Changed");
            allMessages = [];
            for(var element in event.docs){
            allMessages.add(MessageModel.fromJson(element.data()));
          }
            emit(GetAllMessagesSuccessfully());
      },
      onError: (err){
            log("error $err");
      }
    );
  }
}
