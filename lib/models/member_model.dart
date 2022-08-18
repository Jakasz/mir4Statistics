class MemberData {
  final String memberName;
  final String clanName;
  final String loadDate;
  final String battleRate;

  MemberData(
      {required this.memberName,
      required this.clanName,
      required this.loadDate,
      required this.battleRate});

  factory MemberData.fromJson(dynamic json) {
    return MemberData(
        memberName: json['USER_NAME'],
        clanName: json['CLAN_NAME'],
        loadDate: json['LOAD_DATE'],
        battleRate: json['BM_AMOUNT'].toString());
  }

  static List<MemberData> loadRateFromDB(List snapshot) {
    return snapshot.map((data) {
      return MemberData.fromJson(data);
    }).toList();
  }
}
