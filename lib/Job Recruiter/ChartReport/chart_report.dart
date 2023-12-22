import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/controllers/RecruiterReportController/RecruiterReportController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';

import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';

class ChartReport extends StatefulWidget {
  const ChartReport({super.key});

  @override
  State<ChartReport> createState() => _ChartReportState();
}

class _ChartReportState extends State<ChartReport> {
  final List<String> itemsWeekly = ['Sunday', 'Monday', 'Tuesdat'];
  String? weeklyValues;

  final List<String> itemsMonthly = ['January', 'February', 'March'];
  String? monthlyValues;

  final List<String> itemsYearly = ['2000', '2001', '2002'];
  String? yearlyValues;

  RecruiterReportController reportController =
      Get.put(RecruiterReportController());

  @override
  void initState() {
    reportController.reportApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (reportController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (reportController.error.value == 'No internet') {
            return InterNetExceptionWidget(
              onPress: () {
                reportController.reportApi();
              },
            );
          } else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              reportController.reportApi();
            }));
          }
        case Status.COMPLETED:
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SafeArea(
              child: Scaffold(
                backgroundColor: Color(0xff000),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * .02,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Image.asset(
                                  "assets/images/icon_back_blue.png",
                                  height: Get.height * .055,
                                )),
                            SizedBox(
                              width: Get.width * .04,
                            ),
                            Text(
                              "Report",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Get.height * .02,
                        ),
                        Text(
                          "Report",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: Get.height * .027,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: Get.height * .06,
                              width: Get.width * .28,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffFFFFFF)),
                                  borderRadius: BorderRadius.circular(35)),
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Row(
                                      children: [
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Weekly',
                                            style: Get
                                                .theme.textTheme.labelLarge
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w700),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: itemsWeekly
                                        .map((String item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: Get
                                                    .theme.textTheme.bodyLarge!
                                                    .copyWith(
                                                        color: AppColors.white),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: weeklyValues,
                                    onChanged: (String? value) {
                                      setState(() {
                                        weeklyValues = value;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: Get.height * 0.078,
                                      width: Get.width,
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      elevation: 2,
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: Image.asset(
                                          'assets/images/arrowdown.png'),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.yellow,
                                      iconDisabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: Get.height * 0.35,
                                      width: Get.width * 0.902,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Color(0xff353535),
                                      ),
                                      offset: const Offset(5, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: Radius.circular(40),
                                        thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            MaterialStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: Get.height * .06,
                              width: Get.width * .28,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffFFFFFF)),
                                  borderRadius: BorderRadius.circular(35)),
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Row(
                                      children: [
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Monthly',
                                            style: Get
                                                .theme.textTheme.labelLarge
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w700),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: itemsMonthly
                                        .map((String item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: Get
                                                    .theme.textTheme.bodyLarge!
                                                    .copyWith(
                                                        color: AppColors.white),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: monthlyValues,
                                    onChanged: (String? value) {
                                      setState(() {
                                        monthlyValues = value;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: Get.height * 0.078,
                                      width: Get.width,
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(35),
                                      //
                                      //   color: Color(0xff373737),
                                      // ),
                                      elevation: 2,
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: Image.asset(
                                          'assets/images/arrowdown.png'),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.yellow,
                                      iconDisabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: Get.height * 0.35,
                                      width: Get.width * 0.902,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Color(0xff353535),
                                      ),
                                      offset: const Offset(5, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: Radius.circular(40),
                                        thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            MaterialStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: Get.height * .06,
                              width: Get.width * .28,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffFFFFFF)),
                                  borderRadius: BorderRadius.circular(35)),
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Row(
                                      children: [
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Yearly',
                                            style: Get
                                                .theme.textTheme.labelLarge
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w700),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: itemsYearly
                                        .map((String item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: Get
                                                    .theme.textTheme.bodyLarge!
                                                    .copyWith(
                                                        color: AppColors.white),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: yearlyValues,
                                    onChanged: (String? value) {
                                      setState(() {
                                        yearlyValues = value;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: Get.height * 0.078,
                                      width: Get.width,
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(35),
                                      //
                                      //   color: Color(0xff373737),
                                      // ),
                                      elevation: 2,
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: Image.asset(
                                          'assets/images/arrowdown.png'),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.yellow,
                                      iconDisabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: Get.height * 0.35,
                                      width: Get.width * 0.902,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Color(0xff353535),
                                      ),
                                      offset: const Offset(5, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: Radius.circular(40),
                                        thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            MaterialStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * .04,
                        ),
                        // GridView.builder(
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   itemCount: 5,
                        //   shrinkWrap: true,
                        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        //       crossAxisCount: 2,
                        //       crossAxisSpacing: 40,
                        //       mainAxisExtent: 70),
                        //   itemBuilder: (context, index) {
                        //     return SizedBox(
                        //       height: 20,
                        //       width: Get.width * .1,
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(reportController.reportData.value.percentData?.matchProfile ?? "No Data", style: Theme
                        //               .of(context)
                        //               .textTheme
                        //               .displayLarge
                        //               ?.copyWith(fontSize: 30,
                        //               color: Colors.white,
                        //               fontWeight: FontWeight.w700),),
                        //           Text("Match Profile", style: Theme
                        //               .of(context)
                        //               .textTheme
                        //               .titleSmall
                        //               ?.copyWith(fontWeight: FontWeight.w500,
                        //               color: Color(0xffFFFFFF)),)
                        //         ],
                        //       ),
                        //     );
                        //   },),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * .44,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reportController.reportData.value
                                            .totalCountData?.matchProfile
                                            .toString() ??
                                        "No Data",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Match Profile",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xffFFFFFF)),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Get.width * .3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reportController.reportData.value
                                            .totalCountData?.hired
                                            .toString() ??
                                        "No Data",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Hired",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xffFFFFFF)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * .04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * .44,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reportController.reportData.value
                                            .totalCountData?.applicantApplied
                                            .toString() ??
                                        "No Data",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Applicant Applied",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xffFFFFFF)),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Get.width * .3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reportController.reportData.value
                                            .totalCountData?.rejected
                                            .toString() ??
                                        "No Data",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Rejected",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xffFFFFFF)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * .04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reportController.reportData.value
                                          .totalCountData?.interviewSchedule
                                          .toString() ??
                                      "No Data",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Interview Schedule",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xffFFFFFF)),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * .06,
                        ),
                        reportController.reportData.value.percentData?.interviewSchedule == 0 &&
                        reportController.reportData.value.percentData?.hired == 0 &&
                        reportController.reportData.value.percentData?.rejected == 0 ?
                            const SizedBox() :
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 220,
                            // Increased height to accommodate the label
                            child: Stack(
                              children: [
                                CustomPaint(
                                  size: const Size(200, 200),
                                  painter: CylinderPieChartPainter(
                                    segments: [
                                      reportController.reportData.value
                                                      .percentData?.interviewSchedule == null ||
                                              reportController.reportData.value.percentData?.interviewSchedule.toString().length == 0
                                          ? PieSegment(0, Color(0xff4D6FED))
                                          : PieSegment(
                                              double.parse(
                                                  "${reportController.reportData.value.percentData?.interviewSchedule}"),
                                              Color(0xff4D6FED)),
                                      reportController.reportData.value.percentData?.hired == null ||
                                              reportController.reportData.value.percentData?.hired.toString().length == 0
                                          ? PieSegment(0, Color(0xff0F63A4))
                                          : PieSegment(
                                              double.parse(
                                                  "${reportController.reportData.value.percentData?.hired}"),
                                              Color(0xff0F63A4)),
                                      reportController.reportData.value
                                                      .percentData?.rejected ==
                                                  null ||
                                              reportController.reportData.value
                                                      .percentData?.rejected
                                                      .toString()
                                                      .length ==
                                                  0
                                          ? PieSegment(0, Color(0xff2B92DE))
                                          : PieSegment(
                                              double.parse(
                                                  "${reportController.reportData.value.percentData?.rejected}"),
                                              Color(0xff2B92DE)),
                                    ],
                                  ),
                                ),
      Positioned(
                                        top: 60,
                                        left: 20,
                                        child: PercentageBox(
                                          double.parse(
                                              "${reportController.reportData.value.percentData?.interviewSchedule}"),
                                        )),
                                        Positioned(
                                    top: 60,
                                    left: 20,
                                    child: PercentageBox(
                                      double.parse(
                                          "${reportController.reportData.value.percentData?.hired}"),
                                    )),
      Positioned(
                                    top: 60,
                                    left: 20,
                                    child: PercentageBox(
                                      double.parse(
                                          "${reportController.reportData.value.percentData?.rejected}"),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .015,
                        ),
                        reportController.reportData.value.percentData?.interviewSchedule == 0 &&
                            reportController.reportData.value.percentData?.hired == 0 &&
                            reportController.reportData.value.percentData?.rejected == 0 ?
                        const SizedBox() :
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    color: Color(0xff4D6FED),
                                    shape: BoxShape.circle),
                              ),
                              Text(
                                "Interview",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    color: Color(0xff4D6FED),
                                    shape: BoxShape.circle),
                              ),
                              Text(
                                "Hired",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    color: Color(0xff4D6FED),
                                    shape: BoxShape.circle),
                              ),
                              Text(
                                "Rejected",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
      }
    });
  }
}

class PieSegment {
  final double value;
  final Color color;

  PieSegment(this.value, this.color);
}

class CylinderPieChartPainter extends CustomPainter {
  final List<PieSegment> segments;

  CylinderPieChartPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    double startAngle = -90;

    for (var segment in segments) {
      final sweepAngle = 360 * (segment.value / 100);
      final paint = Paint()..color = segment.color;

      final rect = Rect.fromCircle(
        center: Offset(centerX, centerY),
        radius: radius,
      );

      // Draw the outer arc
      canvas.drawArc(
        rect,
        radians(startAngle),
        radians(sweepAngle),
        true,
        paint,
      );

      // Draw a shadow-like effect to simulate a cylinder
      final shadowRect = Rect.fromLTWH(
        centerX - radius,
        centerY,
        radius * 0,
        radius * 0.1, // Adjust thickness for the cylinder illusion
      );

      final shadowPaint = Paint()
        ..color = Colors.black.withOpacity(0.2)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5.0);

      canvas.drawRect(shadowRect, shadowPaint);

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  double radians(double degrees) {
    return degrees * (pi / 180);
  }
}

class PercentageBox extends StatelessWidget {
  final double percentage;

  const PercentageBox(this.percentage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        '$percentage%', // Display the percentage value
        style: const TextStyle(
          color: Colors.white, // Text color is white
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
