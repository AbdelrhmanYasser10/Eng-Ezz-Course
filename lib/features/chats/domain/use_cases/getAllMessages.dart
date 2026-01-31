import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/repositories/chat_repository.dart';

class GetAllMessages {
  final ChatRepository repository;
  GetAllMessages(this.repository);

  Stream<QuerySnapshot<dynamic>> call(String senderId, String recieverId) =>
      repository.getAllChatMessages(senderId, recieverId);
}
