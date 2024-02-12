import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/SeekerAppliedJobsController/SeekerAppliedJobsController.dart';
import '../marketing_page.dart';
import 'AppliedJobs.dart';

class ProgressTracker extends StatefulWidget {
  final int? index ;
  final dynamic jobData ;
  const ProgressTracker({super.key, this.index, this.jobData,});

  @override
  State<ProgressTracker> createState() => _ProgressTrackerState();
}

class _ProgressTrackerState extends State<ProgressTracker> {

  final List<Map<String, String>> steps = [
    {"icon": "assets/images/icon_applied_step.png", "text": "APPLIED"},
    {"icon": "assets/images/icon_assessed_step.png", "text": "ASSESSED"},
    {"icon": "assets/images/icon_interview_step.png", "text": "INTERVIEW"},
    {"icon": "assets/images/icon_present_Step.png", "text": "PRESENT"},
    {"icon": "assets/images/icon_offer_step.png", "text": "OFFER"}
  ];

  SeekerAppliedJobsController jobsController = Get.put(SeekerAppliedJobsController()) ;

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
              print(widget.index) ;
              Get.to(() => MarketingIntern(jobData: jobsController.appliedJobs[widget.index!], appliedJobScreen: true,)) ;
            },
            child: Text("${widget.jobData?.jobTitle ?? ""}",overflow: TextOverflow.ellipsis,style: Get.theme.textTheme.displayLarge)),
      ),
      body: Stack(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
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
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index + 1 <= stepCount ? Colors.white : AppColors.blueThemeColor
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: index + 1 <= stepCount ? Image.asset(steps[index]["icon"]!,height: Get.height*.04,)
                              : Image.asset(steps[index]["icon"]!,height: Get.height*.04,color: Colors.white,)),
                    ),
                  ),
                  SizedBox(height: Get.height*.001,),
                  Text(
                    steps[index]["text"]!,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: Get.height*.02,),
                ],
              );
            },),
          Positioned(
              right: 90,
              top: 47,
              child: Image.asset("assets/images/icon_dotted_one.png",height: Get.height*.18,color: Colors.white,)) ,
          Positioned(
              left: 90,
              top: Get.height*.22,
              child: Image.asset("assets/images/icon_dotted_left_side.png",height: Get.height*.18,color: Colors.white,)) ,
          Positioned(
              right: 90,
              top: Get.height*.38,
              child: Image.asset("assets/images/icon_dotted_one.png",height: Get.height*.18,color: Colors.white,)) ,
          Positioned(
              left: 90,
              top: Get.height*.55,
              child: Image.asset("assets/images/icon_dotted_left_side.png",height: Get.height*.18,color: Colors.white,)) ,
        ],
      ),
    );
  }
}
