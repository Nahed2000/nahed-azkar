class AyaDbModel {
  late int id;
  late String ayaText;
  late String suraName;
  late int ayaNumber;

  AyaDbModel();

  AyaDbModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    ayaText = map['aya_text'];
    suraName = map['sura_name'];
    ayaNumber = map['aya_number'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['aya_text'] = ayaText;
    map['sura_name'] = suraName;
    map['aya_number'] = ayaNumber;
    return map;
  }
}
