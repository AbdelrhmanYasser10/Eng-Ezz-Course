import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_session_it_sharks/core/error/failure.dart';
import 'package:e_commerce_app_session_it_sharks/core/network/local/secure_storage_helper.dart';

abstract class AuthLocalDataSource {

  Future<Unit> saveTokens(String accessToken,String refreshToken);


}


class AuthLocalDataSourceImplWithSecureStorage implements AuthLocalDataSource{
  final SecureStorageHelper secureStorageHelper;
  AuthLocalDataSourceImplWithSecureStorage({required this.secureStorageHelper});

  @override
  Future<Unit> saveTokens(String accessToken, String refreshToken) async{
    try{
      await Future.wait([
        secureStorageHelper.saveData(key: "accessToken", value: accessToken),
        secureStorageHelper.saveData(key: "refreshToken", value: refreshToken),
      ]);
      return unit;
    }catch(err){
      throw(CacheSavingError(message: "Error while storing cache values"));
    }
  }
}