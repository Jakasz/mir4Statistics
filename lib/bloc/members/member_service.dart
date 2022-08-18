import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:legionstat/models/member_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MembersApi {
    Future<List<MemberData>> getMemberData() async {
    final _prefInstance = await SharedPreferences.getInstance();
    final _clanId = _prefInstance.getInt('clanId');
    final _worldId = _prefInstance.getInt('globalWorldId');
    var response = await http.get(Uri.parse('https://clean-sector-356209.ew.r.appspot.com/members?clanid=$_clanId&worldid=$_worldId'));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List _tempData = [];
      for (var i in data['MEMBERS']) _tempData.add(i);
      return MemberData.loadRateFromDB(_tempData);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
