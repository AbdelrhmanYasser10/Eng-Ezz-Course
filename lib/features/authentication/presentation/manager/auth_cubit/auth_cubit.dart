import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/LoginResponseBody.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/entities/login_request_body.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/use_cases/login_with_email_and_password.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/use_cases/register_user_data.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../../core/styles/app_colors.dart';
import '../../../domain/entities/register_request_body.dart';

import 'package:e_commerce_app_session_it_sharks/features/authentication/domain/use_cases/upload_image_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginWithEmailAndPassword loginUseCase;
  final RegisterUserData registerUseCase;
  final UploadImageUseCase uploadImageUseCase;
  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.uploadImageUseCase,
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


  void uploadImage() async {
    emit(UploadImageLoading());
    final response = await uploadImageUseCase(finalImage!.path);
    response.fold(
      (l) => emit(UploadImageError()),
      (r) {
        imageLink = r.location;
        emit(UploadImageSuccessfully());
      },
    );
  }
  
  
  void registerUserData({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(RegisterUserDataLoading());
    final RegisterRequestBody requestBody = RegisterRequestBody(
      email: email,
      password: password,
      username: username,
      avatar: imageLink,
    );
    final response = await registerUseCase(requestBody);
    response.fold(
      (l) => emit(RegisterUserDataError(message: l.message)),
      (r) => emit(RegisterUserDataSuccessfully()),
    );
  }

void loginUserData({required String email, required String password})async{
    emit(LoginUserDataLoading());
    final LoginRequestBody requestBody = LoginRequestBody(email: email, password: password);
    final response = await loginUseCase.execute(requestBody);
    response.fold(
        (l) => emit(LoginUserDataError(message: l.message)),
        (r) => emit(LoginUserDataSuccessfully(response: r)),
    );
}


}
