import 'package:flutter/material.dart';
import '../../models/history_model.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({Key? key, required this.historyListData})
      : super(key: key);

  final List<HistoryData> historyListData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: historyListData.length,
        itemBuilder: (context, index) {
          return Card(
            color: Color(0xff243B55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),

            elevation: 0,
            child: Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5
                    ),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                      borderRadius: BorderRadius.only(
                       bottomLeft:Radius.circular(10),
                       topLeft:  Radius.circular(10)

                      )
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.stacked_line_chart_outlined, color: Colors.white,
                        size: 50,)
                      ],
                    ),
                  ),

                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(historyListData[index].clanName,
                            style: TextStyle(color: Colors.amber,
                            fontWeight: FontWeight.bold, fontSize: 16),),
                          Text(historyListData[index].userName,
                            style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold, fontSize: 16), )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.access_time_outlined,color: Colors.white),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  historyListData[index].minDate,
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.access_time_outlined, color: Colors.white,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  historyListData[index].maxDate,
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
