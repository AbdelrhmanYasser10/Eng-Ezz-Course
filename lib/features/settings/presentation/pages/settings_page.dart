import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:e_commerce_app_session_it_sharks/features/settings/presentation/manager/settings_cubit/settings_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: BlocConsumer<SettingsCubit, SettingsState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              var cubit = context.read<SettingsCubit>();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).settings,
                    style: AppTextStyle.textStyleFont24BlackBold(),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.language_outlined),
                    title: Text(
                      S.of(context).lang_hint,
                      style: AppTextStyle.textStyleFont18BlackBold(),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      if(cubit.languageCode =="en") {
                        cubit.changeAppLocaleFunction("ar");
                      }
                      else{
                        cubit.changeAppLocaleFunction("en");
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.dark_mode_outlined),
                    title: Text(
                      S.of(context).dark_mode_hint,
                      style: AppTextStyle.textStyleFont18BlackBold(),
                    ),
                    trailing: Switch(
                      value: cubit.isDark,
                      inactiveThumbColor: Colors.white,
                      activeThumbColor: AppColors.kPrimaryColor,
                      inactiveTrackColor: Colors.blueGrey,
                      onChanged: (value) {
                        cubit.changeAppThemeFunction(value);
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(
                      S.of(context).logout,
                      style: AppTextStyle.textStyleFont18BlackBold(),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      cubit.logOutFunction();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
