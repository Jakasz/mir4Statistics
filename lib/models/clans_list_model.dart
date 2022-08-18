class ClanListData {
  final String clanName;
  final int clanId;

  ClanListData(
      {required this.clanName,
        required this.clanId});

  factory ClanListData.fromJson(dynamic json) {
    return ClanListData(
        clanName: json['CLAN_NAME'],
        clanId : json['ID']);

  }

  static List<ClanListData> loadClanDataFromDB(List snapshot) {
    return snapshot.map((data) {
      return ClanListData.fromJson(data);
    }).toList();
  }
}
