class ClanListData {
  final String clanName;
  final int clanId;
  final String clanLeader;
  final String clanBM;
  final String clanPosition;

  ClanListData({
    required this.clanName,
    required this.clanId,
    required this.clanLeader,
    required this.clanBM,
    required this.clanPosition,
  });

  factory ClanListData.fromJson(dynamic json) {
    return ClanListData(
        clanName: json['CLAN_NAME'],
        clanId: json['ID'],
        clanLeader: json['CLAN_LEADER'],
        clanBM: json['CLAN_BM'],
        clanPosition: json['CLAN_POSITION']);
  }

  static List<ClanListData> loadClanDataFromDB(List snapshot) {
    return snapshot.map((data) {
      return ClanListData.fromJson(data);
    }).toList();
  }
}
