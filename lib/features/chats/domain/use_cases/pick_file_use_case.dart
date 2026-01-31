import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/repositories/chat_repository.dart';

class PickFileUseCase {
  final ChatRepository repository;
  PickFileUseCase(this.repository);


  Future<Either<Failure,File>> call()async=>repository.pickFile();

}