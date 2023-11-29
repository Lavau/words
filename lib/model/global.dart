import 'package:shared_preferences/shared_preferences.dart';

class Global{

  // 深色模式：0—浅色模式，1-深色模式，2-跟随系统（默认）
  static int darkMode = 2;
  static bool isDarkMode = false;

  // 定义一个全局的 sp
  static late SharedPreferences preferences;

  // 初始化
  static void initPreferences() async{
    preferences= await SharedPreferences.getInstance();
  }
}
