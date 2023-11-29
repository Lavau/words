import 'package:words/model/word_model.dart';

class ChapterModel {
  String name;
  List<WordModel> words;

  ChapterModel({required this.name, required this.words});

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      name: json['name'],
      words: (json['words'] as List).map((e) => WordModel.fromJson(e)).toList()
      // words: ws,
    );
  }
}