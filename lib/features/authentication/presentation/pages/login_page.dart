import 'package:e_commerce_app_session_it_sharks/core/components/space_widget.dart';
import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/authentication/presentation/pages/register_page.dart';
import 'package:e_commerce_app_session_it_sharks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/components/input_field.dart';
import '../../../../core/utils/app_toaster.dart';
import '../../../../core/utils/validations.dart';
import '../../../../core/widgets/basic_layout.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../widgets/form_footer.dart';
import '../widgets/social_login_buttons.dart';
import '../widgets/title_widget.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpace(
                    space: 30.0,
                  ),
                  TitleWidget(
                    titleText: S.of(context).welcomeBack,
                  ),
                  const VerticalSpace(
                    space: 30.0,
                  ),
                  InputField(
                    controller: _emailController,
                    prefixIcon: Icons.email,
                    hintText: S.of(context).email,
                    validator: emailValidator,
                  ),
                  const VerticalSpace(
                    space: 10.0,
                  ),
                  InputField(
                    controller: _passwordController,
                    prefixIcon: Icons.lock,
                    hintText: S.of(context).password,
                    isPassword: true,
                    validator: passwordValidator,
                  ),
                  const VerticalSpace(
                    space: 50.0,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) async{
                      if(state is LoginUserDataSuccessfully){
                        showToast(
                            context: context,
                            title: S.of(context).loginSuccessfully,
                            description: S.of(context).congrats,
                        );

                        if(mounted) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => BasicLayout()));
                        }
                      }
                      if(state is LoginUserDataError){
                        if(mounted) {
                          showToast(
                              title: S.of(context).credentialError,
                              description: state.message,
                              context: context,
                              isError: true
                          );
                        }
                      }
                    },
                    builder: (context, state) {
                      if(state is LoginUserDataLoading){
                        return LoadingWidget();
                      }
                      return AppButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            context.read<AuthCubit>().loginUserData(
                                email: _emailController.text,
                                password: _passwordController.text,
                            );
                          }
                        },
                        text: S.of(context).login,
                      );
                    },
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
                    hintText: S.of(context).dontHaveAccount,
                    linkText: S.of(context).register,
                    replacedScreen: RegisterPage(),
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





