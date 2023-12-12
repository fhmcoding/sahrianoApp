import 'package:flutter/cupertino.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTranslated(BuildContext context,String key){
  return DemoLocalization.of(context).getTranslatedValue(key);
}

// language code 
const String ENGLSIH = 'en';
const String ARABIC = 'ar';
const String LANGAUGE_CODE ='langugeCode';
Future<Locale> setLocale(String langugeCode)async{
  Cachehelper.sharedPreferences.setString("langugeCode", langugeCode);
  return _locale(langugeCode);
}
Locale _locale(String langugeCode){
   Locale _temp;
    switch (langugeCode) {
      case ENGLSIH:
        _temp = Locale(langugeCode, 'US');
        break;
      case ARABIC:
        _temp = Locale(langugeCode, 'EG');
        break;
      default:
        _temp = Locale(ENGLSIH, 'EG');
    }
    return _temp;
}
Future<Locale> getLocale()async{
SharedPreferences _prefs = await SharedPreferences.getInstance();
 String langugeCode = _prefs.getString(LANGAUGE_CODE) ?? ENGLSIH;
  return _locale(langugeCode);
}