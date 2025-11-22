import 'dart:io';

import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/components/input_field.dart';
import '../../../../core/components/space_widget.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_style.dart';
import '../../../../core/utils/validations.dart';
import '../widgets/form_footer.dart';
import '../widgets/social_login_buttons.dart';
import '../widgets/title_widget.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpace(
                    space: 30.0,
                  ),
                  TitleWidget(
                    titleText: "Create\nAccount",
                  ),
                  const VerticalSpace(
                    space: 30.0,
                  ),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.kPrimaryColor,
                          radius: 30,
                          child: BlocConsumer<AuthCubit, AuthState>(
                            // Logic part for background logic (not rebuilding)
                          listener: (context, state) {
                            print(state);
                            if(state is PickImageSuccessfully){
                              // proceed to edit the image
                              context.read<AuthCubit>().editImage();
                            }
                          },
                            // Rebuild the UI after the state changing ( many times)
                          builder: (context, state) {
                            var image = context.read<AuthCubit>().finalImage;
                            if(image == null) {
                              return CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg"
                                ),
                                radius: 29,
                              );
                            }
                            else{
                              return CircleAvatar(
                                backgroundImage: FileImage(
                                    File(
                                      image.path,
                                    ),
                                ),
                                radius: 29,
                              );

                            }
                          },
                          ),
                        ),
                        Positioned(
                          bottom: -5,
                          right: -5,
                          child: GestureDetector(
                            onTap: (){
                              _scaffoldKey.currentState?.showBottomSheet(
                                (context) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white
                                  ),
                                  child: Column(
                                    mainAxisSize:MainAxisSize.min,
                                    children: [
                                      TextButton(
                                          style:TextButton.styleFrom(
                                              foregroundColor: AppColors.kPrimaryColor,
                                              overlayColor: AppColors.kPrimaryColor,
                                          ),
                                          onPressed: (){
                                            context.read<AuthCubit>().pickImage(source: "Gallery");
                                            // Another Way
                                            //BlocProvider.of<AuthCubit>(context).pickImage(source: "Gallery");
                                          },
                                          child: Text(
                                            "Gallery",
                                            style: AppTextStyle.textStyleFont18BlackBold(),
                                          ),
                                      ),
                                      TextButton(
                                        style:TextButton.styleFrom(
                                          foregroundColor: AppColors.kPrimaryColor,
                                          overlayColor: AppColors.kPrimaryColor,
                                        ),
                                          onPressed: (){
                                            context.read<AuthCubit>().pickImage(source: "Camera");
                                            // Another Way
                                            //BlocProvider.of<AuthCubit>(context).pickImage(source: "Camera");
                                          },
                                          child: Text(
                                            "Camera",
                                            style: AppTextStyle.textStyleFont18BlackBold(),
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: AppColors.kPrimaryColor,
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalSpace(
                    space: 20.0,
                  ),
                  InputField(
                    controller: _emailController,
                    prefixIcon: Icons.email,
                    hintText:"Email",
                    validator: emailValidator,
                  ),
                  const VerticalSpace(
                    space: 10.0,
                  ),
                  InputField(
                    controller: _userNameController,
                    prefixIcon: Icons.person,
                    hintText:"Username",
                    validator: usernameValidator,
                  ),
                  const VerticalSpace(
                    space: 10.0,
                  ),
                  InputField(
                    controller: _passwordController,
                    prefixIcon: Icons.lock,
                    hintText:"Password",
                    isPassword: true,
                    validator: passwordValidator,
                  ),
                  const VerticalSpace(
                    space: 10.0,
                  ),
                  InputField(
                    controller: _confPasswordController,
                    prefixIcon: Icons.lock,
                    hintText:"Confirm Password",
                    isPassword: true,
                    validator: (value){
                      if(value == null || value != _passwordController.text){
                        return "Confirmation doesn't match the password";
                      }
                      return null;
                    },
                  ),
                  const VerticalSpace(
                    space: 50.0,
                  ),
                  AppButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){}
                    },
                    text: "Register",
                  ),
                  const VerticalSpace(
                    space: 50.0,
                  ),
                  Center(
                    child: Text(
                      "- OR Continue with -",
                      style: AppTextStyle.textStyleFont14GreyNormal(),
                    ),
                  ),

                  const VerticalSpace(space: 20),
                  SocialLoginButtons(),
                  const VerticalSpace(space: 20),
                  FormFooter(
                    hintText: "Already Have account? ",
                    linkText: "Login",
                    replacedScreen: LoginPage(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
