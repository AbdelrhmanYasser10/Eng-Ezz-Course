import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/image_upload_response.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/repositories/authentication_repository.dart';

class UploadImageUseCase {
  final AuthenticationRepository repository;

  UploadImageUseCase({required this.repository});

  Future<Either<Failure, ImageUploadResponse>> call(String filePath) async {
    return await repository.uploadImage(filePath);
  }
}
