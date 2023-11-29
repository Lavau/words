import 'package:flutter/material.dart';
import 'package:words/page/dark_mode_page.dart';


class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  InfoPageState createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> {
  bool isShowImage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const Image(image: AssetImage("assets/img.jpg")),
          InkWell(
            onTap: () => showMessage(context),
            child: const ListTile(leading: Icon(Icons.feed_rounded), title: Text("反馈与建议")),
          ),
          // const Divider(),
          // InkWell(
          //   child: const ListTile(leading: Icon(Icons.feed_rounded), title: Text("深色模式设置")),
          //   onTap: () => Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => DarkModePage()),
          // )),
          const Divider()
        ],)
      )
    );
  }

  showMessage(context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("提示信息"),
            content: Text("@Email：lavau@qq.com \nqq：2723986904"),
          );
        }
    );
  }
}