import 'package:bloc/bloc.dart';
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



}
