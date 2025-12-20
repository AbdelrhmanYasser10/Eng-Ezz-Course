import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/image_upload_response.dart';

class ImageUploadResponseModel extends ImageUploadResponse {
  const ImageUploadResponseModel({required super.location});

  factory ImageUploadResponseModel.fromJson(Map<String, dynamic> json) {
    return ImageUploadResponseModel(
      location: json['location'],
    );
  }
}
