
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/history_model.dart';
import 'package:http/http.dart' as http;

class HistoryApi{
  Future<List<HistoryData>> getHistoryData() async {
    final _prefInstance  = await SharedPreferences.getInstance();
    final userName = _prefInstance.getString('userName');
    final subWorldId = _prefInstance.getInt('globalWorldId');
    var response = await http.get(Uri.parse('https://clean-sector-356209.ew.r.appspot.com/history?username=$userName&worldId=$subWorldId'));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List _tempData = [];
      for (var i in data['userHistory']) _tempData.add(i);
      return HistoryData.loadHistoryFromDB(_tempData);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return List<HistoryData>.empty();
    }
  }
}