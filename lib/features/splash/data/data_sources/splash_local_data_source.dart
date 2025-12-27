import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/secure_storage_helper.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/shared_preferences_helper.dart';

import '../../../../core/error/failure.dart';

abstract class SplashLocalDataSource{

  Future<Unit> savePassOnBoarding(bool passOnBoarding);
  Future<bool?> isPassOnBoarding();
  Future<String?> getAccessToken();

}

class SplashLocalDataSourceImplWithSPAndSecureStorage implements SplashLocalDataSource{

  final SecureStorageHelper secureStorageHelper;
  final SharedPreferencesHelper sharedPreferencesHelper;

  const SplashLocalDataSourceImplWithSPAndSecureStorage(
  {
     required this.secureStorageHelper,
    required this.sharedPreferencesHelper,
  });

  @override
  Future<String?> getAccessToken() async{
    try{
      final accessToken = await secureStorageHelper.getData(key: "accessToken");
      return accessToken;
    }catch(err){
      throw EmptyCacheFailure(message: "No Data Saved in Secure Storage");
    }
  }

  @override
  Future<bool?> isPassOnBoarding() async{
    try{
      final isPassOnBoarding = await sharedPreferencesHelper.getDataFromCache(key: "OnBoarding");
      return isPassOnBoarding;
    }catch(err){
      throw EmptyCacheFailure(message: "No Data Saved in Shared Preferences");
    }
  }

  @override
  Future<Unit> savePassOnBoarding(bool passOnBoarding)async {
    try{
      sharedPreferencesHelper.writeDataToCache(key:"OnBoarding",value: true);
      return unit;
    }catch(err){
      throw CacheSavingError(message: "Cannot save required data");
    }
  }

}