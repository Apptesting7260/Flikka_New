import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/SeekerEarningController/SeekerEarningController.dart';
import '../widgets/app_colors.dart';
import '../widgets/my_button.dart';
import 'app_referral.dart';

class WalletSection extends StatefulWidget {
  const WalletSection({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  SeekerEarningController seekerEarningController =
  Get.put(SeekerEarningController());

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset('assets/images/icon_back_blue.png')),
        ),
        elevation: 0,
        title: Text(
          "Wallet",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 15, top: 30),
        //     child: Text("Delete All",
        //         style: Get.theme.textTheme.bodyLarge!.copyWith(
        //             color: AppColors.blueThemeColor)),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Get.width*.07),
        child: Column(
          children: [
            Text(
              "Earnings",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              "How do I earn",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.blueThemeColor,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline),
            ),
            AspectRatio(
              aspectRatio: 1.2,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                       children: [
                         PieChart(
                           PieChartData(
                             pieTouchData: PieTouchData(
                               touchCallback:
                                   (FlTouchEvent event, pieTouchResponse) {
                                 setState(() {
                                   if (!event.isInterestedForInteractions ||
                                       pieTouchResponse == null ||
                                       pieTouchResponse.touchedSection == null) {
                                     touchedIndex = -1;
                                     return;
                                   }
                                   touchedIndex = pieTouchResponse
                                       .touchedSection!.touchedSectionIndex;
                                 });
                               },
                             ),
                             borderData: FlBorderData(
                               show: false,
                             ),
                             sectionsSpace: 0,
                             centerSpaceRadius: Get.height*.12,
                             sections: showingSections(),
                           ),
                         ),
                         Center(child: Text("£440.00",style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 12),))
                       ],
                      ),
                    ),
                  ),
                  // const Column(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //     Indicator(
                  //       color: AppColors.blueThemeColor,
                  //       text: 'First',
                  //       isSquare: true,
                  //     ),
                  //     SizedBox(
                  //       height: 4,
                  //     ),
                  //     Indicator(
                  //       color: AppColors.textFieldFilledColor,
                  //       text: 'Second',
                  //       isSquare: true,
                  //     ),
                  //     SizedBox(
                  //       height: 4,
                  //     ),
                  //     Indicator(
                  //       color: AppColors.red,
                  //       text: 'Third',
                  //       isSquare: true,
                  //     ),
                  //     SizedBox(
                  //       height: 4,
                  //     ),
                  //     Indicator(
                  //       color: AppColors.ratingcodeColor,
                  //       text: 'Fourth',
                  //       isSquare: true,
                  //     ),
                  //     SizedBox(
                  //       height: 18,
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   width: 28,
                  // ),
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("App Referral",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.white)),
                      Text(
                        "\£ 12.00",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: AppColors.blueThemeColor),
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    width: 40,
                    thickness: 2,
                    color: Color(0xffFFFFFF),
                  ),
                  Column(
                    children: [
                      Text("Other",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.white)),
                      Text(
                        "\£ 12.00",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: AppColors.blueThemeColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height*.08,) ,
            Center(
              child: MyButton(
                width: Get.width*.7,
                  title: "REQUEST WITHDRAW",
                  onTap1: () {
                    // seekerEarningController
                    //     .getEarningDetails.value.bankAccount
                    //     ? Get.to(() => const RequestWithdraw())
                    //     : Utils.showMessageDialog(context,
                    //     "Please add bank account details");
                  }),
            ),
            SizedBox(height: Get.height*.02,) ,
            GestureDetector(
              onTap: () {
                _dialogBuilder(context);
              },
              child: Container(
                height: Get.height * .075,
                width: Get.width*.7,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60)),
                child: Text('See Referral Code',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black)),
              ),
            ),
            SizedBox(height: Get.height*.045,) ,
            Align(
              alignment: Alignment.topLeft,
                child: Text("Balance",style: Theme.of(context).textTheme.titleSmall,)),
            SizedBox(height: Get.height*.01,) ,
            Container(
              height: Get.height*0.07,
              width: Get.width*0.85,
              decoration: BoxDecoration(
                  color: AppColors.textFieldFilledColor,
                  borderRadius: BorderRadius.circular(60)
              ),
              child: Row(children: [
                Container(
                  width: Get.width*0.15,
                  height: Get.height,
                  padding: const EdgeInsets.all(13),
                  decoration: const BoxDecoration(
                     color: AppColors.blueThemeColor,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),topLeft: Radius.circular(60))),
                  child: Image.asset(
                    'assets/images/icon_wallets.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:16.0),
                  child: Container(
                    width: Get.width*0.64,
                    child: TextFormField(
                      // controller: amountController,
                      readOnly: true,
                      style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.arrow_forward_ios_rounded,color: AppColors.white,size: 20,),
                        fillColor: Colors.white,
                        border: UnderlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
              ],),
        
            ),
            SizedBox(height: Get.height*.04,) ,
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 13,
                  childAspectRatio: 1.7
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                  Get.to(() => const AppReferral()) ;
                    },
                    child: Container(
                      height: Get.height*.3,
                      width: Get.width*.2,
                      decoration: BoxDecoration(
                        color: AppColors.textFieldFilledColor,
                        borderRadius: BorderRadius.circular(13)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: Get.width*.15,
                              child: Text("App \nReferral",overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,)),
                          const Icon(Icons.arrow_forward_ios_rounded,color: AppColors.white,size: 20,),
                        ],
                      ),
                    ),
                  ) ;
                },),
            SizedBox(height: Get.height*.1,),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 8.0;
      final radius = isTouched ? 60.0 : 15.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.deepOrange,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                decoration: TextDecoration.none
                // shadows: shadows,
                ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.blueThemeColor,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                // shadows: shadows,
                decoration: TextDecoration.none),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.red,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                // shadows: shadows,
                decoration: TextDecoration.none),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                // shadows: shadows,
                decoration: TextDecoration.none),
          );
        default:
          throw Error();
      }
    });
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.only(
              top: Get.height * .2,
              left: Get.width * .05,
              right: Get.width * .05),
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            // height: Get.height*0.4,
            // width: Get.width*.3,
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          decoration: BoxDecoration(
                            // gradient: const LinearGradient(
                            //     colors: [
                            //       Color(0xff56B8F6),
                            //       Color(0xff4D6FED)
                            //     ],begin: Alignment.topCenter,
                            //     end: Alignment.bottomCenter
                            //
                            // ),
                            color: AppColors.blueThemeColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.002,
                  ),
                  Container(
                    height: Get.height * 0.33,
                    width: Get.width * 1,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(52, 52, 52, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        const Text("Referral Code",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Container(
                          height: Get.height * 0.06,
                          width: Get.width * 0.65,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(69, 69, 69, 1),
                              borderRadius: BorderRadius.circular(60)),
                          child: Center(
                            child: Text(
                                "${seekerEarningController.getEarningDetails.value.referralCode}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            _copyToClipboard(
                                "${seekerEarningController.getEarningDetails.value.referralCode}");
                            Get.back();
                          },
                          child: Container(
                            height: Get.height * 0.06,
                            width: Get.width * 0.6,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // gradient: const LinearGradient(
                              //     colors: [
                              //       Color(0xff56B8F6),
                              //       Color(0xff4D6FED)
                              //     ],begin: Alignment.topCenter,
                              //     end: Alignment.bottomCenter
                              //
                              // ),
                                color: AppColors.blueThemeColor,
                                borderRadius: BorderRadius.circular(60)),
                            child: const Text('Copy',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                          ),
                        )
                        //  Icon(Icons.close,color: Colors.white,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _copyToClipboard(String textToCopy) {
    Clipboard.setData(ClipboardData(text: textToCopy));
    // Show a snackbar or any other feedback to inform the user that the text has been copied.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        elevation: 10,
        width: 200,
        content: Text('Text copied to clipboard'),
      ),
    );
  }
}
