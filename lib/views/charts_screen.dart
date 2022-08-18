import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legionstat/api/repository/chart_repository.dart';
import 'package:legionstat/models/charts_model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    chartDataProvider.getCharts();
  }

  @override
  Widget build(BuildContext context) {
    final chartProvider = Provider.of<ChartRepository>(context);

    return !chartProvider.isLoading
        ? Consumer<ChartRepository>(
            builder: (context, chartsLoadedData, child) {
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
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          SvgPicture.asset('assets/empty_space.svg',height: 250,)
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
                                  SfCartesianChart(
                                    plotAreaBorderColor: Colors.white,
                                    enableAxisAnimation: true,
                                    tooltipBehavior:
                                        TooltipBehavior(enable: true),
                                    title: ChartTitle(
                                        text: 'PS History',
                                        textStyle:
                                            TextStyle(color: Colors.white)),
                                    primaryYAxis: NumericAxis(
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        axisLine: AxisLine(
                                          color: Colors.blue,
                                        )),
                                    primaryXAxis: DateTimeAxis(
                                        borderColor: Colors.white,
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        axisLine: AxisLine(
                                          color: Colors.blue,
                                        )),
                                    series: <ChartSeries<ChartData, DateTime>>[
                                      LineSeries(
                                          dataSource:
                                              chartsLoadedData.allCharts,
                                          color: Colors.deepOrange,
                                          animationDuration: 1000,
                                          xValueMapper:
                                              (ChartData chartsLoadedData, _) =>
                                                  DateTime(
                                                      int.parse(chartsLoadedData
                                                          .loadDate
                                                          .substring(0, 4)),
                                                      int.parse(chartsLoadedData
                                                          .loadDate
                                                          .substring(5, 7)),
                                                      int.parse(chartsLoadedData
                                                          .loadDate
                                                          .substring(8, 10))),
                                          yValueMapper:
                                              (ChartData _chartsData, _) =>
                                                  double.tryParse(
                                                      _chartsData.battleRate),
                                          name: 'Date/PS',
                                          dataLabelSettings: DataLabelSettings(
                                            isVisible: true,
                                            textStyle:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ],
                                  ),
                                  Container(
                                      child: Center(
                                          child: SvgPicture.asset(
                                    'assets/undraw_searching_re_3ra9.svg',
                                    height: 250,
                                    width: 250,
                                  ))),
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
