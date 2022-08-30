import 'package:flutter/material.dart';

class ClanDataSheet extends StatelessWidget {
  final String clanName;
  final int clanId;
  final int index;
  final String clanPosition;
  final String clanLeader;
  final String clanBM;

  ClanDataSheet(
      {required this.clanName,
      required this.clanId,
      required this.index,
      required this.clanPosition,
      required this.clanLeader,
      required this.clanBM});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        color: Color(0xFF141E30),
        child: Container(
          height: 110,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Container(
                                child: Text(
                                  '#$clanPosition',
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Text(
                                clanName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.all(7),
                            height: 35,
                            decoration: BoxDecoration(
                                color: Color(0xff0B486B),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '  $clanBM  ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(7),
                        height: 35,
                        decoration: BoxDecoration(
                            color: Color(0xff0B486B),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Clan leader: $clanLeader",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
