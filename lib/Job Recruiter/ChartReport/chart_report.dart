
import 'package:flikka/controllers/RecruiterReportController/RecruiterReportController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';

class ChartReport extends StatefulWidget {
  const ChartReport({super.key});

  @override
  State<ChartReport> createState() => _ChartReportState();
}

class _ChartReportState extends State<ChartReport> {

  RecruiterReportController reportController = Get.put(RecruiterReportController());

  //////refresh//////
  // RefreshController _refreshController =
  // RefreshController(initialRefresh: false);
  //
  // void _onRefresh() async{
  //   await reportController.reportApi() ;
  //   _refreshController.refreshCompleted();
  // }
  //
  // void _onLoading() async{
  //   await reportController.reportApi() ;
  //   if(mounted)
  //     setState(() {
  //
  //     });
  //   _refreshController.loadComplete();
  // }
  /////refresh/////

  @override
  void initState() {
    dataMap = {
      "Slice 1": double.parse("${reportController.reportData.value.totalCountData?.matchProfile ?? 0}"),
      "Slice 2": double.parse("${reportController.reportData.value.totalCountData?.applicantApplied ?? 0}"),
      "Slice 3": double.parse("${reportController.reportData.value.totalCountData?.hired ?? 0}"),
      "Slice 4": double.parse("${reportController.reportData.value.totalCountData?.interviewSchedule ?? 0}"),
      "Slice 5": double.parse("${reportController.reportData.value.totalCountData?.rejected ?? 0}"),
    };
    super.initState();
  }

  Map<String, double> dataMap = {};

