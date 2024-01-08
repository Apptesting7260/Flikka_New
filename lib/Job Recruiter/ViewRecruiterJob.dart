import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:video_compress/video_compress.dart';
import '../controllers/ApplyJobController/ApplyJobController.dart';
import '../controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import '../models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import '../utils/CommonFunctions.dart';
import '../utils/VideoPlayerScreen.dart';
import '../widgets/app_colors.dart';

class ViewRecruiterJob extends StatefulWidget {
  final RecruiterJobsData? recruiterJobsData ;
  final String? company ; final bool? isSeeker ;
  const ViewRecruiterJob({super.key, required this.recruiterJobsData, this.company, this.isSeeker});

  @override
  State<ViewRecruiterJob> createState() => _ViewRecruiterJobState();
}

class _ViewRecruiterJobState extends State<ViewRecruiterJob> {

  TextEditingController commentController = TextEditingController();
  ApplyJobController applyJobController = Get.put(ApplyJobController()) ;

  // //////refresh//////
  // RefreshController _refreshController = RefreshController(initialRefresh: false);
  //
  // void _onRefresh() async{
  //   await RecruiterJobsData.getJobsApi();
  //   _refreshController.refreshCompleted();
  // }
  //
  // void _onLoading() async{
  //   await jobsController.getJobsApi();
  //   if(mounted)
  //     setState(() {
  //
  //     });
  //   _refreshController.loadComplete();
  // }
  // /////refresh/////

  var years ;
  var months ;

