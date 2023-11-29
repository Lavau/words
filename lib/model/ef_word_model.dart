class EFWordModel {
  int ith;
  String en;
  String cn;
  String chapter;
  int addTime;

  EFWordModel({required this.ith, required this.en, required this.cn, required this.chapter, required this.addTime});

  factory EFWordModel.fromJson(Map<dynamic, dynamic> json) {
    return EFWordModel(
      ith: int.parse(json['ith']),
      en: json['en'],
      cn: json['cn'],
      chapter: json['chapter'],
      addTime: int.parse(json['addTime'])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ith': ith,
      'en': en,
      'cn': cn,
      'chapter': chapter,
      'addTime': addTime
    };
  }

  @override
  String toString() {
    return '{"ith": "$ith", "en":  "$en", "cn": "$cn", "chapter": "$chapter", "addTime": "$addTime"}';
  }
}