import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageHelper{

  static late FlutterSecureStorage _secureStorage;

  static void initializeSecureStorage(){

    _secureStorage = FlutterSecureStorage(
      aOptions:  const AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  }

  static Future<void> saveData({required String key , required String value})async{
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String?> getData({required String key})async{
    return await _secureStorage.read(key: key);
  }
  static Future<void> removeData({required String key})async{
    await _secureStorage.delete(key: key);
  }
}