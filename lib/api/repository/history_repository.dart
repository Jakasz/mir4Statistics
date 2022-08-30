

import 'package:flutter/foundation.dart';

import '../../models/history_model.dart';
import '../history_api.dart';

class HistoryRepository extends ChangeNotifier {

  var isLoading = true;
  late final HistoryApi apiHistory;
  List<HistoryData> allHistory = [];

  void getHistory() async {
    isLoading = true;
    try {
      allHistory = await HistoryApi().getHistoryData();
    } catch (e) {

    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}