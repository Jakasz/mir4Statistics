import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:legionstat/models/clans_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClanListApi {
    Future<List<ClanListData>> getClanData() async {
    final _prefInstance  = await SharedPreferences.getInstance();
    final subWorldId = _prefInstance.getInt('globalWorldId');
    var response = await http.get(Uri.parse('https://clean-sector-356209.ew.r.appspot.com/clans?worldid=$subWorldId'));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List _tempData = [];
      for (var i in data['CLANS']) _tempData.add(i);
      return ClanListData.loadClanDataFromDB(_tempData);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
