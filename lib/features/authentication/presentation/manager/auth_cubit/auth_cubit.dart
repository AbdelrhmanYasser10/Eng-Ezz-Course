import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../../core/styles/app_colors.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final ImagePicker picker = ImagePicker();
  XFile? image; // before editing
  CroppedFile? finalImage; // after editing


  String imageLink = "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg"; // Default Value

  void pickImage({required String source})async{
    emit(PickImageLoading());
    if(source == "Gallery"){
      image = await picker.pickImage(source: ImageSource.gallery);
    }
    else{
      image = await picker.pickImage(source: ImageSource.camera);
    }

    if(image != null){
      emit(PickImageSuccessfully());
    }
    else{
      emit(NotPickingImage());
    }

  }


  void editImage()async{
    finalImage = await ImageCropper().cropImage(
      sourcePath: image!.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Edit your image',
          toolbarColor: AppColors.kPrimaryColor,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Edit your image',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );

    if(finalImage != null){
      emit(EditImageSuccessfully());
    }
    else{
      image = null;
      emit(CancelEditing());
    }
  }


  void uploadImage()async{
    emit(UploadImageLoading());
    try {
      var multiPartFile =await MultipartFile.fromFile(finalImage!.path); //bytes
      var formData = FormData.fromMap(
          {
            "file": multiPartFile,
          }
      );
      Response response = await DioHelper.uploadFile(
        endPoint: "files/upload",
        file: formData,
      );
      if (response.statusCode == 201) {
        imageLink = response.data["location"];
        emit(UploadImageSuccessfully());
      }
      else {
        emit(UploadImageError());
      }
    }catch(err){
      print(err.toString());
      emit(UploadImageError());
    }
  }
  
  
  void registerUserData({
  required String email,
    required String password,
    required String username,
})async{}




}
