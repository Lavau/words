class WordModel {
  int ith;
  String en;
  String cn;
  String chapter;

  WordModel({required this.ith, required this.en, required this.cn, required this.chapter});

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      ith: json['ith'],
      en: json['en'],
      cn: json['cn'],
      chapter: json['chapter']
    );
  }
}