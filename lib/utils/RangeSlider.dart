import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class RangePicker extends StatefulWidget {
  final dynamic maxSalary ;
  const RangePicker({super.key, required this.maxSalary});
  static  double minValue = 1000;
  static double maxValue = 5000;
  @override
  RangePickerState createState() => RangePickerState();
}

class RangePickerState extends State<RangePicker> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ Flexible(
          child: RangeSlider(
              activeColor: AppColors.blueThemeColor,
              values: RangeValues(RangePicker.minValue, RangePicker.maxValue),
              onChanged: (RangeValues values) {
                setState(() {
                  RangePicker.minValue = values.start;
                  RangePicker.maxValue = values.end;
                });
              },
              min: 0.0,
              max: widget.maxSalary,
              divisions: 100,
              labels: RangeLabels('${RangePicker.minValue}', '${ RangePicker.maxValue}'),
            ),
        ),
          Text('Selected Range: ${RangePicker.minValue.toInt()} - ${RangePicker.maxValue.toInt()}'),
        ],
      ),
    );
  }
}
