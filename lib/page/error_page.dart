import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/ef_model.dart';
import '../utils/file_util.dart';
import '../utils/page_util.dart';


class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  ErrorPageState createState() => ErrorPageState();
}

class ErrorPageState extends State<ErrorPage> {
  bool isLoading = true;
  late EFModel efModel;
  int wordNum = 0;

  @override
  void initState() {
    read("error.json").then((value) {
      if (value == null) {
        myShowToast("文件读取失败");
        return;
      }
      setState(() {
        efModel = value;
        isLoading = !isLoading;
        wordNum = efModel.words.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("错题本"),
      ),
      body: isLoading ?
        const Center(child: SizedBox(
          height: 44.0,
          width: 44.0,
          child: CircularProgressIndicator()
        )) : efModel.words.isEmpty ? const Center(child: Text('错题本是空的！')) :
        ListView.builder(
          itemBuilder: (context, index) {
            return _getItem(wordNum - index - 1);
            },
          itemCount: efModel.words.length,
        )
    );
  }

  Widget _getItem(int index) {
    String createTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(
        DateTime.fromMillisecondsSinceEpoch(efModel.words[index].addTime));
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(efModel.words[index].en, style: TextStyle(fontSize: 18),),
                Text(efModel.words[index].cn, style: TextStyle(fontSize: 18),),
              ]
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getAudio("EN", index),
              _getAudio("US", index)
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${efModel.words[index].chapter}-', style: TextStyle(color: Colors.grey)),
              Text(efModel.words[index].ith.toString(), style: TextStyle(color: Colors.grey)),
            ]
          ),
          Text(createTime, style: TextStyle(color: Colors.grey)),
          InkWell(
            child: Icon(Icons.delete_forever_rounded),
            onTap: () {
              setState(() {
                efModel.words.removeAt(index);
                if (wordNum>0) {
                  wordNum --;
                }
              });
              write("error.json", efModel.toString());
            },
          )
        ],
      ),
    );
  }


  Widget _getAudio(String us, int i) {
    InkWell inkWell = InkWell(
      child: Row(children: [
        Icon(us == "US" ? Icons.audiotrack_sharp : Icons.audiotrack_outlined, color: Colors.blueGrey,),
        Text(us == "US" ? '美音' : "英音", style: TextStyle(color: Colors.blueGrey))
      ]),
      onTap: () {
        AudioPlayer audioPlayer = AudioPlayer();
        audioPlayer.play(AssetSource('sound/Speech_${us == "US" ? "US" : "EN"}/${efModel.words[i].en}.mp3'))
            .catchError((e) {
          myShowToast("播放失败");
        }
        );
      },
    );
    return inkWell;
  }


}