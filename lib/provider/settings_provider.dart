import 'package:flutter/material.dart';
import '../shared_prefrences/shared_prrefrences.dart';

class SettingsProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.system;

  void init(){
    if(SharedPrefs.getTheme()=='dark'){
      themeMode = ThemeMode.dark;
    }else {
      themeMode = ThemeMode.light;
    }
  }

  void enableLightMode(){
    themeMode = ThemeMode.light;
    SharedPrefs.setTheme("light");
    notifyListeners();
  }
  void enableDarkMode(){
    themeMode = ThemeMode.dark;
    SharedPrefs.setTheme("dark");
    notifyListeners();
  }
  bool isDark(){
    if(themeMode == ThemeMode.dark){
      return true;
    }
    return false;
  }

  // void enableArabic(){
  //   myLocal = Locale('ar');
  //   SharedPrefs.setlan('ar');
  //   notifyListeners();
  // }
  // void enableEnglish(){
  //   myLocal = Locale('en');
  //   SharedPrefs.setlan('en');
  //   notifyListeners();
  // }

}
