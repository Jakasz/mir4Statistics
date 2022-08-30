import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/charts_model.dart';

class ChartsWidget extends StatelessWidget {
  const ChartsWidget({Key? key, required this.chartsListValues}) : super(key: key);

  final List<ChartData> chartsListValues;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderColor: Colors.white,
      enableAxisAnimation: true,
      tooltipBehavior: TooltipBehavior(enable: true),
      title: ChartTitle(
          text: 'PS History', textStyle: TextStyle(color: Colors.white)),
      primaryYAxis: NumericAxis(
          labelStyle: TextStyle(color: Colors.white),
          axisLine: AxisLine(
            color: Colors.blue,
          )),
      primaryXAxis: DateTimeAxis(
          borderColor: Colors.white,
          labelStyle: TextStyle(color: Colors.white),
          axisLine: AxisLine(
            color: Colors.blue,
          )),
      series: <ChartSeries<ChartData, DateTime>>[
        LineSeries(
            dataSource: chartsListValues,
            color: Colors.deepOrange,
            animationDuration: 1000,
            xValueMapper: (ChartData chartsLoadedData, _) => DateTime(
                int.parse(chartsLoadedData.loadDate.substring(0, 4)),
                int.parse(chartsLoadedData.loadDate.substring(5, 7)),
                int.parse(chartsLoadedData.loadDate.substring(8, 10))),
            yValueMapper: (ChartData _chartsData, _) =>
                double.tryParse(_chartsData.battleRate),
            name: 'Date/PS',
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
