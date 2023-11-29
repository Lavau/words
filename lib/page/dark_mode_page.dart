import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words/utils/dark_mode_util.dart';


class DarkModePage extends StatefulWidget{
  const DarkModePage({super.key});

  @override
  State<StatefulWidget> createState() => _DarkModePageState();

}

class _DarkModePageState extends State<DarkModePage>{

  var darkMap = {
    0: '浅色模式',
    1: '深色模式',
    2: '跟随系统'
  };

  int darkModel = 2;

  
  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeUtil>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("深色模式"),
        ),
        body: ListView.separated(
          itemCount: 3,
          separatorBuilder: (context,index){
            return const Divider();
          },
          itemBuilder: (context, index){
            return ListTile(
              title: Text(darkMap[index]!),
              trailing: Offstage(
                offstage: darkModel != index,
                child: const Icon(Icons.check),
              ),
              onTap: () {
                bool isDarkMode = false;
                if (index == 0) {
                  isDarkMode = false;
                } else if (index == 1) {
                  isDarkMode = true;
                } else if (index == 2) {
                  isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
                }
                darkMode.changeDarkMode(index, isDarkMode);
                setState(() {
                  darkModel = index;
                });
              },
            );
          },
        ),
    );
  }

}
