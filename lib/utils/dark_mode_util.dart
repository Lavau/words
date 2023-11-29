import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DarkModeUtil with ChangeNotifier {
  //  0:浅色模式；1:深色模式，2:跟随系统
  int _darkModeNum = 2;
  bool _isDarkMode = true;   // 主题模式

  int get darkModeNum => _darkModeNum;
  bool get darkMode => _isDarkMode;

  void changeDarkMode(int darkModeNum, bool isDarkMode) {
    print("$darkModeNum, $isDarkMode");
    if (darkModeNum == 0) {
      _darkModeNum = 0;
      _isDarkMode = false;
    } else if (darkModeNum == 1) {
      _darkModeNum = 1;
      _isDarkMode = true;
    } else {
      _darkModeNum = 2;
      _isDarkMode = isDarkMode;
    }
  }
}

