import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  FavoritePageState createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {

  @override
  void initState() {
    // _dirList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome～'),
        ),
        body: SingleChildScrollView(
          child: Text("收藏页")
        )
      )
    );
  }

}