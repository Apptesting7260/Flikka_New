import 'package:flikka/Payment_Methods/request_withdraw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../controllers/SeekerEarningController/SeekerEarningController.dart';
import '../controllers/SeenUnSeenWalletMessageController/SeenUnSeenWalletMessageController.dart';
import '../controllers/ViewSeekerProfileController/ViewSeekerProfileControllerr.dart';
import '../data/response/status.dart';
import '../res/components/general_expection.dart';
import '../res/components/internet_exception_widget.dart';
import '../utils/utils.dart';
import '../widgets/app_colors.dart';
import '../widgets/my_button.dart';
import 'add_bank_account_details.dart';
import 'app_referral.dart';
import 'employement_referral.dart';

class WalletSection extends StatefulWidget {
  const WalletSection({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  SeekerEarningController seekerEarningController = Get.put(SeekerEarningController());
  ViewSeekerProfileControllerr seekerProfileControllerr = Get.put( ViewSeekerProfileControllerr());
  SeenUnSeenWalletMessageController seenUnSeenWalletMessageControllerInstanse = Get.put(SeenUnSeenWalletMessageController()) ;

  int touchedIndex = -1;
  var total = 0.0 ;
  var appReferral = 0.0;
  var employementReferral = 0.0;
  var subscriptionReferral  = 0.0;

  @override
  void initState() {

    super.initState();
  }

  //////refresh//////
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    seekerEarningController.seekerEarningApi();
    _refreshController.refreshCompleted();
  }

  Map<String, double> dataMap = {};

  List<Color> colorList = [
    AppColors.appReferralColor,
    AppColors.employmentReferralColor,
    AppColors.blueThemeColor,
  ];

  void _onLoading() async {
    seekerEarningController.seekerEarningApi();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }
/////refresh/////

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (seekerEarningController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (seekerEarningController.error.value == 'No internet') {
            return InterNetExceptionWidget(
              onPress: () {
                seekerEarningController.seekerEarningApi();
              },
            );
          } else {
            return GeneralExceptionWidget(onPress: () {
              seekerEarningController.seekerEarningApi();
            });
          }
        case Status.COMPLETED:
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 75,
              leading: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                      seenUnSeenWalletMessageControllerInstanse.seenUnSeenWalletMessage(context,
                          seekerProfileControllerr.viewSeekerData.value.seekerInfo?.email) ;
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
            ),
            body: PopScope(
              canPop: true,
              onPopInvoked: (didPop) {
                if(didPop) {
                  seenUnSeenWalletMessageControllerInstanse.seenUnSeenWalletMessage(context,
                      seekerProfileControllerr.viewSeekerData.value.seekerInfo?.email) ;
                }
              },
              child: SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .07),
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
                      SizedBox(height: Get.height*.04,),
                      AspectRatio(
                        aspectRatio: 1,
                        child: Column(
                          children: <Widget>[
                            PieChart(
                              dataMap: {
                                "Slice 1": seekerEarningController.getEarningDetails.value.appReferralAmount/1 ,
                                "Slice 2": seekerEarningController.getEarningDetails.value.employmentReferralAmount/1,
                                "Slice 3": seekerEarningController.getEarningDetails.value.subscriptionReferralAmount/1,
                              },
                              centerWidget: Text("\£ ${seekerEarningController.getEarningDetails.value.totalAmount}",
                                style: Theme.of(context).textTheme.labelMedium,),
                              emptyColor: AppColors.graySilverColor,
                              colorList: colorList,
                              baseChartColor: AppColors.graySilverColor,
                              totalValue: double.parse("${seekerEarningController.getEarningDetails.value.totalAmount}"),
                              chartRadius: MediaQuery.of(context).size.width / 1.5, // Adjust as needed
                              animationDuration: const Duration(milliseconds: 800),
                              chartType: ChartType.ring, // Optional: Change chart type
                              ringStrokeWidth: 30, // Optional: Adjust ring stroke width
                              legendOptions: const LegendOptions(showLegends: false,
                                legendPosition: LegendPosition.right,),
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: false,
                                  showChartValuesOutside: true,

                              ),
                            )
                          ],
                        ),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 15,
                                          height: 15,
                                          color: AppColors.appReferralColor,
                                        ),
                                        SizedBox(width: 8),
                                        Flexible(  // Use Flexible to handle overflow within Row
                                          child: Text(
                                            "App Referral",
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    Text(
                                      "\£ ${seekerEarningController.getEarningDetails.value.appReferralAmount}",
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.blueThemeColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 20, thickness: 1, color: Color(0xffFFFFFF)),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 15,
                                          height: 15,
                                          color: AppColors.blueThemeColor,
                                        ),
                                        SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            "Subscription Referral",
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    Text(
                                      "\£ ${seekerEarningController.getEarningDetails.value.subscriptionReferralAmount.toString()}",
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.blueThemeColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const VerticalDivider(width: 20, thickness: 1, color: Color(0xffFFFFFF)),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 15,
                                          height: 15,
                                          color: AppColors.employmentReferralColor,
                                        ),
                                        SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            "Employment Referral",
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    Text(
                                      "\£ ${seekerEarningController.getEarningDetails.value.employmentReferralAmount.toString()}",
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.blueThemeColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: Get.height * .06,
                      ),
                      Center(
                        child: MyButton(
                            width: Get.width * .7,
                            title: "REQUEST WITHDRAW",
                            onTap1: () {
                              seekerEarningController.getEarningDetails.value.bankAccount == true
                                  ? Get.to(() => const RequestWithdraw())
                                  : Utils.showMessageDialog(
                                      context, "Please add bank account details");
                            }),
                      ),
                      SizedBox(
                        height: Get.height * .02,
                      ),
                      GestureDetector(
                        onTap: () {
                          _dialogBuilder(context);
                        },
                        child: Container(
                          height: Get.height * .075,
                          width: Get.width * .7,
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
                      SizedBox(
                        height: Get.height * .045,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Balance",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() =>  const AddBankAccountDetails(
                                  ));
                            },
                            child: Text(
                              "Add bank account details",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Container(
                        height: Get.height * 0.07,
                        width: Get.width * 0.85,
                        decoration: BoxDecoration(
                            color: AppColors.textFieldFilledColor,
                            borderRadius: BorderRadius.circular(60)),
                        child: Row(
                          children: [
                            Container(
                              width: Get.width * 0.15,
                              height: Get.height,
                              padding: const EdgeInsets.all(13),
                              decoration: const BoxDecoration(
                                  color: AppColors.blueThemeColor,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(60),
                                      topLeft: Radius.circular(60))),
                              child: Image.asset(
                                'assets/images/icon_wallets.png',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Container(
                                width: Get.width * 0.64,
                                child: TextFormField(
                                  // controller: amountController,
                                  readOnly: true,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.white,
                                        size: 20,
                                      ),
                                      fillColor: Colors.white,
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText:
                                          "£ ${seekerEarningController.getEarningDetails.value.totalAmount ?? 0}",
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .04,
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 13,
                                mainAxisSpacing: 13,
                                childAspectRatio: 1.7),
                        itemBuilder: (context, index) {
                          List<String> itemTexts = [
                            "App \nReferral",
                            "Subscription Referral",
                            "Employment Referral",
                            "Recruitment Referral",
                          ];
                          return GestureDetector(
                            onTap: () {
                              if (index == 0) {
                                Get.to(() => const AppReferral());
                              } else {
                                if(index == 2) {
                                  Get.to(() => const EmployementReferral()) ;
                                }
                              }
                            },
                            child: Container(
                              height: Get.height * .3,
                              width: Get.width * .2,
                              decoration: BoxDecoration(
                                  color: AppColors.textFieldFilledColor,
                                  borderRadius: BorderRadius.circular(13)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                      width: Get.width * .22,
                                      child: Text(
                                        itemTexts[index],
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        // textAlign: TextAlign.center,
                                      )),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: Get.height * .1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
      }
    });
  }
  // List<PieChartSectionData> showingSections() {
  //  var total = double.parse(seekerEarningController.getEarningDetails.value.totalAmount ?? "") ;
  //  var appReferral = seekerEarningController.getEarningDetails.value.appReferralAmount ;
  //  var employementReferral = seekerEarningController.getEarningDetails.value.employmentReferralAmount ;
  //
  //
  //   return List.generate(3, (i) {
  //     final isTouched = i == touchedIndex;
  //     final fontSize = isTouched ? 20.0 : 10.0;
  //     final radius = isTouched ? 60.0 : 40.0;
  //     const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
  //     switch (i) {
  //       case 0:
  //         return PieChartSectionData(
  //           color: Color(0xff0F63A4),
  //           value: 25,
  //           title: '25%',
  //           radius: radius,
  //           titleStyle: TextStyle(
  //               fontSize: fontSize,
  //               fontWeight: FontWeight.bold,
  //               color: AppColors.white,
  //               decoration: TextDecoration.none
  //             // shadows: shadows,
  //           ),
  //         );
  //       case 1:
  //         return PieChartSectionData(
  //           color: Color(0xff25BFC3),
  //           value: 25,
  //           title: '25%',
  //           radius: radius,
  //           titleStyle: TextStyle(
  //               fontSize: fontSize,
  //               fontWeight: FontWeight.bold,
  //               color: AppColors.white,
  //               // shadows: shadows,
  //               decoration: TextDecoration.none),
  //         );
  //       case 2:
  //         return PieChartSectionData(
  //           color: AppColors.blueThemeColor,
  //           value: 25,
  //           title: '25%',
  //           radius: radius,
  //           titleStyle: TextStyle(
  //               fontSize: fontSize,
  //               fontWeight: FontWeight.bold,
  //               color: AppColors.white,
  //               // shadows: shadows,
  //               decoration: TextDecoration.none),
  //         );
  //       case 3:
  //         return PieChartSectionData(
  //           color: Color(0xff33CEFF),
  //           value: 25,
  //           title: '25%',
  //           radius: radius,
  //           titleStyle: TextStyle(
  //               fontSize: fontSize,
  //               fontWeight: FontWeight.bold,
  //               color: AppColors.white,
  //               // shadows: shadows,
  //               decoration: TextDecoration.none),
  //         );
  //       default:
  //         throw Error();
  //     }
  //   });
  // }

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
