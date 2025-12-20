import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/remote/dio_helper.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/use_cases/login_with_email_and_password.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/use_cases/register_user_data.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../../core/styles/app_colors.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginWithEmailAndPassword loginUseCase;
  final RegisterUserData registerUseCase;
  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
}) : super(AuthInitial());

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
        endPoint: "/files/upload",
        file: formData,
      );
      log(response.data.toString());
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
})async{
    emit(RegisterUserDataLoading());
    try {
      Response res = await DioHelper.postData(
        endPoint: "/users",
        data: {
          "email":email,
          "password":password,
          "name":username,
          "avatar":imageLink,
          "role":"customer"
        },
      );
      log(res.data.toString());
      if(res.statusCode == 201){
        emit(RegisterUserDataSuccessfully());
      }
      else{
        var message = res.data["message"].join(",");
        emit(RegisterUserDataError(message: message));
      }
    }catch(err){
      emit(RegisterUserDataError(message: "Error, try again later"));
    }


  }

void loginUserData({required String email, required String password})async{
    emit(LoginUserDataLoading());
    
    try{
      Response response = await DioHelper.postData(endPoint: "/auth/login", data: {
        "email":email,
        "password":password,
      });
      log(response.statusCode.toString());
      if(response.statusCode == 201){
        var data = response.data;
        log(data.toString());
        emit(LoginUserDataSuccessfully(
          accessToken: data["access_token"],
          refreshToken: data["refresh_token"],
        ));
      }
      else{
        var message = response.data["message"];
        if(message is List<String>){
          message = message.join(",");
        }
        emit(LoginUserDataError(message: message));
      }
    }catch(err){
      log(err.toString());
      emit(LoginUserDataError(message: "Try to login in another time"));
    }
}


}
