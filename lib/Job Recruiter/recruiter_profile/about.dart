
import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import 'package:flikka/models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class RecruiterAbout extends StatefulWidget {
 final RecruiterProfileDetails? recruiterProfileDetails ;
  const RecruiterAbout({super.key, this.recruiterProfileDetails});

  @override
  State<RecruiterAbout> createState() => _RecruiterAboutState();
}

class _RecruiterAboutState extends State<RecruiterAbout> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: const Color(0xff000),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height*.045,),
              Text("About",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700,color: const Color(0xffFFFFFF)),),
              SizedBox(height: Get.height*.005,),
              HtmlWidget(widget.recruiterProfileDetails?.aboutDescription ?? "No Data",textStyle:Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: const Color(0xffCFCFCF)),),
              // Text(CommonFunctions.parseHTML(widget.recruiterProfileDetails?.aboutDescription ?? "No Data") ?? "No Data",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
              SizedBox(height: Get.height*.03,),
              Text("Website",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffFFFFFF)),),
              SizedBox(height: Get.height*.003,),
              GestureDetector(
                onTap: () {
                  if(widget.recruiterProfileDetails?.websiteLink != null) {
                    launchUrl(Uri.parse(widget.recruiterProfileDetails!.websiteLink!),
                    mode: LaunchMode.externalApplication);
                  }
                },
                  child: Text(widget.recruiterProfileDetails?.websiteLink ?? "No Data",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500,color: AppColors.blueThemeColor),)),
              SizedBox(height: Get.height*.02,),
              Text("Industry",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500,color: Color(0xffFFFFFF)),),
              SizedBox(height: Get.height*.003,),
              Text(widget.recruiterProfileDetails?.industry ?? "No Data",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500,color: Color(0xffCFCFCF)),),
              SizedBox(height: Get.height*.02,),
              Text("Company Size",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500,color: Color(0xffFFFFFF)),),
              SizedBox(height: Get.height*.003,),
              Text( widget.recruiterProfileDetails?.companySize == null ? "No Data" :
                "${widget.recruiterProfileDetails?.companySize} Employees"  ,style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500,color: Color(0xffCFCFCF)),),
              SizedBox(height: Get.height*.02,),
              // Text("Type",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500,color: Color(0xffFFFFFF)),),
              // SizedBox(height: Get.height*.003,),
              //Text("Self Owned",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500,color: Color(0xffCFCFCF)),),
              // SizedBox(height: Get.height*.02,),
              Text("Founded",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500,color: Color(0xffFFFFFF)),),
              SizedBox(height: Get.height*.003,),
              Text(widget.recruiterProfileDetails?.founded ?? "No Data",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500,color: const Color(0xffCFCFCF)),),

              // Text("${widget.recruiterProfileDetails?.founded?.day}-${widget.recruiterProfileDetails?.founded?.month}-${widget.recruiterProfileDetails?.founded?.year}",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500,color: const Color(0xffCFCFCF)),),
              SizedBox(height: Get.height*.02,),
              Text("Specialization",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500,color: const Color(0xffFFFFFF)),),
              SizedBox(height: Get.height*.003,),
              HtmlWidget(widget.recruiterProfileDetails?.specialties ?? "No Data",textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500,color: const Color(0xffCFCFCF)),),
              // Text(CommonFunctions.parseHTML(widget.recruiterProfileDetails?.specialties ?? "No Data") ?? "No Data",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500,color: const Color(0xffCFCFCF)),),

              SizedBox(height: Get.height*.1,),

            ],
          ),
        ),
      ),
    ));
  }
}
