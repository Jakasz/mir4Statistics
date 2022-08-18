import 'package:flutter/material.dart';

class ClanMemberWidget extends StatelessWidget {
  final String memberName;
  final String battleRate;
  final String clanName;
  final String lastCheck;

  ClanMemberWidget(
      {required this.memberName,
      required this.battleRate,
      required this.clanName,
      required this.lastCheck});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      elevation: 5,
      color: Color(0xff0B486B),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 5, 7),
                  decoration: BoxDecoration(
                    color: Color(0xFF3282B8),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(5)),
                  ),
                  child: Text(
                    'PS: $battleRate',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 7),
              child: Text(
                memberName,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 7),
              child: Text(
                lastCheck,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              decoration: BoxDecoration(
                color: Color(0xFF3282B8),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(13),
                    bottomRight: Radius.circular(13)),
              ),
              child: Text(
                clanName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
