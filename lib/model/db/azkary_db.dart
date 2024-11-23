class UserAzkar {
  late int id;
  late String title;
  late int number = 0;

  UserAzkar();

  UserAzkar.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap['iD'];
    title = rowMap['title']??'';
    number = rowMap['number'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = title;
    map['number'] = number;
    return map;
  }
}
