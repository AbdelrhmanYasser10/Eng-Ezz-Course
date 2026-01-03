import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/message_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/repositories/chat_repository.dart';

class SendMessage {
  final ChatRepository repository;
  const SendMessage(this.repository);

  Future<Either<Failure, Unit>> call(MessageEntity message) async =>
      await repository.sendMessage(message);
}
