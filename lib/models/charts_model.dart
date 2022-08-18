class ChartData {
  final String memberName;
  final String clanName;
  final String loadDate;
  final String battleRate;

  ChartData(
      {required this.memberName,
      required this.clanName,
      required this.loadDate,
      required this.battleRate});

  factory ChartData.fromJson(dynamic json) {
    return ChartData(
        memberName: json['USER_NAME'],
        clanName: json['CLAN_NAME'],
        loadDate: json['LOAD_DATE'],
        battleRate: json['BM_AMOUNT'].toString());

  }

  static List<ChartData> loadChartsFromDB(List snapshot) {
    return snapshot.map((data) {
      return ChartData.fromJson(data);
    }).toList();
  }
}
