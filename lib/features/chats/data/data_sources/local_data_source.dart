import 'dart:io';

import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/styles/app_colors.dart';

abstract class ChatLocalDataSource{

  Future<XFile?> pickImageFunction(String source);
  Future<CroppedFile?> cropImageFunction(XFile image);
  Future<File?> pickFile();

}

class ChatLocalDataSourceImplWithImagePickerAndImageCropper implements ChatLocalDataSource{
  @override
  Future<CroppedFile?> cropImageFunction(XFile image) async{
    final finalImage = await ImageCropper().cropImage(
      sourcePath: image.path,
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
      return finalImage;
    }
    else{
      throw EmptyDataFailure(message: "No image picking");
    }
  }

  @override
  Future<XFile?> pickImageFunction(String source) async{
      final image = await ImagePicker().pickImage(source: source == "gallery" ? ImageSource.gallery : ImageSource.camera);
      if(image !=null){
        return image;
      }
      else{
        throw EmptyDataFailure(message: "No image picking");
      }
  }

  @override
  Future<File?> pickFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      throw EmptyDataFailure(message: "User didn't pick any file");
      // User canceled the picker
    }
  }

}