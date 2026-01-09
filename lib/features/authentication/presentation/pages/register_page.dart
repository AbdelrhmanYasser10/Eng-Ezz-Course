import 'dart:io';

import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/pages/login_page.dart';
import 'package:e_commerce_app_session_it_sharks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/components/input_field.dart';
import '../../../../core/components/space_widget.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_style.dart';
import '../../../../core/utils/app_toaster.dart';
import '../../../../core/utils/validations.dart';
import '../../../../core/widgets/loading_widget.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpace(space: 30.0),
                  TitleWidget(titleText: S.of(context).createAccount),
                  const VerticalSpace(space: 30.0),
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
                              if (state is PickImageSuccessfully) {
                                // proceed to edit the image
                                context.read<AuthCubit>().editImage();
                              }
                            },
                            // Rebuild the UI after the state changing ( many times)
                            builder: (context, state) {
                              var image = context.read<AuthCubit>().finalImage;
                              if (image == null) {
                                return CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg",
                                  ),
                                  radius: 29,
                                );
                              } else {
                                return CircleAvatar(
                                  backgroundImage: FileImage(File(image.path)),
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
                            onTap: () {
                              _scaffoldKey.currentState?.showBottomSheet(
                                (context) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
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
                                          context.read<AuthCubit>().pickImage(
                                            source: "Gallery",
                                          );
                                          // Another Way
                                          //BlocProvider.of<AuthCubit>(context).pickImage(source: "Gallery");
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
                                          context.read<AuthCubit>().pickImage(
                                            source: "Camera",
                                          );
                                          // Another Way
                                          //BlocProvider.of<AuthCubit>(context).pickImage(source: "Camera");
                                        },
                                        child: Text(
                                          S.of(context).camera,
                                          style:
                                              AppTextStyle.textStyleFont18BlackBold(),
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
                  const VerticalSpace(space: 20.0),
                  InputField(
                    controller: _emailController,
                    prefixIcon: Icons.email,
                    hintText: S.of(context).email,
                    validator: emailValidator,
                  ),
                  const VerticalSpace(space: 10.0),
                  InputField(
                    controller: _userNameController,
                    prefixIcon: Icons.person,
                    hintText: S.of(context).username,
                    validator: usernameValidator,
                  ),
                  const VerticalSpace(space: 10.0),
                  InputField(
                    controller: _passwordController,
                    prefixIcon: Icons.lock,
                    hintText: S.of(context).password,
                    isPassword: true,
                    validator: passwordValidator,
                  ),
                  const VerticalSpace(space: 10.0),
                  InputField(
                    controller: _confPasswordController,
                    prefixIcon: Icons.lock,
                    hintText: S.of(context).confirmPassword,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value != _passwordController.text) {
                        return S.of(context).confirmPasswordError;
                      }
                      return null;
                    },
                  ),
                  const VerticalSpace(space: 50.0),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if(state is UploadImageSuccessfully){
                        context.read<AuthCubit>().registerUserData(
                            email: _emailController.text,
                            password: _passwordController.text,
                            username: _userNameController.text,
                        );
                      }
                      if(state is RegisterUserDataError){
                        showToast(
                          title: S.of(context).errorWhileRegister,
                          description: state.message,
                          context: context,
                          isError: true
                        );
                      }
                      if(state is RegisterUserDataSuccessfully){
                        showToast(
                            title: S.of(context).registerSuccessfully,
                            description: S.of(context).congrats,
                            context: context,
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginPage()));
                      }
                    },
                    builder: (context, state) {
                      if(state is UploadImageLoading || state is RegisterUserDataLoading){
                        return LoadingWidget();
                      }
                      return AppButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().uploadImage();
                          }
                        },
                        text: S.of(context).register,
                      );
                    },
                  ),
                  const VerticalSpace(space: 50.0),
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
                    hintText: S.of(context).alreadyHaveAccount,
                    linkText: S.of(context).login,
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
