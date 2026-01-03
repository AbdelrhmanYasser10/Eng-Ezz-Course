import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({required super.content, super.id, required super.dateTime, required super.senderId,required super.recieverId,super.media});


  factory MessageModel.fromJson(Map<String,dynamic>json){
    return MessageModel(
        content: json["content"],
        id: json["id"],
        dateTime: json["dateTime"],
        senderId: json["senderId"],
        recieverId: json["recieverId"],
         media: json["media"],
    );
  }

  Map<String,dynamic> toJson ()=>{
    "id":id,
    "content":content,
    "dateTime":dateTime,
    "senderId":senderId,
    "media":media,
    "recieverId":recieverId,
  };
}