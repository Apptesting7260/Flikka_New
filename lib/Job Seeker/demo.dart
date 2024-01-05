import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class MyPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Slice 1": 15,
      "Slice 2": 20,
      "Slice 3": 10,
      "Slice 4": 40,
      "Slice 5": 15,
    };

    List<Color> colorList = [
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
    ];

    return PieChart(
      dataMap: dataMap,
      colorList: colorList,
      chartRadius: MediaQuery.of(context).size.width / 1.2, // Adjust as needed
      animationDuration: const Duration(milliseconds: 800),
      chartType: ChartType.ring, // Optional: Change chart type
      ringStrokeWidth: 30, // Optional: Adjust ring stroke width
      legendOptions: const LegendOptions(
        showLegends: false,
        legendPosition: LegendPosition.right,
      ),
      chartValuesOptions: const ChartValuesOptions(
        // showChartValuesInPercentage: true,
        showChartValuesOutside: true
      ),
    );
  }
}