  @override
  Widget build(BuildContext context) {
    if( widget.recruiterJobsData?.workExperience != null &&  widget.recruiterJobsData?.workExperience.toString().length != 0) {
      var experience = widget.recruiterJobsData?.workExperience.toString().split(".");
      if(experience?.length == 2) {
        if( experience?[0] != null && experience?[0].length != 0 && experience?[0].toString() != "0") {
          years = "${experience?[0]} year";
        }
        if( experience?[1] != null && experience?[1].length != 0 && experience?[1].toString() != "00") {
          months = "${experience?[1]} month";
        }
      }
    }

    print(widget.recruiterJobsData?.description) ;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 75,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: GestureDetector(
                  onTap: () { Get.back(); },
                  child: Image.asset('assets/images/icon_back_blue.png')),
            ),
            elevation: 0,
            title: Text(widget.company ?? "No company",overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width*.024,vertical: Get.height *.01),
            child: Stack(
              children: [
                //*************** for swiper image **************
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28)
                  ),
                  width: Get.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: '${widget.recruiterJobsData?.featureImg}',
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator()),
                      fit: BoxFit.cover,
                      height: Get.height *0.45,
                    ),
                  ),
                ),
                //*************** for marketing intern **************

                  Column(
                    children: [
                      SizedBox(height: Get.height * .30,),
                      Row(
                        children: [
                          SizedBox(width: Get.width*.04,) ,
                          // widget.recruiterJobsData!.video == null ||
                          //     widget.recruiterJobsData!.video?.length == 0 ?
                          //     const SizedBox() :
                          // GestureDetector(
                          //   onTap: () {
                          //     Get.back() ;
                          //     Get.to(() => VideoPlayerScreen(videoPath: widget.recruiterJobsData?.video ?? "")) ;
                          //   },
                          //   child: Container(
                          //     alignment: Alignment.center,
                          //     height: 42,
                          //     width: 42,
                          //     decoration: const BoxDecoration(
                          //         shape: BoxShape.circle,
                          //         color: AppColors.blueThemeColor
                          //     ),
                          //     child: Image.asset(
                          //       "assets/images/icon_video.png",
                          //       height: 18,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                DraggableScrollableSheet(
                  initialChildSize: 0.55, // half screen
                  minChildSize: 0.55, // half screen
                  maxChildSize: 1, // full screen
                  builder: (BuildContext context, ScrollController scrollController) {
                    return  ListView(
                      controller: scrollController,
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                color: AppColors.blackdown,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                            ),

                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width*.03,vertical: Get.height*.05),
                              child: Column(
                                children: [
                                  //********************* for jessica  ***************************
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.blackdown,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(22),topRight: Radius.circular(22)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: Get.width*.65,
                                              child: Text( widget.recruiterJobsData?.jobTitle ?? "No job title",overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge,
                                                softWrap: true,
                                              ),
                                            ),

                                            GestureDetector(
                                              onTap: () {
                                                if(  widget.recruiterJobsData!.video == null ||
                                                    widget.recruiterJobsData!.video?.length == 0 ) {
                                                  Utils.showMessageDialog(context, " video not uploaded yet") ;
                                                }
                                               else {
                                                  Get.back() ;
                                                  Get.to(() => VideoPlayerScreen(videoPath: widget.recruiterJobsData?.video ?? "")) ;
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 42,
                                                width: 42,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.blueThemeColor
                                                ),
                                                child: Image.asset(
                                                  "assets/images/icon_video.png",
                                                  height: 18,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        Text( widget.recruiterJobsData?.jobPositions ?? "No position",overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                              color: const Color(0xffCFCFCF)),
                                          softWrap: true,
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                        Text( widget.company ?? "No company",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                              color: const Color(0xffCFCFCF)),
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                        Text( widget.recruiterJobsData?.jobLocation ?? "No job location",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                              color: const Color(0xffCFCFCF)),
                                        ),
                                        SizedBox(height: Get.height * 0.04,),
                                        Text("Job Description",
                                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.white),),
                                        SizedBox(height: Get.height * 0.010,),
                                        HtmlWidget(widget.recruiterJobsData?.description ?? "No job description",
                                        textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                color:  const Color(0xffCFCFCF),fontWeight: FontWeight.w400),) ,
                                        SizedBox(height: Get.height * 0.03,),
                                        Text(
                                          "Requirements",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height * 0.015,),
                                        HtmlWidget(widget.recruiterJobsData?.requirements ?? "No requirements",textStyle: Theme.of(context).textTheme
                                            .bodySmall!.copyWith(color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),) ,
                                        SizedBox(height: Get.height * 0.03,),
                                        Text(
                                          "Job type",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                        Text( widget.recruiterJobsData?.employmentType ?? "No job type",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: Get.height * 0.03,),
                                        Text(
                                          "Specialization",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                        Text( widget.recruiterJobsData?.specialization ?? "No specialization",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: Get.height * 0.03,),
                                        Text(
                                          "Type of workplace",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                        Text( widget.recruiterJobsData?.typeOfWorkplace ?? "No type of workplace",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: Get.height * 0.03,),
                                        Text(
                                          "Work experience",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                       years != null || months != null ?
                                       Text( "${years ?? ""} ${months ?? ""}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ): Text("No work experience", style: Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),),
                                        SizedBox(height: Get.height * 0.03,),
                                        Text(
                                          "Preferred work experience",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                        Text( widget.recruiterJobsData?.preferredWorkExperience ?? "No preferred work experience",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: Get.height * 0.03,),
                                        Text(
                                          "Qualification",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                       widget.recruiterJobsData?.education.toString().toLowerCase() == "null" || widget.recruiterJobsData?.education.toString().length == 0 ?
                               Text("No qualification", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                       Text(widget.recruiterJobsData?.education ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(height: Get.height * 0.03,),
                                        Text("Language",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height * 0.010,),
                                        widget.recruiterJobsData?.language == null || widget.recruiterJobsData?.language?.length == 0 ?
                                        Text("No language", style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),) :
                                        ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: widget.recruiterJobsData?.language?.length,
                                          itemBuilder: (context , index) {
                                            return Text(  widget.recruiterJobsData?.language?[index].languages ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                  color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                                            );
                                          }
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          "Soft Skills",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height*0.01,),
                                        /////
                                        widget.recruiterJobsData?.jobsDetail?.skillName == null ||
                                            widget.recruiterJobsData?.jobsDetail?.skillName?.length == 0 ?
                                        Text("No skills", style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),) :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount: widget.recruiterJobsData?.jobsDetail?.skillName?.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Color(0xff484848),
                                                ),
                                                child: Text(widget.recruiterJobsData?.jobsDetail?.skillName?[index].skills ?? "",
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: Get.theme.textTheme
                                                      .bodySmall!.copyWith(
                                                      color: AppColors.white,
                                                      fontWeight: FontWeight
                                                          .w400,fontSize: 9),),
                                              );
                                            }),
                                        ///
                                        SizedBox(height: Get.height*0.04,),
                                        Text(
                                          "Passion",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height*0.01,),
                                        widget.recruiterJobsData?.jobsDetail?.passionName == null ||
                                            widget.recruiterJobsData?.jobsDetail?.passionName?.length == 0 ?
                                        Text("No skills", style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),) :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount: widget.recruiterJobsData?.jobsDetail?.passionName?.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              //var data = seekerProfileController.viewSeekerData.value.seekerDetails?.skillName?[index];
                                              return Container(
                                                padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                  color: const Color(0xff484848),
                                                ),
                                                // padding: const EdgeInsets.all(
                                                //     8),
                                                child: Text( widget.recruiterJobsData?.jobsDetail?.passionName?[index].passion  ?? '',
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: Get.theme.textTheme
                                                      .bodySmall!.copyWith(
                                                      color: AppColors.white,
                                                      fontWeight: FontWeight
                                                          .w400,fontSize: 9),),
                                              );
                                            }),
                                        SizedBox(
                                          height: Get.height * 0.04,
                                        ),
                                        Text(
                                          "industry preference",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height*0.01,),
                                        widget.recruiterJobsData?.jobsDetail?.industryPreferenceName == null ||
                                            widget.recruiterJobsData?.jobsDetail?.industryPreferenceName?.length == 0 ?
                                        Text("No skills", style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),) :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount: widget.recruiterJobsData?.jobsDetail?.industryPreferenceName?.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              //var data = seekerProfileController.viewSeekerData.value.seekerDetails?.skillName?[index];
                                              return Container(
                                                padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                  color: Color(0xff484848),
                                                ),
                                                // padding: const EdgeInsets.all(
                                                //     8),
                                                child: Text(widget.recruiterJobsData?.jobsDetail?.industryPreferenceName?[index].industryPreferences ?? "",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Get.theme.textTheme.bodySmall!.copyWith(
                                                      color: AppColors.white,
                                                      fontWeight: FontWeight.w400,fontSize: 9),),
                                              );
                                            }),
                                        SizedBox(height: Get.height * 0.04,),
                                        Text("Strengths",
                                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height*0.01,),
                                        widget.recruiterJobsData?.jobsDetail?.strengthsName == null ||
                                            widget.recruiterJobsData?.jobsDetail?.strengthsName?.length == 0 ?
                                        Text("No skills", style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),) :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount: widget.recruiterJobsData?.jobsDetail?.strengthsName?.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                  color: const Color(0xff484848),
                                                ),
                                                // padding: const EdgeInsets.all(
                                                //     8),
                                                child: Text( widget.recruiterJobsData?.jobsDetail?.strengthsName?[index].strengths ?? '',
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: Get.theme.textTheme
                                                      .bodySmall!.copyWith(
                                                      color: AppColors.white,
                                                      fontWeight: FontWeight
                                                          .w400,fontSize: 9),),
                                              );
                                            }),
                                        SizedBox(height: Get.height * 0.04,),
                                        Text(
                                          "Salary expectation",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height*0.01,),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius
                                                .circular(20),
                                            color: const Color(0xff484848),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal : 20 ,vertical: 12),
                                          child: Text('${widget.recruiterJobsData?.jobsDetail?.minSalaryExpectation ?? ''} - ${widget.recruiterJobsData?.jobsDetail?.maxSalaryExpectation ?? 'No salary expectation'}',
                                            overflow: TextOverflow.ellipsis,
                                            style: Get.theme.textTheme.bodySmall!.copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w400),),
                                        ),
                                        SizedBox(height: Get.height * 0.04,),
                                        Text(
                                          "When can i start working?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height*0.01,),
                                        widget.recruiterJobsData?.jobsDetail?.startWorkName == null ||
                                            widget.recruiterJobsData?.jobsDetail?.startWorkName?.length == 0 ?
                                        Text("No skills", style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),) :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount: widget.recruiterJobsData?.jobsDetail?.startWorkName?.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                  color: Color(0xff484848),
                                                ),
                                                // padding: const EdgeInsets.all(
                                                //     8),
                                                child: Text( widget.recruiterJobsData?.jobsDetail?.startWorkName?[index].startWork ?? '',
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: Get.theme.textTheme
                                                      .bodySmall!.copyWith(
                                                      color: AppColors.white,
                                                      fontWeight: FontWeight
                                                          .w400,fontSize: 9),),
                                              );
                                            }),

                                        SizedBox(height: Get.height * 0.04,),
                                        Text(
                                          "Availability",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        SizedBox(height: Get.height*0.01,),
                                        widget.recruiterJobsData?.jobsDetail?.availabityName == null ||
                                            widget.recruiterJobsData?.jobsDetail?.availabityName?.length == 0 ?
                                        Text("No skills", style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            color:const Color(0xffCFCFCF),fontWeight: FontWeight.w400),) :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount:  widget.recruiterJobsData?.jobsDetail?.availabityName?.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                  color: const Color(0xff484848),
                                                ),
                                                // padding: const EdgeInsets.all(
                                                //     8),
                                                child: Text(  widget.recruiterJobsData?.jobsDetail?.availabityName?[index].availabity ?? '',
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: Get.theme.textTheme
                                                      .bodySmall!.copyWith(
                                                      color: AppColors.white,
                                                      fontWeight: FontWeight
                                                          .w400,fontSize: 9),),
                                              );
                                            }),
                                        SizedBox(height: Get.height*0.02,),
                                  widget.recruiterJobsData?.isApplied == true ? const SizedBox() :   widget.isSeeker == true ?  Center(
                                       child: Obx( () => MyButton(title: "Apply",
                                                loading: applyJobController.loading.value,
                                                onTap1: () async {
                                             var result = await applyJobController.applyJob(context,widget.recruiterJobsData?.id.toString()) ;
                                             if(result) {
                                               widget.recruiterJobsData?.isApplied = true ;
                                               setState(() {

                                               });
                                             }
                                            }),
                                          ),
                                     ) : const SizedBox(),
                                        SizedBox(height: widget.isSeeker == true ? Get.height*0.02 : Get.height*0.0,),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            )
                        ),

                      ],
                    );

                  },
                ),

              ],
            ),
          )
      ),
    );
  }
}
