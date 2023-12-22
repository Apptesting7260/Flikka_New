
import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';

class RecruiterHome extends StatefulWidget {
  final RecruiterProfileDetails? recruiterProfileDetails ;
  const RecruiterHome({super.key, this.recruiterProfileDetails});

  @override
  State<RecruiterHome> createState() => _RecruiterHomeState();
}

class _RecruiterHomeState extends State<RecruiterHome> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: const Color(0xff000),
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height*.035,),
              Text("Overview",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700,color: const Color(0xffFFFFFF)),),
              SizedBox(height: Get.height*.01,),
              widget.recruiterProfileDetails?.addBio == null || widget.recruiterProfileDetails?.addBio?.length == 0 ?
              Text("No data") :
              HtmlWidget(widget.recruiterProfileDetails?.addBio ?? "No Data",textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: const Color(0xffCFCFCF)),) ,
              // Text(CommonFunctions.parseHTML(widget.recruiterProfileDetails?.addBio ?? "No Data"),style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: const Color(0xffCFCFCF)),),
               SizedBox(height: Get.height*.03,),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: const Color(0xff353535),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Website",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: const Color(0xffCFCFCF)),),
                      SizedBox(height: Get.height*.002,),
                      GestureDetector(
                        onTap: () {
                          if(widget.recruiterProfileDetails?.websiteLink != null) {
                            launchUrl(Uri.parse(widget.recruiterProfileDetails!.websiteLink!) ,
                              mode: LaunchMode.externalApplication);
                          }
                        },
                        child: Text(widget.recruiterProfileDetails?.websiteLink ?? "No Data", overflow: TextOverflow.clip,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500,color: AppColors.blueThemeColor),),
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height*.05,),
              // Center(child: Text("SEE ALL DETAILS",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: const Color(0xff56B8F6)),)),
              // SizedBox(height: Get.height*.1,),
            ],
          ),
        ),
      ),
    ));
  }
}
