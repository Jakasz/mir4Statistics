import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClanDataSheet extends StatelessWidget {
  final String clanName;
  final int clanId;
  final int index;

  ClanDataSheet(
      {required this.clanName, required this.clanId, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 0,
        color: Color(0xFF141E30),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                      height: 60,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(

                              child: ListTile(
                                textColor: Colors.white,
                                  leading: FaIcon(FontAwesomeIcons.guilded,
                                      size: 40, color: Colors.blue),
                                  title: Text(
                                    clanName,
                                    style: TextStyle(fontSize: 18),
                                  )),
                            )
                          ])),
                ),
              ],
            )
          ],
        ));
    throw UnimplementedError();
  }
}
