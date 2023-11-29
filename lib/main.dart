// flutter build apk -v --no-tree-shake-icons
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:words/model/global.dart';
import 'package:words/utils/dark_mode_util.dart';

import 'page/index_page.dart';


void main() {
  runApp(ChangeNotifierProvider.value(
      value: DarkModeUtil(),
      child: const MainPage()));
  Global.initPreferences();
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    hintColor:Colors.blueAccent,
  );
  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    hintColor:Colors.blueAccent,
  );

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeUtil>(context) ;
    return OKToast(
        dismissOtherOnShow: true,
        child: MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: MediaQuery.of(context).platformBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
          home: const IndexPage()
        )
    );
  }
}

