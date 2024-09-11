import 'package:flutter/material.dart';
import 'package:music_player/theme/theme.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkmode;

  set themeData(ThemeData themeData){
      _themeData = themeData;
      notifyListeners();
  }

  void switchMode(){
    if (_themeData == lightMode) _themeData = darkmode;
    else _themeData = lightMode;
    notifyListeners();
  }

}