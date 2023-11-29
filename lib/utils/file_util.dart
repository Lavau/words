import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:words/model/ef_model.dart';
import 'package:words/utils/page_util.dart';


// 获取正确的本地路径
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

// 创建指向文件的引用
Future<File> localFile(String fileName) async {
  try {
    String path = await _localPath;
    File f = File('$path/$fileName');
    bool isExits = await f.exists();
    if (!isExits) {
      f = await f.create();
    }
    return f;
  } catch(e) {
    if (kDebugMode) {
      print(e);
    }
    return File('');
  }

}

// 读文件
Future<EFModel?> read(String fileName) async {
  try {
    File file = await localFile(fileName);
    String contents = await file.readAsString();
    EFModel efModel;
    if (contents.length > 5) {
      efModel = EFModel.fromJson(json.decode(contents));
    } else {
      efModel = EFModel(type: fileName, words: []);
    }
    return efModel;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return null;
  }
}

// 写文件
Future<File?> write(String fileName, String content) async {
  try {
    final file = await localFile(fileName);
    return file.writeAsString(content);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    myShowToast("文件写入失败");
    return null;
  }
}
