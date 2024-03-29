import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/SeekerEarningController/SeekerEarningController.dart';
import '../widgets/app_colors.dart';

class AppReferral extends StatefulWidget {
  const AppReferral({super.key});

  @override
  State<AppReferral> createState() => _AppReferralState();
}

class _AppReferralState extends State<AppReferral> {

  SeekerEarningController seekerEarningController =
  Get.put(SeekerEarningController());

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
          "App Referral",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Get.width*.05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Earning",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none),
                      ),
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Text(
                        "\£ ${seekerEarningController.getEarningDetails.value.appReferralAmount}",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                            fontSize: 12, color: AppColors.blueThemeColor),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Referral",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none),
                      ),
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Text(
                        "${seekerEarningController.getEarningDetails.value.totalAppReferrals ?? 0}",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                            fontSize: 12, color: AppColors.blueThemeColor),
                      )
                    ],
                  ),
                ],
              ),
              DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TabBar(
                        isScrollable: true,
                        labelColor: AppColors.blueThemeColor,
                        unselectedLabelColor: Color(0xffCFCFCF),
                        indicatorColor: AppColors.blueThemeColor,
                        indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                        tabs: [
                          Tab(child: Text("EMPLOYEE"),),
                          Tab(child: Text("EMPLOYER"),),
                        ],
                      ),
                      SizedBox(height: Get.height*.02,) ,
                      SizedBox(
                        height: Get.height *.9,
                        child:  TabBarView(
                            children: [
                              seekerEarningController.getEarningDetails.value.appReferrrals?.seekerReferrals?.length == 0 ||
                                  seekerEarningController.getEarningDetails.value.appReferrrals?.seekerReferrals == null ?
                                  Center(child: Text("No data",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),),) :
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: seekerEarningController.getEarningDetails.value.appReferrrals?.seekerReferrals?.length,
                                      itemBuilder: (context, index) {
                                        var data = seekerEarningController.getEarningDetails.value.appReferrrals?.seekerReferrals?[index] ;
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(bottom: Get.height*.02),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(vertical: Get.height*.01),
                                                decoration: BoxDecoration(
                                                    color: AppColors.textFieldFilledColor,
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: ListTile(
                                                  title: Text(data?.fullname ?? "No data",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white,fontWeight: FontWeight.w600),),
                                                  subtitle: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: Get.height*.001,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          // Text("£12.00",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.blueThemeColor),),
                                                          // Text("View",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.blueThemeColor,fontWeight: FontWeight.w600),),
                                                        ],
                                                      ),
                                                      SizedBox(height: Get.height*.001,),
                                                      Text(
                                                        formatDateTime(data?.createdAt != null ? DateTime.parse(data?.createdAt ?? "") : null),
                                                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                          fontWeight: FontWeight.w400,
                                                          color: Color(0xffCFCFCF),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),

                              seekerEarningController.getEarningDetails.value.appReferrrals?.recruiterReferrals?.length == 0 ||
                                  seekerEarningController.getEarningDetails.value.appReferrrals?.recruiterReferrals == null ?
                              Center(child: Text("No data",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),),) :
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: seekerEarningController.getEarningDetails.value.appReferrrals?.recruiterReferrals?.length,
                                  itemBuilder: (context, index) {
                                     var data = seekerEarningController.getEarningDetails.value.appReferrrals?.recruiterReferrals?[index] ;
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: Get.height*.02),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: Get.height*.01),
                                        decoration: BoxDecoration(
                                            color: AppColors.textFieldFilledColor,
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        child: ListTile(
                                          title: Text(  data?.fullname ?? "",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white,fontWeight: FontWeight.w600),),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: Get.height*.001,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // Text(data?.companyName ?? "No data",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.white),),
                                                  // Text("View",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.blueThemeColor,fontWeight: FontWeight.w600),),
                                                ],
                                              ),
                                              SizedBox(height: Get.height*.001,),
                                              Text(
                                                formatDateTime(data?.createdAt != null ? DateTime.parse(data?.createdAt ?? "") : null),
                                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xffCFCFCF),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ]),
                      )
                    ],
                  )),
            ],
          ),
        )
      )),
    );
  }
  String formatDateTime(DateTime? dateTime) {
    final now = DateTime.now();

    if (dateTime == null) {
      return "No date available";
    }

    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "Today at ${DateFormat('hh:mm a').format(dateTime)}";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE').format(dateTime);
    } else {
      return DateFormat('MMMM d, y').format(dateTime); // Include the year
    }
  }
}
