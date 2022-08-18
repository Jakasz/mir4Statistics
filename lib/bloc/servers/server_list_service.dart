import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:legionstat/models/world_model.dart';

class ServerApi {
   Future<List<WorldsData>> getWorldData() async {
    var response = await http.get(Uri.parse('https://clean-sector-356209.ew.r.appspot.com/worlds'));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List _tempData = [];
      for (var i in data['worldNames']) _tempData.add(i);
      return WorldsData.loadWorldFromDb(_tempData);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }
}
