import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesHelper {


  static late SharedPreferences _preferences;

  static Future<void> initialize() async {
    //// Cache mem initialize
    _preferences = await SharedPreferences.getInstance();
  }


  static void writeDataToCache({required String key, required dynamic value})async{
        if(value is int) {
          await _preferences.setInt(key, value);
        } else if(value is String){
          await _preferences.setString(key, value);
        }
        else if(value is List<String>){
          await _preferences.setStringList(key, value);
        }
        else if(value is bool){
          await _preferences.setBool(key, value);
        }
        else if(value is double){
          await _preferences.setDouble(key, value);
        }
  }

  static dynamic getDataFromCache({required String key}){
    return _preferences.get(key);
  }
  static void deleteFromCache({required String key})async{
     await _preferences.remove(key);
  }
}