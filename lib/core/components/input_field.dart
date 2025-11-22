import 'package:e_commerce_app_session_it_sharks/core/styles/app_colors.dart';
import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:flutter/material.dart';



class InputField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool isPassword;
  final String?Function(String?) validator;
  const InputField({
    super.key,
    required this.hintText,
    required this.prefixIcon ,
    required this.controller,
    required this.validator,
    this.isPassword = false,
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
      validator:  widget.validator ,
      obscureText: isSecure,
      controller: widget.controller,
      cursorColor: AppColors.kPrimaryColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyle.inputFieldHintStyle(),
        contentPadding: EdgeInsets.symmetric(vertical: 17),
        isDense: true,
        prefixIcon: Icon(
          widget.prefixIcon,
          size: 26,
          color: AppColors.kIconInputFieldColor,
        ),
        suffixIcon: widget.isPassword ? IconButton(
          onPressed: (){
            setState(() {
              isSecure = !isSecure;
              //widget.isPassword = !widget.isPassword;
            });
          },
          icon: Icon(
              isSecure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            size: 26,
            color: AppColors.kIconInputFieldColor,
          ),
        ): null,
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
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 1.0,
          color: strokeColor ?? AppColors.kStrokeColor,
        ),
      );
  }
}
