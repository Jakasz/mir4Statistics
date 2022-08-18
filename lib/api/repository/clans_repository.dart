
import 'package:legionstat/models/clans_list_model.dart';

import '../../bloc/clans/clans_service.dart';

class ClanRepository {
  final ClanListApi _clansProvider = ClanListApi();
  Future<List<ClanListData>> getAllClans() => _clansProvider.getClanData();
}