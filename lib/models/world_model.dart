class WorldsData {
  final int worldId;
  final String worldName;
  final int subWorldId;
  final String subWorldName;

  WorldsData(
      {required this.worldName,
      required this.worldId,
      required this.subWorldId,
      required this.subWorldName});

  factory WorldsData.fromJson(dynamic json) {
    return WorldsData(
        worldName: json['WORLD_NAME'],
        worldId: json['WORLD_ID'],
        subWorldId: json['SUBWORLD_ID'],
        subWorldName: json['SUBWORLD_NAME']);
  }

  static List<WorldsData> loadWorldFromDb(List snapshot) {
    return snapshot.map((data) => WorldsData.fromJson(data)).toList();
  }
}
