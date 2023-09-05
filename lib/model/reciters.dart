
class Reciters {
  late int id;
  late String name;
  late String letter;
  late List<Moshaf> moshaf;

  Reciters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    letter = json['letter'];
    if (json['moshaf'] != null) {
      moshaf = <Moshaf>[];
      json['moshaf'].forEach((v) {
        moshaf.add(Moshaf.fromJson(v));
      });
    }
  }
}

class Moshaf {
  late int id;
  late String name;
  late String server;
  late int surahTotal;
  late int moshafType;
  late String surahList;

  Moshaf.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    server = json['server'];
    surahTotal = json['surah_total'];
    moshafType = json['moshaf_type'];
    surahList = json['surah_list'];
  }
}
