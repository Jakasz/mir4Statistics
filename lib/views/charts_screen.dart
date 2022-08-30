import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legionstat/api/repository/chart_repository.dart';
import 'package:legionstat/views/widget/charts.dart';
import 'package:legionstat/views/widget/history_widget.dart';
import 'package:provider/provider.dart';

import '../api/repository/history_repository.dart';
import '../utils/circle_indicator.dart';

class ChartsScreen extends StatefulWidget {
  ChartsScreen();

  @override
  _ChartsScreenState createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen>
    with TickerProviderStateMixin {
  _ChartsScreenState();

  // LineChartData data = LineChartData();
  late final TabController _chartsController;

  @override
  void initState() {
    _chartsController = new TabController(length: 2, vsync: this);
    super.initState();
    final chartDataProvider =
        Provider.of<ChartRepository>(context, listen: false);
    final historyDataProvider =
        Provider.of<HistoryRepository>(context, listen: false);
    historyDataProvider.getHistory();
    chartDataProvider.getCharts();

  }

  @override
  Widget build(BuildContext context) {
    final chartProvider = Provider.of<ChartRepository>(context);
    final historyProvider = Provider.of<HistoryRepository>(context);

    return !chartProvider.isLoading
        ? Consumer2<ChartRepository, HistoryRepository>(
            builder: (context, chartsLoadedData, historyLoadedData, child) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xff243B55),
                  centerTitle: true,
                  title: Text('Statistics'),
                ),
                body: chartsLoadedData.allCharts.length == 0
                    ? Center(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 25),
                            child: Text(
                              'No Data loaded for this player, try again!',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/empty_space.svg',
                            height: 250,
                          )
                        ],
                      ))
                    : Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: TabBar(
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.grey,
                                controller: _chartsController,
                                indicator: TabCircleDecorator(
                                    color: Colors.white, radius: 4),
                                tabs: [
                                  Tab(text: 'Power Score chart'),
                                  Tab(
                                    text: 'Clan History',
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _chartsController,
                                children: [
                                  ChartsWidget(
                                      chartsListValues:
                                          chartsLoadedData.allCharts),
                                  historyProvider.isLoading
                                      ? Container(
                                          child: Center(
                                              child: SvgPicture.asset(
                                          'assets/undraw_searching_re_3ra9.svg',
                                          height: 250,
                                          width: 250,
                                        )))
                                      : HistoryWidget(
                                          historyListData:
                                              historyLoadedData.allHistory,
                                        ),
                                  // Container(
                                  //   child: Icon(Icons.details),
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ));
          })
        : Scaffold(
            body: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ));
  }
}
