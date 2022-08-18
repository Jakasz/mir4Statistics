import 'package:legionstat/models/world_model.dart';

import '../../bloc/servers/server_list_service.dart';

class WorldRepository {
  final ServerApi _worldProvider = ServerApi();
  Future<List<WorldsData>> getAllWorlds() => _worldProvider.getWorldData();
}