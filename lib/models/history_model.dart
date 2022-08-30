class HistoryData {
  final String userName;
  final String clanName;
  final String minDate;
  final String maxDate;

  HistoryData(
      {required this.userName,
        required this.clanName,
        required this.minDate,
        required this.maxDate});

  factory HistoryData.fromJson(dynamic json) {
    return HistoryData(
        userName: json['USER_NAME'],
        clanName: json['CLAN_NAME'],
        minDate: json['MIN_DATE'],
        maxDate: json['MAX_DATE'].toString());

  }

  static List<HistoryData> loadHistoryFromDB(List snapshot) {
    return snapshot.map((data) {
      return HistoryData.fromJson(data);
    }).toList();
  }
}
