import 'package:shared_preferences/shared_preferences.dart';

class Preference{

  static SharedPreferences? preferences;
  static  intial() async{
    preferences =  await SharedPreferences.getInstance();
  }
  static Future<bool?> put({required String key,required dynamic value})
  async {
    if(value is bool)  return  await preferences?.setBool(key, value);
    if(value is String)  return  await preferences?.setString(key, value);
    if(value is int)  return  await preferences?.setInt(key, value);
    return  await preferences?.setDouble(key, value);

  }
  static dynamic get({required String key})
  {
    return   preferences?.get(key);
  }
}