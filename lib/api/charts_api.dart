import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:legionstat/models/charts_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChartsApi {
   Future<List<ChartData>> getChartsData() async {
    final _prefInstance  = await SharedPreferences.getInstance();
    final userName = _prefInstance.getString('userName');
    final subWorldId = _prefInstance.getInt('globalWorldId');
    var response =
    await http.get(Uri.parse('https://clean-sector-356209.ew.r.appspot.com/charts?username=$userName&worldId=$subWorldId'));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List _tempData = [];
      for (var i in data['chartsData']) _tempData.add(i);
      return ChartData.loadChartsFromDB(_tempData);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return List<ChartData>.empty();
    }
  }
}
