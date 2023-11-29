import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'chapter_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  void initState() {
    // _dirList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome～'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _getTiles()
        )
      )
    );
  }

  List<Widget> _getTiles() {
    List<String> tileNames = ["第 3 章", "第 4 章", "第 5 章", "第 11 章"];
    List<List<String>> subtileNames = [['3.2', '3.3-1', '3.3-2', '3.3-3', '3.3-4', '3.3-5', '3.3-6', '3.3-7', '3.3-8', '3.3-9'],
    ['4.2', '4.3-1', '4.3-2', '4.3-3', '4.4'],
    ['5.2', '5.3-1', '5.3-2', '5.3-3', '5.3-4', '5.3-5', '5.3-6', '5.3-7', '5.3-8', '5.3-9', '5.3-10', '5.3-11', '5.3-12'],
    ['11.1', '11.2', '11.3', '11.4']];
    List<ExpansionTile> tiles = <ExpansionTile>[];
    for (int i=0; i < tileNames.length; i++) {
      List<ListTile> listTiles  = <ListTile>[];
      for(int j=0; j < subtileNames[i].length; j++) {
        listTiles.add(ListTile(
            title: Text(subtileNames[i][j]), 
            leading: const Icon(Icons.list),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChapterPage(chapterName: subtileNames[i][j]))),
          )
        );
      }
      tiles.add(ExpansionTile(title: Text(tileNames[i]), children: listTiles));
    }
    return tiles;
  }
}