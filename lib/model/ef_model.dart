import 'package:words/model/word_model.dart';

import 'ef_word_model.dart';

class EFModel {
  String type;
  List<EFWordModel> words;

  EFModel({required this.type, required this.words});

  factory EFModel.fromJson(Map<String, dynamic> json) {
    return EFModel(
      type: json['type'],
      words: (json['words'] as List).map((e) => EFWordModel.fromJson(e)).toList()
      // words: ws,
    );
  }

  @override
  String toString() {
    return '{"type": "$type", "words": ${words.toString()}}';
  }
}