import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {

  final String content;
  final String? id;
  final String senderId; // GEMINI
  final String recieverId;
  final String? media; // url (internet)
  final String? localMediaLink; // url (internet)
  final Timestamp dateTime;

  const MessageEntity({
   required this.content, this.id,
   required this.dateTime,
   required this.senderId,
   required this.recieverId,
    this.localMediaLink,
    this.media,
});

  @override
  List<Object?> get props => [
    content,
    id,
    dateTime,
    senderId,
    recieverId,
    media,
  ];
}