import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationProgressTracker extends StatefulWidget {
  final String? companyName ;
  final String? jobId;
  final String? seekerId ;
  const NotificationProgressTracker({super.key, this.companyName, this.jobId, this.seekerId});

  @override
  State<NotificationProgressTracker> createState() => _NotificationProgressTrackerState();
}

class _NotificationProgressTrackerState extends State<NotificationProgressTracker> {

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
              // print(widget.index) ;
              // Get.to(() => MarketingIntern(jobData: jobsController.appliedJobs[widget.index!], appliedJobScreen: true,)) ;
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
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blueThemeColor
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(steps[index]["icon"]!,height: Get.height*.04,)),
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
