import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/secure_storage_helper.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/shared_preferences_helper.dart';

import '../../../../core/error/failure.dart';

abstract class SettingsLocalDataSource {
  Future<Unit> saveAppTheme(bool isDark);
  Future<Unit> saveNewLocality(String languageCode);
  String getLocale();
  bool isDark();
  Future<Unit> logOut();
}

class SettingsLocalDataSourceWithSPAndSecureStorage
    implements SettingsLocalDataSource {
  final SharedPreferencesHelper sharedPreferencesHelper;
  final SecureStorageHelper secureStorageHelper;

  const SettingsLocalDataSourceWithSPAndSecureStorage({
    required this.secureStorageHelper,
    required this.sharedPreferencesHelper,
  });

  @override
  String getLocale() {
    try{
      return (sharedPreferencesHelper.getDataFromCache(key: "languageCode")!);
    }catch(err){
      throw EmptyCacheFailure(message: '');
    }
  }

  @override
  bool isDark() {
    try{
      return (sharedPreferencesHelper.getDataFromCache(key: "isDark")!);
    }catch(err){
      throw EmptyCacheFailure(message: '');
    }
  }

  @override
  Future<Unit> logOut() async{
      await secureStorageHelper.removeData(key: "accessToken");
      await secureStorageHelper.removeData(key: "refreshToken");
    return unit;
  }

  @override
  Future<Unit> saveAppTheme(bool isDark) async{
     await sharedPreferencesHelper.writeDataToCache(key: "isDark", value: isDark);
    return unit;
  }

  @override
  Future<Unit> saveNewLocality(String languageCode) async{
    await sharedPreferencesHelper.writeDataToCache(key: "languageCode", value: languageCode);
    return unit;
  }
}
