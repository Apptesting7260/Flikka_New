import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../controllers/SeekerEarningController/SeekerEarningController.dart';
import '../widgets/app_colors.dart';

class EmployementReferral extends StatefulWidget {
  const EmployementReferral({super.key});

  @override
  State<EmployementReferral> createState() => _EmployementReferralState();
}

class _EmployementReferralState extends State<EmployementReferral> {

  SeekerEarningController seekerEarningController =
  Get.put(SeekerEarningController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            "Employement Referral",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              seekerEarningController.getEarningDetails.value.employmentReferrals?.length == 0 ||
                  seekerEarningController.getEarningDetails.value.employmentReferrals == null ?
              Center(child: Text("No data",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),),) :
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: seekerEarningController.getEarningDetails.value.employmentReferrals?.length,
                  itemBuilder: (context, index) {
                    var data = seekerEarningController.getEarningDetails.value.employmentReferrals?[index] ;
                    return Column(
                      children: [
                        SizedBox(height: Get.height*.02,),
                        Padding(
                          padding: EdgeInsets.only(bottom: Get.height*.02),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: Get.height*.01),
                            decoration: BoxDecoration(
                                color: AppColors.textFieldFilledColor,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: ListTile(
                              title: Text(data?.fullName ?? "No data",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white,fontWeight: FontWeight.w600),),
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
            ],
          ),
        ),
      ),
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
