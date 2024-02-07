import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/controllers/ApplyJobController/ApplyJobController.dart';
import 'package:flikka/controllers/SeekerUpdateRequestedJobStatus/SeekerUpdateRequestedJobStatus.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/widgets/google_map_widget.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import '../controllers/GetJobsListingController/GetJobsListingController.dart';
import '../controllers/SeekerAppliedJobsController/SeekerAppliedJobsController.dart';
import '../utils/VideoPlayerScreen.dart';
import 'SeekerJobs/AppliedJobs.dart';
import 'SeekerJobs/progress_tracker.dart';

class MarketingIntern extends StatefulWidget {
   final dynamic jobData ;
   final bool appliedJobScreen ;
   final bool? requestedJob ;
  const MarketingIntern({super.key, this.jobData, required this.appliedJobScreen, this.requestedJob});

  @override
  State<MarketingIntern> createState() => _MarketingInternState();
}

class _MarketingInternState extends State<MarketingIntern> {

  SeekerAppliedJobsController jobsController = Get.put(SeekerAppliedJobsController()) ;
  ApplyJobController applyJobController = Get.put(ApplyJobController()) ;
  SeekerUpdateRequestedJobStatusController jobStatusController = Get.put(SeekerUpdateRequestedJobStatusController()) ;
  GetJobsListingController getJobsListingController = GetJobsListingController() ;
  var years = '';
  var months = '';
  @override
  Widget build(BuildContext context) {
    if( widget.jobData?.workExperience != null &&  widget.jobData?.workExperience.toString().length != 0) {
      var experience = widget.jobData?.workExperience.toString().split(".");
      if(experience?.length == 2) {
       if( experience?[0] != null && experience?[0].length != 0 && experience?[0].toString() != "0") {
          years = "${experience?[0]} year";
        }
       if( experience?[1] != null && experience?[1].length != 0 && experience?[1].toString() != "00") {
          months = "${experience?[1]} month";
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset('assets/images/icon_back_blue.png',scale: 4,)),
          elevation: 0,
          title: Text("${widget.jobData?.jobTitle ?? ""}",overflow: TextOverflow.ellipsis,style: Get.theme.textTheme.displayLarge),

        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xff353535),
                borderRadius: BorderRadius.circular(25)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 12),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          radius: 45,
                          // backgroundImage: NetworkImage('${widget.jobData?.featureImg}'),
                          child: CachedNetworkImage(
                            imageUrl: '${widget.jobData?.featureImg}',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                )
                              ),
                            ),
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          // Container(
                          //   alignment: Alignment.center,
                          //   height: 42,
                          //   width: 42,
                          //   decoration: const BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       color: AppColors.blueThemeColor
                          //   ),
                          // ),
                          // GestureDetector(
                          //   onTap: () {
                          //     Get.to(() => const ProgressTracker()) ;
                          //   },
                          //     child: Image.asset("assets/images/icon_progress_tracker.png",height: 45,)) ,
                          SizedBox(width: Get.width*.04,) ,
                          GestureDetector(
                            onTap: () {
                              if(  widget.jobData?.video == null ||
                                  widget.jobData?.video?.length == 0 ) {
                                Utils.showMessageDialog(context, "video not uploaded yet") ;
                              }
                              else {
                                Get.back() ;
                                Get.to(() => VideoPlayerScreen(videoPath: widget.jobData?.video ?? "")) ;
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
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  Text(
                    "${widget.jobData?.jobTitle ?? "No job title"}", overflow: TextOverflow.ellipsis,
                    style:  Get.theme.textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: Get.height * 0.004,
                  ),

                  Text(
                    "${widget.jobData?.jobPositions ?? "No job position"}",overflow: TextOverflow.ellipsis,
                    style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),
                  ),
                  SizedBox(
                    height: Get.height * 0.004,
                  ),
                  Text(
                    "${widget.jobData?.recruiterDetails?.companyName ?? "No company name"}", overflow: TextOverflow.ellipsis,
                    style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),
                  ),

                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Text(
                    "Job Description",
                    style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  widget.jobData?.description == null || CommonFunctions.parseHTML(widget.jobData?.description).toString().trim().length == 0 ?
                  Text("No job description",style: Theme.of(context).textTheme.labelLarge!
                      .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),) :
                  HtmlWidget(widget.jobData?.description ?? 'No job description',textStyle:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)) ,),
                  SizedBox(height: Get.height * 0.03,),
                  Text("Requirements", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                  SizedBox(height: Get.height * 0.015,),
                  widget.jobData?.requirements == null || CommonFunctions.parseHTML(widget.jobData?.requirements).toString().trim().length == 0 ?
                  Text("No requirements",style: Theme.of(context).textTheme.labelLarge!
                      .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),) :
                  HtmlWidget(widget.jobData?.requirements ?? 'No requirements',textStyle: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height * 0.025,),
                  Text("Locations", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                  SizedBox(height: Get.height * 0.015,),
                  Text(widget.jobData?.jobLocation ?? "No job location",overflow: TextOverflow.ellipsis, style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height * 0.015,),
                  InkWell(
                      onTap: () {
                        print("object") ;
                        Get.to( GoogleMapIntegration(jobPageView: true,lat: double.tryParse("${widget.jobData?.lat}"),long:  double.tryParse("${widget.jobData?.long}")));},
                      child: SizedBox( height: Get.height * 0.3,
                          child: GoogleMapIntegration(jobPageView: true,lat: double.tryParse("${widget.jobData?.lat}"),long:  double.tryParse("${widget.jobData?.long}"),))),
                  SizedBox(height: Get.height * 0.035,),
                  Text("Information", style:Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                  SizedBox(height: Get.height * 0.015,),
                  Text("Position", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  Text(
                    widget.jobData?.jobPositions ?? "No position",
                    style: Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),

                  const Text(
                    "Qualification",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  widget.jobData?.education.toString().toLowerCase() == "null" ||
                      widget.jobData?.education.toString().length == 0
                      ? Text("No qualification", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                  Text(
                    widget.jobData?.education ?? "",
                    style: Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),

                  const Text(
                    "Experience",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                 years.toString().length == 0 && months.toString().length == 0 ?  const Text("No experience") : Text("${years ?? ""} ${ months ?? ""}",
                    style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  const Text("Job Type", style: TextStyle(color: Colors.white, fontSize: 14),),
                  SizedBox(height: Get.height * 0.015,),
                  Text(widget.jobData?.employmentType ?? "No job type",
                    style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                  const Divider(color: Colors.grey, thickness: 0.2,),
                  const Text("Specialization", style: TextStyle(color: Colors.white, fontSize: 14),),
                  SizedBox(height: Get.height * 0.015,),
                  Text(widget.jobData?.specialization ?? "No specialization",
                    style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                  const Divider(color: Colors.grey, thickness: 0.2,),
                  const Text("Type of workplace",
                    style: TextStyle(color: Colors.white, fontSize: 14),),
                  SizedBox(height: Get.height * 0.015,),
                  Text(widget.jobData?.typeOfWorkplace ?? "No workplace",
                    style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                  const Divider(color: Colors.grey, thickness: 0.2,),
                  const Text(
                    "Preferred work experience",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  Text(
                    widget.jobData?.preferredWorkExperience ?? "No preferred work experience",
                    style:Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  const Text(
                    "Language",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  widget.jobData?.languageName == null || widget.jobData?.languageName?.length == 0 ?
                       Text("No language", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.jobData?.languageName?.length,
                    itemBuilder: (context , index) {
                      var data = widget.jobData?.languageName?[index] ;
                      return Text(data?.languages ?? "",
                        style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),
                      );
                    }
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.2,
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
                  widget.jobData?.jobsDetail?.skillName == null ||
                      widget.jobData?.jobsDetail?.skillName?.length == 0 ?
                   Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),) :
                  GridView.builder(gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 39,
                      maxCrossAxisExtent: Get.width * 0.35,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6),
                      itemCount:widget.jobData?.jobsDetail?.skillName?.length,
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
                          child: Text(widget.jobData?.jobsDetail?.skillName?[index].skills ?? "",
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
                  widget.jobData?.jobsDetail?.passionName == null ||
                      widget.jobData?.jobsDetail?.passionName?.length == 0 ?
                    Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                  GridView.builder(gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 39,
                      maxCrossAxisExtent: Get.width * 0.35,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6),
                      itemCount: widget.jobData?.jobsDetail?.passionName?.length,
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
                          child: Text( widget.jobData?.jobsDetail?.passionName?[index].passion  ?? '',
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
                  widget.jobData?.jobsDetail?.industryPreferenceName == null ||
                      widget.jobData?.jobsDetail?.industryPreferenceName?.length == 0 ?
                    Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                  GridView.builder(gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 39,
                      maxCrossAxisExtent: Get.width * 0.35,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6),
                      itemCount: widget.jobData?.jobsDetail?.industryPreferenceName?.length,
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
                          child: Text(widget.jobData?.jobsDetail?.industryPreferenceName?[index].industryPreferences ?? "",
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
                  widget.jobData?.jobsDetail?.strengthsName == null ||
                      widget.jobData?.jobsDetail?.strengthsName?.length == 0 ?
                  Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                  GridView.builder(gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 39,
                      maxCrossAxisExtent: Get.width * 0.35,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6),
                      itemCount: widget.jobData?.jobsDetail?.strengthsName?.length,
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
                          child: Text( widget.jobData?.jobsDetail?.strengthsName?[index].strengths ?? '',
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
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20),
                  //     color: const Color(0xff484848),
                  //   ),
                  //   padding: const EdgeInsets.symmetric(horizontal : 20 ,vertical: 12),
                  //   child: Text('${widget.jobData?.jobsDetail?.minSalaryExpectation ?? ''}  ${widget.jobData?.jobsDetail?.maxSalaryExpectation ?? 'No salary expectation'}',
                  //     style: Get.theme.textTheme.bodySmall!.copyWith(
                  //         color: AppColors.white,
                  //         fontWeight: FontWeight.w400),),
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff484848),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Text(
                      '${widget.jobData?.jobsDetail?.minSalaryExpectation ?? ''}  ${widget.jobData?.jobsDetail?.maxSalaryExpectation ?? 'No salary expectation'} ',
                      style: Get.theme.textTheme.bodySmall!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
                  widget.jobData?.jobsDetail?.startWorkName == null ||
                      widget.jobData?.jobsDetail?.startWorkName?.length == 0 ?
                  Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                  GridView.builder(gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 39,
                      maxCrossAxisExtent: Get.width * 0.35,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6),
                      itemCount: widget.jobData?.jobsDetail?.startWorkName?.length,
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
                          child: Text( widget.jobData?.jobsDetail?.startWorkName?[index].startWork ?? '',
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
                  widget.jobData?.jobsDetail?.availabityName == null ||
                      widget.jobData?.jobsDetail?.availabityName?.length == 0 ?
                  Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                  GridView.builder(gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 39,
                      maxCrossAxisExtent: Get.width * 0.35,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6),
                      itemCount:  widget.jobData?.jobsDetail?.availabityName?.length,
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
                          child: Text(  widget.jobData?.jobsDetail?.availabityName?[index].availabity ?? '',
                            overflow: TextOverflow
                                .ellipsis,
                            style: Get.theme.textTheme
                                .bodySmall!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight
                                    .w400,fontSize: 9),),
                        );
                      }),
                  SizedBox(height: Get.height * 0.055,),
                  widget.appliedJobScreen ? const SizedBox() :
                      widget.requestedJob == true ?
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyButton(title:   "ACCEPT",
                              width: Get.width *.4,
                              onTap1: () {
                                  CommonFunctions.showLoadingDialog(context, "Updating...") ;
                                 jobStatusController.updateStatus("${widget.jobData?.id}", "Accept",context) ;
                              }),
                          MyButton(title: "REJECT",
                              width: Get.width *.4,
                              onTap1: () {
                                CommonFunctions.showLoadingDialog(context, "Updating...") ;
                                jobStatusController.updateStatus("${widget.jobData?.id}", "Reject",context) ;
                              }),
                        ],)
                 :
                      MyButton(
                      title: widget.jobData?.postApplied == true ? "APPLIED" : "APPLY NOW",
                      onTap1: () async {
                        if(widget.jobData?.postApplied == true ){}else{
                          applyJobController.errorMessageApplyReferral.value = "" ;
                          showReferralSubmissionDialog(context) ;
                          // if(!applyJobController.loading.value) {
                          //   var result = await applyJobController.applyJob("${widget.jobData?.id}") ;
                          //   if(result == true) {
                          //     widget.jobData?.postApplied = true ;
                          //     setState(() {});
                          //   }
                          // }
                        }

                    }
                  ),
                  SizedBox(height: Get.height*.025,),
                  //  Column(
                  //    mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       padding:  const EdgeInsets.all(5),
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         border: Border.all(color: Colors.white,width: 2)
                  //       ),
                  //       child: Container(
                  //         height: 70,
                  //         width: 70,
                  //         decoration: const BoxDecoration(
                  //           shape: BoxShape.circle,
                  //               color: Colors.white
                  //         ),
                  //         child: IconButton(
                  //             onPressed: () {
                  //
                  //             }, icon: Image.asset("assets/images/icon_applied_step.png",height: Get.height*.04,)),
                  //       ),
                  //     ),
                  //     const SizedBox(height: 15,),
                  //     Text("APPLIED",style: Theme.of(context).textTheme.titleSmall,),
                  //     const SizedBox(height: 25,),
                  //     Container(
                  //       padding: const EdgeInsets.all(5),
                  //       decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           border: Border.all(color: Colors.white,width: 2)
                  //       ),
                  //       child: Container(
                  //         height: 70,
                  //         width: 70,
                  //         decoration: const BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: Colors.white
                  //         ),
                  //         child: IconButton(
                  //             onPressed: () {
                  //
                  //             }, icon: Image.asset("assets/images/icon_assessed_step.png",height: Get.height*.04,)),
                  //       ),
                  //     ),
                  //     const SizedBox(height: 15,),
                  //     Text("ASSESSED",style: Theme.of(context).textTheme.titleSmall,),
                  //     const SizedBox(height: 25,),
                  //     Container(
                  //       padding: const EdgeInsets.all(5),
                  //       decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           border: Border.all(color: Colors.white,width: 2)
                  //       ),
                  //       child: Container(
                  //         height: 70,
                  //         width: 70,
                  //         decoration: const BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: Colors.white
                  //         ),
                  //         child: IconButton(
                  //             onPressed: () {
                  //
                  //             }, icon: Image.asset("assets/images/icon_interview_step.png",height: Get.height*.04,)),
                  //       ),
                  //     ),
                  //     const SizedBox(height: 15,),
                  //     Text("INTERVIEW",style: Theme.of(context).textTheme.titleSmall,),
                  //     const SizedBox(height: 25,),
                  //     Container(
                  //       padding: const EdgeInsets.all(5),
                  //       decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           border: Border.all(color: Colors.white,width: 2)
                  //       ),
                  //       child: Container(
                  //         height: 70,
                  //         width: 70,
                  //         decoration: const BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: Colors.white
                  //         ),
                  //         child: IconButton(
                  //             onPressed: () {
                  //
                  //             }, icon: Image.asset("assets/images/icon_present_Step.png",height: Get.height*.04,)),
                  //       ),
                  //     ),
                  //     const SizedBox(height: 15,),
                  //     Text("PRESENT",style: Theme.of(context).textTheme.titleSmall,),
                  //     const SizedBox(height: 25,),
                  //     Container(
                  //       padding: const EdgeInsets.all(5),
                  //       decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           border: Border.all(color: Colors.white,width: 2)
                  //       ),
                  //       child: Container(
                  //         height: 70,
                  //         width: 70,
                  //         decoration: const BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: Colors.white
                  //         ),
                  //         child: IconButton(
                  //             onPressed: () {
                  //
                  //             }, icon: Image.asset("assets/images/icon_offer_step.png",height: Get.height*.04,)),
                  //       ),
                  //     ),
                  //     const SizedBox(height: 15,),
                  //     Image.asset("assets/images/icon_step_person.png",height: Get.height*.1,) ,
                  //     const SizedBox(height: 10,),
                  //     Text("OFFER",style: Theme.of(context).textTheme.titleSmall,),
                  //     const SizedBox(height: 25,),
                  //   ],
                  // ),
                  // SizedBox(height: Get.height*.025,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showReferralSubmissionDialog(BuildContext context) {
    var controller = TextEditingController() ;
    var _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog( backgroundColor: Colors.transparent,
          // const Color(0xff353535),
          contentPadding: EdgeInsets.zero,
          //********** you can't define any value because this is auto value padding added *********
          //insetPadding: EdgeInsets.all(20),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.blueThemeColor,
                              borderRadius: BorderRadius.circular(12),),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),),
                        ],
                      ),
                    )],),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Color.fromRGBO(52, 52, 52, 1), borderRadius: BorderRadius.circular(12),),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'If you have any referral code please enter',
                        style: Get.theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      TextFormField(
                        controller: controller,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide.none
                            ),
                            filled: true,
                            fillColor: const Color(0xff454545),
                            hintText: "Enter Referral Code",
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                              borderSide: BorderSide(color: Color(0xff353535)),
                            ),
                            enabledBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: const BorderSide(color: Color(0xff353535)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                              borderSide: BorderSide(color: Color(0xff353535)),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                              borderSide: BorderSide(color: Color(0xff353535)),
                            ),
                            hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xffCFCFCF)),
                            contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027)
                        ),
                      ),
                      Obx(() =>  applyJobController.errorMessageApplyReferral.value.isEmpty ?
                      const SizedBox() :
                      Center(child: Text(applyJobController.errorMessageApplyReferral.value,
                          style: const TextStyle(color: Colors.red,fontSize: 12)),),),
                      SizedBox(height: Get.height * 0.04),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: Get.height * 0.06,
                                child:
                                  MyButton(
                                    onTap1: () async {
                                      applyJobController.errorMessageApplyReferral.value = "" ;
                                      if(controller.text.isNotEmpty) {
                                    // CommonFunctions.showLoadingDialog(context, "Applying...") ;
                                    if(!applyJobController.loading.value) {
                                      var result = await applyJobController.applyJob(context,"${widget.jobData?.id}",referralCode:controller.text ) ;
                                      if(result == true) {
                                        Get.back() ;
                                        widget.jobData?.postApplied = true ;
                                        setState(() {

                                        });
                                      }else {
                                        Get.back() ;
                                      }
                                    }
                                  }else{
                                        applyJobController.errorMessageApplyReferral.value = "Please enter referral code" ;
                                      }
                                  }, title: 'SUBMIT', style: Get.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),),
                                ),
                              ),

                            const SizedBox(width: 20), // Adding spacing between buttons
                            Expanded(
                              child: SizedBox(
                                height: Get.height * 0.06,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    CommonFunctions.showLoadingDialog(context, "Applying...") ;
                                    if(!applyJobController.loading.value) {
                                      var result = await applyJobController.applyJob(context,"${widget.jobData?.id}") ;
                                      if(result == true) {
                                        widget.jobData?.postApplied = true ;
                                        Get.back() ;
                                        setState(() {});
                                      }else {
                                        Get.back() ;
                                      }
                                    }
                                  },
                                  child: Text(
                                    'NO',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, color: AppColors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),

                    ],
                  ),
                ),

              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }
}
