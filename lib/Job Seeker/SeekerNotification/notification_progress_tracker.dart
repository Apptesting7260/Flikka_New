import 'package:flikka/Job%20Seeker/SeekerJobs/AppliedJobs.dart';
import 'package:flikka/Job%20Seeker/SeekerNotification/viewJobFromNotification.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/SeekerNotificationDataViewController/SeekerNotificationViewDataController.dart';

class NotificationProgressTracker extends StatefulWidget {
  final String? companyName ;
  final String? jobId;
  final String? seekerId ;
  final int? index;
  const NotificationProgressTracker({super.key, this.companyName, this.jobId, this.seekerId, this.index});

  @override
  State<NotificationProgressTracker> createState() => _NotificationProgressTrackerState();
}

class _NotificationProgressTrackerState extends State<NotificationProgressTracker> {

  SeekerViewNotificationController SeekerViewNotificationControllerInstanse = Get.put(SeekerViewNotificationController()) ;

  final List<Map<String, String>> steps = [
    {"icon": "assets/images/icon_applied_step.png", "text": "APPLIED"},
    {"icon": "assets/images/icon_assessed_step.png", "text": "ASSESSED"},
    {"icon": "assets/images/icon_interview_step.png", "text": "INTERVIEW"},
    {"icon": "assets/images/icon_present_Step.png", "text": "PRESENT"},
    {"icon": "assets/images/icon_offer_step.png", "text": "OFFER"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset('assets/images/icon_back_blue.png',scale: 4,)),
        elevation: 0,
        title: GestureDetector(
            onTap: () {
              Get.to(() => ViewNotificationJob(
                companyName: "${SeekerViewNotificationControllerInstanse
                    .viewSeekerNotificationData.value.seekerNotification?[widget.index!].companyName}",
                jobId: "${SeekerViewNotificationControllerInstanse
                    .viewSeekerNotificationData.value.seekerNotification?[widget.index!].jobId}",
                seekerId: "${SeekerViewNotificationControllerInstanse
                    .viewSeekerNotificationData.value.seekerNotification?[widget.index!].seekerId}",
              ));
            },
            child: Text(widget.companyName!,overflow: TextOverflow.ellipsis,style: Get.theme.textTheme.displayLarge)),
      ),
      body: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: steps.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(height: Get.height*.02,) ,
              Container(
                padding:  const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white,width: 2)
                ),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index + 1 <= stepCount ? Colors.white : AppColors.blueThemeColor
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: index + 1 <= stepCount ?  Image.asset(steps[index]["icon"]!,height: Get.height*.04,): Image.asset(steps[index]["icon"]!,height: Get.height*.04,color: Colors.white,) ),
                ),
              ),
              SizedBox(height: Get.height*.01,),
              Text(
                steps[index]["text"]!,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: Get.height*.03,),
            ],
          );
        },),
    );
  }
}
