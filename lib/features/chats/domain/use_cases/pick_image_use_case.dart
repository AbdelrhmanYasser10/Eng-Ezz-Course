import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/repositories/chat_repository.dart';
import 'package:image_picker/image_picker.dart';

class PickImageUseCase {
  final ChatRepository chatRepository;

  PickImageUseCase(this.chatRepository);

  Future<Either<Failure,XFile >>call (String source) async => chatRepository.pickImage(source);

}