import 'package:flutter_secure_storage/flutter_secure_storage.dart';

 class SecureStorageHelper{

   static late  FlutterSecureStorage _secureStorage;

   SecureStorageHelper(){

    _secureStorage = FlutterSecureStorage(
      aOptions:  const AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  }

   Future<void> saveData({required String key , required String value})async{
    await _secureStorage.write(key: key, value: value);
  }

   Future<String?> getData({required String key})async{
    return await _secureStorage.read(key: key);
  }
   Future<void> removeData({required String key})async{
    await _secureStorage.delete(key: key);
  }
}