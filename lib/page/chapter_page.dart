import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:words/model/chapter_model.dart';
import 'package:words/model/ef_model.dart';
import 'package:words/model/ef_word_model.dart';
import 'package:words/utils/file_util.dart';
import '../utils/page_util.dart';


class ChapterPage extends StatefulWidget {
  String chapterName;

  ChapterPage({super.key, required this.chapterName});

  @override
  ChapterPageState createState() => ChapterPageState();
}

class ChapterPageState extends State<ChapterPage> {
  int currentWordIth = 0;
  bool isShowCN = false;
  bool isLoading = true;
  late ChapterModel chapterModel;

  TextEditingController controller  = TextEditingController();

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      final counter = prefs.getInt(widget.chapterName) ?? 0;
      if (counter == 0) {
        prefs.setInt(widget.chapterName, 0);
      }
      setState(() {
        currentWordIth = counter;
      });
    });

    rootBundle.loadString('assets/json/${widget.chapterName}.json').then((value) {
      setState(() {
        chapterModel = ChapterModel.fromJson(json.decode(value));
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(widget.chapterName, currentWordIth);
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.golf_course_rounded),
            onPressed: onTapIconButton,
          ),
          title: Text(widget.chapterName),
        ),
        body: isLoading ?
          const SizedBox(
            height: 44.0,
            width: 44.0,
            child: CircularProgressIndicator()
          ) : Column(
            children: [
              _getWords()[currentWordIth],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  getButton(onTapBef, context, "上一个"),
                  getButton(onTapAft, context, "下一个"),
                ],
              ),
              getButton(onTapError, context, "不认识？把 Ta 加入错题本吧"),
              getButton(onTapShowCN, context, "显示汉语意思"),
              // getButton((){}, context, "收藏"),
            ],
          )
    );
  }

  List<Widget> _getWords() {
    List<Widget> words = <Widget>[];
    for (int i=0; i<chapterModel.words.length; i++) {
      Widget w = Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 10),
        child: Column(
          children: [
            Text('${chapterModel.words[i].ith}'),
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
            Text(chapterModel.words[i].en, style: const TextStyle(fontSize: 28)),
            const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              _getAudio("EN", i),
              _getAudio("US", i)
            ],),
            const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
            // Text(chapterModel.words[i].cn),
          ],
        )
      );
      words.add(w);
    }
    return words;
  }

  Widget _getAudio(String us, int i) {
    InkWell inkWell = InkWell(
      child: Row(children: [
        Icon(us == "US" ? Icons.audiotrack_sharp : Icons.audiotrack_outlined),
        Text(us == "US" ? '美音' : "英音")
      ]),
      onTap: () {
        AudioPlayer audioPlayer = AudioPlayer();
        audioPlayer.play(AssetSource('sound/Speech_${us == "US" ? "US" : "EN"}/${chapterModel.words[i].en}.mp3'))
            .catchError((e) {
              myShowToast("播放失败");
            }
          );
      },
    );
    return inkWell;
  }

  onTapBef() {
    if(currentWordIth == 0) {
      myShowToast("往前没有咯");
    } else {
      setState(() {
        currentWordIth --;
      });
    }
  }

  onTapAft() {
    if(currentWordIth == (chapterModel.words.length - 1)) {
      myShowToast("往后没有咯");
    } else {
      setState(() {
        currentWordIth ++;
      });
    }
  }

  onTapShowCN() {
    myShowToast(chapterModel.words[currentWordIth].cn);
  }

  onTapError() {
    const fileName = "error.json";
    read(fileName).then((value) {
      if (value == null) {
        myShowToast("文件读取失败");
        return;
      }

      EFModel efModel = value;

      for (int i=efModel.words.length-1; i>=0; i--) {
        print("============================================");
        print(efModel);
        if (efModel.words[i].en == chapterModel.words[currentWordIth].en) {
          myShowToast("${chapterModel.words[currentWordIth].en} 在错题本中已存在！");
          return;
        }
      }

      EFWordModel efWordModel = EFWordModel(
          ith: chapterModel.words[currentWordIth].ith,
          en: chapterModel.words[currentWordIth].en,
          cn: chapterModel.words[currentWordIth].cn,
          chapter: chapterModel.words[currentWordIth].chapter,
          addTime: DateTime.now().millisecondsSinceEpoch
      );
      efModel.words.add(efWordModel);
      String content = efModel.toString();
      print('=========================');
      print(content);
      write(fileName, content);
      myShowToast("添加成功");
    });
  }

  onTapIconButton() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("跳转到该单元的哪个单词？"),
            content: Text("范围：1—${chapterModel.words.length}"),
            actions: [
              TextField(
                keyboardType: TextInputType.number,
                controller: controller,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(child: Text("取消"), onPressed: () => Navigator.pop(context, -1)),
                  const SizedBox(width: 12),
                  OutlinedButton(child: Text("确定"), onPressed: () {
                    try {
                      int num = int.parse(controller.text)-1;
                      if (0 <= num && num < chapterModel.words.length) {
                        setState(() {
                          currentWordIth = num;
                        });
                      } else {
                        myShowToast("输入错误");
                      }
                      Navigator.pop(context, -1);
                    } catch(e) {
                      myShowToast("输入错误");
                      Navigator.pop(context, -1);
                    }
                  }),
                ],
              )
            ],
          );
        }
    );
  }
}