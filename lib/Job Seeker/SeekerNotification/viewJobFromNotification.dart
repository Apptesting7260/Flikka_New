import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/controllers/ApplyJobController/ApplyJobController.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/widgets/google_map_widget.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import '../../controllers/ViewJobFromNotificationController/ViewJobFromNotificationController.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../utils/VideoPlayerScreen.dart';

class ViewNotificationJob extends StatefulWidget {
final String? companyName ;
final String jobId ; final String seekerId ;
  const ViewNotificationJob({super.key, this.companyName, required this.jobId, required this.seekerId,});

  @override
  State<ViewNotificationJob> createState() => _ViewNotificationJobState();
}

class _ViewNotificationJobState extends State<ViewNotificationJob> {

  ApplyJobController applyJobController = Get.put(ApplyJobController()) ;
  ViewJobFromNotificationController jobController = ViewJobFromNotificationController() ;
  var years = '';
  var months = '';

  @override
  void initState() {
    super.initState();
    jobController.viewJobFromNotificationData(context, widget.jobId, widget.seekerId);
  }

  @override
  Widget build(BuildContext context) {
    if( jobController.jobData.value.job?.workExperience != null &&  jobController.jobData.value.job?.workExperience.toString().length != 0) {
      var experience = jobController.jobData.value.job?.workExperience.toString().split(".");
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
          title: Text("${widget.companyName ?? " No company name"}",overflow: TextOverflow.ellipsis,style: Get.theme.textTheme.displayLarge),

        ),
        body: Obx(() {
          switch (jobController.rxRequestStatus.value) {
            case Status.LOADING:
              return const
              Scaffold(body: Center(child: CircularProgressIndicator()),);

            case Status.ERROR:
              if (jobController.error.value == 'No internet') {
                return InterNetExceptionWidget(
                  onPress: () {
                    jobController.viewJobFromNotificationData(context, widget.jobId, widget.seekerId);
                  },
                );
              } else {
                return GeneralExceptionWidget(onPress: () {
                  jobController.viewJobFromNotificationData(context, widget.jobId, widget.seekerId);
                });
              }
            case Status.COMPLETED:
              return
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 15),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xff353535),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 12),
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
                                    imageUrl: jobController.jobData.value.job?.featureImg ?? "",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          height: 90,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              )
                                          ),
                                        ),
                                    placeholder: (context, url) =>
                                    const Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                ),
                              ),

                              Row(
                                children: [
                                  SizedBox(width: Get.width * .04,),

                                  GestureDetector(
                                    onTap: () {
                                      if (jobController.jobData.value.job
                                          ?.shortVideo == null ||
                                          jobController.jobData.value.job
                                              ?.shortVideo?.length == 0) {
                                        Utils.showMessageDialog(
                                            context, "video not uploaded yet");
                                      }
                                      else {
                                        Get.back();
                                        Get.to(() => VideoPlayerScreen(
                                            videoPath: jobController.jobData
                                                .value.job?.shortVideo ?? ""));
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
                            "${jobController.jobData.value.job?.jobTitle ??
                                "No job title"}",
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.displayLarge,
                          ),
                          SizedBox(
                            height: Get.height * 0.004,
                          ),

                          Text(
                            "${jobController.jobData.value.job?.jobPositions ??
                                "No job position"}",
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: const Color(0xffCFCFCF)),
                          ),
                          SizedBox(
                            height: Get.height * 0.004,
                          ),
                          Text(
                            widget.companyName ?? "No company name",
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: const Color(0xffCFCFCF)),
                          ),

                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Text(
                            "Job Description",
                            style: Get.theme.textTheme.titleSmall!.copyWith(
                                color: AppColors.white),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          jobController.jobData.value.job?.description ==
                              null || CommonFunctions
                              .parseHTML(
                              jobController.jobData.value.job?.description)
                              .toString()
                              .trim()
                              .length == 0 ?
                          Text("No job description", style: Theme
                              .of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: AppColors.ratingcommenttextcolor,
                              fontWeight: FontWeight.w400),) :
                          HtmlWidget(jobController.jobData.value.job
                              ?.description ?? 'No job description',
                            textStyle: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: const Color(0xffCFCFCF)),),
                          SizedBox(height: Get.height * 0.03,),
                          Text("Requirements", style: Get.theme.textTheme
                              .titleSmall!.copyWith(color: AppColors.white),),
                          SizedBox(height: Get.height * 0.015,),
                          jobController.jobData.value.job?.requirements ==
                              null || CommonFunctions
                              .parseHTML(
                              jobController.jobData.value.job?.requirements)
                              .toString()
                              .trim()
                              .length == 0 ?
                          Text("No requirements", style: Theme
                              .of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: AppColors.ratingcommenttextcolor,
                              fontWeight: FontWeight.w400),) :
                          HtmlWidget(jobController.jobData.value.job
                              ?.requirements ?? 'No requirements',
                            textStyle: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: const Color(0xffCFCFCF)),),
                          SizedBox(height: Get.height * 0.025,),
                          Text("Locations", style: Get.theme.textTheme
                              .titleSmall!.copyWith(color: AppColors.white),),
                          SizedBox(height: Get.height * 0.015,),
                          Text(jobController.jobData.value.job?.jobLocation ??
                              "No job location",
                            overflow: TextOverflow.ellipsis, style: Get.theme
                                .textTheme.bodyLarge!.copyWith(
                                color: const Color(0xffCFCFCF)),),
                          SizedBox(height: Get.height * 0.015,),
                          InkWell(
                            // onTap: ()=>Get.to(const GoogleMapIntegration()),
                              child: SizedBox(height: Get.height * 0.3,
                                  child: GoogleMapIntegration(jobPageView: true,
                                    lat: double.tryParse(
                                        "${jobController.jobData.value.lat}"),
                                    long: double.tryParse(
                                        "${jobController.jobData.value
                                            .long}"),))),
                          SizedBox(height: Get.height * 0.035,),
                          Text("Information", style: Get.theme.textTheme
                              .titleSmall!.copyWith(color: AppColors.white),),
                          SizedBox(height: Get.height * 0.015,),
                          Text("Position", style: Get.theme.textTheme
                              .titleSmall!.copyWith(color: AppColors.white),),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Text(
                            jobController.jobData.value.job?.jobPositions ??
                                "No position",
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: Color(0xffCFCFCF)),
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
                          jobController.jobData.value.job?.education.toString()
                              .toLowerCase() == "null" ||
                              jobController.jobData.value.job?.education
                                  .toString()
                                  .length == 0
                              ? Text("No qualification", style: Get.theme
                              .textTheme.bodyLarge!.copyWith(
                              color: const Color(0xffCFCFCF)),) :
                          Text(
                            jobController.jobData.value.job?.education ?? "",
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: Color(0xffCFCFCF)),
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
                          years
                              .toString()
                              .length == 0 && months
                              .toString()
                              .length == 0 ? const Text("No experience") : Text(
                            "${years ?? ""} ${ months ?? ""}",
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: const Color(0xffCFCFCF)),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.2,
                          ),
                          const Text("Job Type", style: TextStyle(
                              color: Colors.white, fontSize: 14),),
                          SizedBox(height: Get.height * 0.015,),
                          Text(jobController.jobData.value.job
                              ?.employmentType ?? "No job type",
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: const Color(0xffCFCFCF)),),
                          const Divider(color: Colors.grey, thickness: 0.2,),
                          const Text("Specialization", style: TextStyle(
                              color: Colors.white, fontSize: 14),),
                          SizedBox(height: Get.height * 0.015,),
                          Text(jobController.jobData.value.job
                              ?.specialization ?? "No specialization",
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: const Color(0xffCFCFCF)),),
                          const Divider(color: Colors.grey, thickness: 0.2,),
                          const Text("Type of workplace",
                            style: TextStyle(
                                color: Colors.white, fontSize: 14),),
                          SizedBox(height: Get.height * 0.015,),
                          Text(jobController.jobData.value.job
                              ?.typeOfWorkplace ?? "No workplace",
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: const Color(0xffCFCFCF)),),
                          const Divider(color: Colors.grey, thickness: 0.2,),
                          const Text(
                            "Preferred work experience",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Text(
                            jobController.jobData.value.job
                                ?.preferredWorkExperience ??
                                "No preferred work experience",
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: Color(0xffCFCFCF)),
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
                          jobController.jobData.value.job?.languageName ==
                              null || jobController.jobData.value.job
                              ?.languageName?.length == 0 ?
                          Text("No language", style: Get.theme.textTheme
                              .bodyLarge!.copyWith(
                              color: const Color(0xffCFCFCF)),) :
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: jobController.jobData.value.job
                                  ?.languageName?.length,
                              itemBuilder: (context, index) {
                                var data = jobController.jobData.value.job
                                    ?.languageName?[index];
                                return Text(data?.languages ?? "",
                                  style: Get.theme.textTheme.bodyLarge!
                                      .copyWith(color: const Color(0xffCFCFCF)),
                                );
                              }
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.2,
                          ),
                          Text(
                            "Soft Skills",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.white),
                          ),
                          SizedBox(height: Get.height * 0.01,),
                          /////
                          jobController.jobData.value.job?.jobsDetail
                              ?.skillName == null ||
                              jobController.jobData.value.job?.jobsDetail
                                  ?.skillName?.length == 0 ?
                          Text("No skills", style: Get.theme.textTheme
                              .bodyLarge!.copyWith(color: Color(0xffCFCFCF)),) :
                          GridView.builder(gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 39,
                              maxCrossAxisExtent: Get.width * 0.35,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6),
                              itemCount: jobController.jobData.value.job
                                  ?.jobsDetail?.skillName?.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * .03),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xff484848),
                                  ),
                                  child: Text(
                                    jobController.jobData.value.job?.jobsDetail
                                        ?.skillName?[index].skills ?? "",
                                    overflow: TextOverflow
                                        .ellipsis,
                                    style: Get.theme.textTheme
                                        .bodySmall!.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight
                                            .w400, fontSize: 9),),
                                );
                              }),

                          ///
                          SizedBox(height: Get.height * 0.04,),
                          Text(
                            "Passion",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.white),
                          ),
                          SizedBox(height: Get.height * 0.01,),
                          jobController.jobData.value.job?.jobsDetail
                              ?.passionName == null ||
                              jobController.jobData.value.job?.jobsDetail
                                  ?.passionName?.length == 0 ?
                          Text("No skills", style: Get.theme.textTheme
                              .bodyLarge!.copyWith(
                              color: const Color(0xffCFCFCF)),) :
                          GridView.builder(gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 39,
                              maxCrossAxisExtent: Get.width * 0.35,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6),
                              itemCount: jobController.jobData.value.job
                                  ?.jobsDetail?.passionName?.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                //var data = seekerProfileController.viewSeekerData.value.seekerDetails?.skillName?[index];
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * .03),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(20),
                                    color: const Color(0xff484848),
                                  ),
                                  // padding: const EdgeInsets.all(
                                  //     8),
                                  child: Text(
                                    jobController.jobData.value.job?.jobsDetail
                                        ?.passionName?[index].passion ?? '',
                                    overflow: TextOverflow
                                        .ellipsis,
                                    style: Get.theme.textTheme
                                        .bodySmall!.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight
                                            .w400, fontSize: 9),),
                                );
                              }),
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                          Text(
                            "industry preference",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.white),
                          ),
                          SizedBox(height: Get.height * 0.01,),
                          jobController.jobData.value.job?.jobsDetail
                              ?.industryPreferenceName == null ||
                              jobController.jobData.value.job?.jobsDetail
                                  ?.industryPreferenceName?.length == 0 ?
                          Text("No skills", style: Get.theme.textTheme
                              .bodyLarge!.copyWith(
                              color: const Color(0xffCFCFCF)),) :
                          GridView.builder(gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 39,
                              maxCrossAxisExtent: Get.width * 0.35,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6),
                              itemCount: jobController.jobData.value.job
                                  ?.jobsDetail?.industryPreferenceName?.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                //var data = seekerProfileController.viewSeekerData.value.seekerDetails?.skillName?[index];
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * .03),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(20),
                                    color: Color(0xff484848),
                                  ),
                                  // padding: const EdgeInsets.all(
                                  //     8),
                                  child: Text(
                                    jobController.jobData.value.job?.jobsDetail
                                        ?.industryPreferenceName?[index]
                                        .industryPreferences ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.bodySmall!
                                        .copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 9),),
                                );
                              }),
                          SizedBox(height: Get.height * 0.04,),
                          Text("Strengths",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.white),
                          ),
                          SizedBox(height: Get.height * 0.01,),
                          jobController.jobData.value.job?.jobsDetail
                              ?.strengthsName == null ||
                              jobController.jobData.value.job?.jobsDetail
                                  ?.strengthsName?.length == 0 ?
                          Text("No skills", style: Get.theme.textTheme
                              .bodyLarge!.copyWith(
                              color: const Color(0xffCFCFCF)),) :
                          GridView.builder(gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 39,
                              maxCrossAxisExtent: Get.width * 0.35,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6),
                              itemCount: jobController.jobData.value.job
                                  ?.jobsDetail?.strengthsName?.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * .03),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(20),
                                    color: const Color(0xff484848),
                                  ),
                                  // padding: const EdgeInsets.all(
                                  //     8),
                                  child: Text(
                                    jobController.jobData.value.job?.jobsDetail
                                        ?.strengthsName?[index].strengths ?? '',
                                    overflow: TextOverflow
                                        .ellipsis,
                                    style: Get.theme.textTheme
                                        .bodySmall!.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight
                                            .w400, fontSize: 9),),
                                );
                              }),
                          SizedBox(height: Get.height * 0.04,),
                          Text(
                            "Salary expectation",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.white),
                          ),
                          SizedBox(height: Get.height * 0.01,),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            child: Text(
                              '${jobController.jobData.value.job?.jobsDetail
                                  ?.minSalaryExpectation ?? ''}  ${jobController
                                  .jobData.value.job?.jobsDetail
                                  ?.maxSalaryExpectation ??
                                  'No salary expectation'} ',
                              style: Get.theme.textTheme.bodySmall!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),


                          SizedBox(height: Get.height * 0.04,),
                          Text(
                            "When can i start working?",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.white),
                          ),
                          SizedBox(height: Get.height * 0.01,),
                          jobController.jobData.value.job?.jobsDetail
                              ?.startWorkName == null ||
                              jobController.jobData.value.job?.jobsDetail
                                  ?.startWorkName?.length == 0 ?
                          Text("No skills", style: Get.theme.textTheme
                              .bodyLarge!.copyWith(
                              color: const Color(0xffCFCFCF)),) :
                          GridView.builder(gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 39,
                              maxCrossAxisExtent: Get.width * 0.35,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6),
                              itemCount: jobController.jobData.value.job
                                  ?.jobsDetail?.startWorkName?.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * .03),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(20),
                                    color: Color(0xff484848),
                                  ),
                                  // padding: const EdgeInsets.all(
                                  //     8),
                                  child: Text(
                                    jobController.jobData.value.job?.jobsDetail
                                        ?.startWorkName?[index].startWork ?? '',
                                    overflow: TextOverflow
                                        .ellipsis,
                                    style: Get.theme.textTheme
                                        .bodySmall!.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight
                                            .w400, fontSize: 9),),
                                );
                              }),

                          SizedBox(height: Get.height * 0.04,),
                          Text(
                            "Availability",
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.white),
                          ),
                          SizedBox(height: Get.height * 0.01,),
                          jobController.jobData.value.job?.jobsDetail
                              ?.availabityName == null ||
                              jobController.jobData.value.job?.jobsDetail
                                  ?.availabityName?.length == 0 ?
                          Text("No skills", style: Get.theme.textTheme
                              .bodyLarge!.copyWith(
                              color: const Color(0xffCFCFCF)),) :
                          GridView.builder(gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 39,
                              maxCrossAxisExtent: Get.width * 0.35,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6),
                              itemCount: jobController.jobData.value.job
                                  ?.jobsDetail?.availabityName?.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * .03),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(20),
                                    color: const Color(0xff484848),
                                  ),
                                  child: Text(
                                    jobController.jobData.value.job?.jobsDetail
                                        ?.availabityName?[index].availabity ??
                                        '',
                                    overflow: TextOverflow
                                        .ellipsis,
                                    style: Get.theme.textTheme
                                        .bodySmall!.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight
                                            .w400, fontSize: 9),),
                                );
                              }),
                          SizedBox(height: Get.height * 0.055,),
                          jobController.jobData.value.isApplied == true
                              ? const SizedBox()
                              :

                          Obx(() =>
                              MyButton(
                                loading: applyJobController.loading.value,
                                title: "APPLY NOW",
                                onTap1: () async {
                                  if (!applyJobController.loading.value) {
                                    var result = await applyJobController
                                        .applyJob("${widget.jobId}");
                                    if (result == true) {
                                      jobController.viewJobFromNotificationData(
                                          context, widget.jobId,
                                          widget.seekerId);
                                      setState(() {});
                                    }
                                  }
                                },),
                          ),
                          SizedBox(height: Get.height * .1,),
                        ],
                      ),
                    ),
                  ),
                );
          }
        })
    ));
  }
}
