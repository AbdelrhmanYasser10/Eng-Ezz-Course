import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/repositories/chat_repository.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failure.dart';

class EditImageUseCase {

  final ChatRepository chatRepository;

  EditImageUseCase(this.chatRepository);

  Future<Either<Failure,CroppedFile >>call (XFile image) async => chatRepository.cropImage(image);
}