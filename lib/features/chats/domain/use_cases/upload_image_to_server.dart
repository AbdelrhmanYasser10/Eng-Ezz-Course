import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../../core/error/failure.dart';
import '../repositories/chat_repository.dart';

class UploadFileToServer {
  final ChatRepository chatRepository;

  UploadFileToServer(this.chatRepository);

  Future<Either<Failure,String >>call (File file) async => chatRepository.uploadFileToServer(file);

}