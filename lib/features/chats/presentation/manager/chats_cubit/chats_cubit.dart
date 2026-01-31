import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/data/models/message_model.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/message_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/user_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/use_cases/edit_image_use_case.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/use_cases/getAllMessages.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/use_cases/get_all_users.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/use_cases/pick_image_use_case.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/use_cases/send_message.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/use_cases/upload_image_to_server.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../domain/use_cases/pick_file_use_case.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  final GetAllUsers getAllUsers;
  final SendMessage sendMessage;
  final GetAllMessages getAllMessages;
  final PickImageUseCase pickImageUseCase;
  final PickFileUseCase pickFileUseCase;
  final EditImageUseCase editImageUseCase;
  final UploadFileToServer uploadFileToServer;
  ChatsCubit({
    required this.sendMessage,
    required this.getAllUsers,
    required this.getAllMessages,
    required this.pickImageUseCase,
    required this.editImageUseCase,
    required this.pickFileUseCase,
    required this.uploadFileToServer,

  })
    : super(ChatsInitial());

  List<UserEntity> allUsers = [];
  List<MessageEntity> allMessages = [];

  void getAllUsersFunction(String currentUserId) async {
    emit(GetAllUsersLoading());
    final result = await getAllUsers();
    result.fold((l) => emit(GetAllUsersErr()), (r) {
      r.removeWhere((element) => element.id == currentUserId);
      allUsers = r;
      emit(GetAllUsersSuccessfully());
    });
  }

  void sendMessageFunction(
    String currentUserId,
    String recieverId,
    String content, [
    String? media,
        String? localMediaLink,
  ]) async {
    MessageEntity messageEntity = MessageEntity(
      content: content,
      dateTime: Timestamp.now(),
      senderId: currentUserId.toString(),
      recieverId: recieverId.toString(),
      media: media,
      localMediaLink: localMediaLink,
    );
    final result = await sendMessage(messageEntity);
    result.fold((l) => emit(SendMessageError()), (r) {
      emit(SendMessageSuccessfully());
    });
  }

  void getAllMessagesFunction(String senderId, String recieverId){
    allMessages = [];
    getAllMessages(senderId,recieverId).listen(
          (event) {
            allMessages.clear();
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


  void pickImage(String source)async{
    final response = await pickImageUseCase(source);
    response.fold((f)=>emit(PickImageError()),
        (r){

        emit(PickImageSuccessfully());
        editImage(r);
        },
    );
  }

  void editImage(XFile file)async{
    final response = await editImageUseCase(file);
    response.fold((l)=>emit(EditImageError()),
        (r) {
        //edit
          emit(EditImageSuccessfully(r));

        },);
  }

  void uploadFile(File finalFile)async{
    emit(UploadFileLoading());
    final response = await uploadFileToServer(finalFile);
    response.fold((l)=>emit(UploadFileError()),
        (r) {
          emit(UploadFileSuccessfully(r));
        },
    );
  }

  void pickFile()async{
    final response = await pickFileUseCase();
    response.fold((l)=>emit(PickFileError()),
        (r) {
          emit(PickFileSuccessfully(r));
        },
    );
  }

}