  List<Color> colorList = [
    AppColors.blueThemeColor,
    Color(0xff0BA7D9),
    Color(0xff33CEFF),
    Color(0xff0C5A96),
    Color(0xff25BFC3),
  ];

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
                backgroundColor: const Color(0xff000),
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
                          height: Get.height * .035,
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
                        // reportController.reportData.value.totalCountData
                        //                 ?.interviewSchedule ==
                        //             0 &&
                        //         reportController
                        //                 .reportData.value.totalCountData?.hired ==
                        //             0 &&
                        //         reportController.reportData.value.totalCountData
                        //                 ?.rejected ==
                        //             0 &&
                        //       reportController.reportData.value.totalCountData?.matchProfile ==
                        //           0 &&
                        //       reportController.reportData.value.totalCountData?.applicantApplied ==
                        //       0
                        //     ? const SizedBox()
                        //     : Center(
                        //         child: SizedBox(
                        //           width: 200,
                        //           height: 220,
                        //           // Increased height to accommodate the label
                        //           child: Stack(
                        //             children: [
                        //               CustomPaint(
                        //                 size: const Size(200, 200),
                        //                 painter: CylinderPieChartPainter(
                        //                   segments: [
                        //                     reportController.reportData.value.totalCountData?.interviewSchedule ==
                        //                                 null ||
                        //                             reportController.reportData.value.totalCountData?.interviewSchedule.toString().length == 0
                        //                         ? PieSegment(
                        //                             0, Colors.red)
                        //                         : PieSegment(
                        //                             double.parse(
                        //                                 "${reportController.reportData.value.totalCountData?.interviewSchedule}"),
                        //                             Colors.pink),
                        //                     reportController.reportData.value.totalCountData?.hired ==
                        //                                 null ||
                        //                             reportController.reportData.value.totalCountData?.hired.toString().length == 0
                        //                         ? PieSegment(
                        //                             0, Color(0xff0F63A4))
                        //                         : PieSegment(
                        //                             double.parse(
                        //                                 "${reportController.reportData.value.totalCountData?.hired}"),
                        //                             AppColors.white),
                        //                     reportController.reportData.value.totalCountData?.rejected ==
                        //                                 null ||
                        //                             reportController.reportData.value.totalCountData?.rejected.toString().length == 0
                        //                         ? PieSegment(
                        //                             0, Color(0xff2B92DE))
                        //                         : PieSegment(
                        //                             double.parse(
                        //                                 "${reportController.reportData.value.totalCountData?.rejected}"),
                        //                             Colors.yellow),
                        //                     reportController.reportData.value.totalCountData?.applicantApplied.toString().length == 0
                        //                     ? PieSegment(0, Color(0xff2B92DE))
                        //                         : PieSegment(double.parse("${reportController.reportData.value.totalCountData?.applicantApplied}"),
                        //                         AppColors.blueThemeColor),
                        //
                        //                     reportController.reportData.value.totalCountData?.matchProfile.toString().length == 0
                        //                         ? PieSegment(0, Color(0xff2B92DE))
                        //                         : PieSegment(double.parse("${reportController.reportData.value.totalCountData?.matchProfile}"),
                        //                         Colors.orange),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Positioned(
                        //                   top: 60,
                        //                   left: 140,
                        //                   child: PercentageBox(
                        //                     double.parse(
                        //                         "${reportController.reportData.value.totalCountData?.interviewSchedule}"),
                        //                   )),
                        //               Positioned(
                        //                   top: 60,
                        //                   left: 90,
                        //                   child: PercentageBox(
                        //                     double.parse(
                        //                         "${reportController.reportData.value.totalCountData?.hired}"),
                        //                   )),
                        //               Positioned(
                        //                   top: 60,
                        //                   left: 20,
                        //                   child: PercentageBox(
                        //                     double.parse(
                        //                         "${reportController.reportData.value.totalCountData?.rejected}"),
                        //                   )),
                        //               Positioned(
                        //                   top: 90,
                        //                   left: 20,
                        //                   child: PercentageBox(
                        //                     double.parse(
                        //                         "${reportController.reportData.value.totalCountData?.matchProfile}"),
                        //                   )),
                        //               Positioned(
                        //                   top: 120,
                        //                   left: 20,
                        //                   child: PercentageBox(
                        //                     double.parse(
                        //                         "${reportController.reportData.value.totalCountData?.applicantApplied}"),
                        //                   )),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        // SizedBox(
                        //   height: Get.height * .015,
                        // ),
                        // reportController.reportData.value.totalCountData
                        //                 ?.interviewSchedule ==
                        //             0 &&
                        //         reportController
                        //                 .reportData.value.totalCountData?.hired ==
                        //             0 &&
                        //         reportController.reportData.value.totalCountData
                        //                 ?.rejected ==
                        //             0
                        //     ? const SizedBox()
                        //     : Center(
                               // child:
                        Center(
                          child: PieChart(
                            dataMap: dataMap,
                            colorList: colorList,
                            chartRadius: MediaQuery.of(context).size.width / 1.4, // Adjust as needed
                            animationDuration: Duration(milliseconds: 800),
                            chartType: ChartType.disc, // Optional: Change chart type
                            ringStrokeWidth: 30, // Optional: Adjust ring stroke width
                            legendOptions: LegendOptions(
                              showLegends: false,
                              legendPosition: LegendPosition.right,
                            ),
                            chartValuesOptions: ChartValuesOptions(
                               showChartValuesInPercentage: true,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height*.04,),
                        Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 18,
                                      width: 18,
                                      decoration: BoxDecoration(
                                          color: Color(0xff0F63A4),
                                          shape: BoxShape.circle),
                                    ),
                                    Text(
                                      "Interview",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Container(
                                      height: 18,
                                      width: 18,
                                      decoration: BoxDecoration(
                                          color: Color(0xff33CEFF),
                                          shape: BoxShape.circle),
                                    ),
                                    Text(
                                      "Hired",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Container(
                                      height: 18,
                                      width: 18,
                                      decoration: BoxDecoration(
                                          color: Color(0xff0EBBF1),
                                          shape: BoxShape.circle),
                                    ),
                                    Text(
                                      "Rejected",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),

                                  ],
                                ),
                        SizedBox(height: Get.height*.02,),
                        Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 18,
                                      width: 18,
                                      decoration: BoxDecoration(
                                          color: AppColors.blueThemeColor,
                                          shape: BoxShape.circle),
                                    ),
                                    Text(
                                      "Match Profile",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Container(
                                      height: 18,
                                      width: 18,
                                      decoration: BoxDecoration(
                                          color: Color(0xff25BFC3),
                                          shape: BoxShape.circle),
                                    ),
                                    Text(
                                      "Applicant Applied",overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall?.copyWith(fontSize: 18),
                                    ),
                                  ],
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

  PieSegment(this.value, this.color,);
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
          color: AppColors.white, // Text color is white
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
