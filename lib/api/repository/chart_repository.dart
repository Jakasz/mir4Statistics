import 'package:flutter/material.dart';

import '../../models/charts_model.dart';
import '../charts_api.dart';

class ChartRepository extends ChangeNotifier {
  var isLoading = true;
  late final ChartsApi apiChart;
  List<ChartData> allCharts = [];

  void getCharts() async {
    isLoading = true;
    try {
      allCharts = await ChartsApi().getChartsData();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }
}
