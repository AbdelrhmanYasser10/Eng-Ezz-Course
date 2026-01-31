import 'package:bloc/bloc.dart';
import 'package:e_commerce_app_session_it_sharks/features/settings/domain/use_cases/change_app_theme.dart';
import 'package:e_commerce_app_session_it_sharks/features/settings/domain/use_cases/change_locale.dart';
import 'package:e_commerce_app_session_it_sharks/features/settings/domain/use_cases/get_app_locale.dart';
import 'package:e_commerce_app_session_it_sharks/features/settings/domain/use_cases/get_app_theme.dart';
import 'package:e_commerce_app_session_it_sharks/features/settings/domain/use_cases/logout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final LogOut logOut;
  final ChangeAppTheme changeAppTheme;
  final ChangeLocale changeLocale;
  final GetAppLocale getAppLocale;
  final GetAppTheme getAppTheme;
  SettingsCubit({
    required this.logOut,
    required this.getAppTheme,
    required this.getAppLocale,
    required this.changeLocale,
    required this.changeAppTheme,
  }) : super(SettingsInitial());

  bool isDark = false;
  String languageCode = "en";

  void changeAppThemeFunction(bool isDark) async {
    this.isDark = isDark; // dark mode
    final response = await changeAppTheme(isDark);
    response.fold(
      (l) {
        this.isDark = !this.isDark; // undo
        emit(ChangeAppThemeState());
      },
      (r) {
        emit(ChangeAppThemeState());
      },
    );
  }

  void changeAppLocaleFunction(String languageCode) async {
    this.languageCode = languageCode;
    final response = await changeLocale(languageCode);
    response.fold(
      (l) {
        this.languageCode = this.languageCode == "en" ? "ar" : "en"; // undo
        emit(ChangeAppLocaleState());
      },
      (r) {
        emit(ChangeAppLocaleState());
      },
    );
  }

  void logOutFunction() async {
    if(FirebaseAuth.instance.currentUser != null){
      FirebaseAuth.instance.signOut();
      emit(LogoutState());
    }
    else {
      final response = await logOut();
      response.fold((l) {}, (r) {
        emit(LogoutState());
      });
    }
  }
  
  void getAppCurrentLocale() {
    final response = getAppLocale();
    response.fold((l) {
      languageCode = "en";
      emit(GetCurrentLocale());
    }, (r) {
      languageCode = r;
      emit(GetCurrentLocale());
    },);
  }

  void getCurrentAppTheme() {
    final response = getAppTheme();
    response.fold((l) {
      isDark = false;
      emit(GetCurrentTheme());
    }, (r) {
      isDark = r;
      emit(GetCurrentTheme());
    },);
  }
}
