import 'package:e_commerce_app_session_it_sharks/core/styles/app_colors.dart';
import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool isPassword;
  final bool isChatField;
  final String? Function(String?) validator;
  const InputField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    required this.validator,
    this.isPassword = false,
    this.isChatField = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool isSecure;

  @override
  void initState() {
    super.initState();
    isSecure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: isSecure,
      controller: widget.controller,
      cursorColor: AppColors.kPrimaryColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyle.inputFieldHintStyle(),
        contentPadding: EdgeInsets.symmetric(vertical: 17.h),
        isDense: true,
        prefixIcon: Icon(
          widget.prefixIcon,
          size: 26.sp,
          color: AppColors.kIconInputFieldColor,
        ),
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSecure = !isSecure;
                      //widget.isPassword = !widget.isPassword;
                    });
                  },
                  icon: Icon(
                    isSecure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 26.sp,
                    color: AppColors.kIconInputFieldColor,
                  ),
                )
                : widget.isChatField
                ? IconButton(
                  onPressed: () {
                    showBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                  AppColors.kPrimaryColor,
                                  overlayColor: AppColors.kPrimaryColor,
                                ),
                                onPressed: () {
                                  context.read<ChatsCubit>().pickImage(
                                     "gallery",
                                  );

                                },
                                child: Text(
                                  S.of(context).gallery,
                                  style:
                                  AppTextStyle.textStyleFont18BlackBold(),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                  AppColors.kPrimaryColor,
                                  overlayColor: AppColors.kPrimaryColor,
                                ),
                                onPressed: () {
                                  context.read<ChatsCubit>().pickImage(
                                    "camera",
                                  );
                                },
                                child: Text(
                                  S.of(context).camera,
                                  style:
                                  AppTextStyle.textStyleFont18BlackBold(),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                  AppColors.kPrimaryColor,
                                  overlayColor: AppColors.kPrimaryColor,
                                ),
                                onPressed: () {
                                  context.read<ChatsCubit>().pickFile(

                                  );
                                },
                                child: Text(
                                  "Files",
                                  style:
                                  AppTextStyle.textStyleFont18BlackBold(),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.attach_file,
                    size: 26.sp,
                    color: AppColors.kIconInputFieldColor,
                  ),
                )
                : null,
        filled: true,
        fillColor: AppColors.kInputFieldColor,
        border: _buildTextFieldBorder(),
        focusedBorder: _buildTextFieldBorder(),
        errorBorder: _buildTextFieldBorder(),
        enabledBorder: _buildTextFieldBorder(),
        disabledBorder: _buildTextFieldBorder(),
      ),
    );
  }

  OutlineInputBorder _buildTextFieldBorder([Color? strokeColor]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        width: 1.0.w,
        color: strokeColor ?? AppColors.kStrokeColor,
      ),
    );
  }
}
