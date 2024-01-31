import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/controllers/SeekerSavedJobsController/SeekerSavedJobsController.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/CommonWidgets.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/ApplyJobController/ApplyJobController.dart';
import '../../controllers/JobAlertSeenUnseenJobController/JobAlertSeenUnseenJobController.dart';
import '../../controllers/JobAlertWiseJobListingController/JobAlertWiseJobListingController.dart';
import '../../controllers/SeekerJobAlertListController/SeekerJobAlertListController.dart';
import '../../controllers/SeekerJobFilterController/SeekerJobFilterController.dart';
import '../../controllers/SeekerUnSavePostController/SeekerUnSavePostController.dart';
import '../../utils/VideoPlayerScreen.dart';
import '../../widgets/google_map_widget.dart';
import 'package:get/get.dart';

import '../../widgets/my_button.dart';


class JobViewJobAlert extends StatefulWidget {
  final String jobID ;
  const JobViewJobAlert({super.key, required this.jobID});

  @override
  State<JobViewJobAlert> createState() => JobViewJobAlertState();
}

class JobViewJobAlertState extends State<JobViewJobAlert> {

  var years = '';
  var months = '';

  static int currentPage = 0;

  var position = 0.0.obs;


  SeekerJobAlertListController seekerJobAlertListControllerInstanse = Get.put(SeekerJobAlertListController()) ;

  JobAlertSeenUnseenJobController jobAlertSeenUnseenJobControllerInstanse = Get.put(JobAlertSeenUnseenJobController()) ;
  SeekerJobAlertWiseJobListingController seekerJobAlertWiseJobListingControllerInstanse = Get.put(SeekerJobAlertWiseJobListingController());
  // TabBarController tabBarController = Get.put(TabBarController());
  // GetJobsListingController getJobsListingController = Get.put(GetJobsListingController());
  // ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController());
  SeekerSaveJobController seekerSaveJobController = Get.put(SeekerSaveJobController());
  ApplyJobController applyJobController = Get.put(ApplyJobController());
  SeekerUnSavePostController unSavePostController = Get.put(SeekerUnSavePostController());
  // GetJobsListingModel jobModel = GetJobsListingModel();
  SeekerJobFilterController jobFilterController = Get.put(SeekerJobFilterController());
  Completer<GoogleMapController> mapController = Completer();

  @override
  void initState() {
    // TODO: implement initState
    jobAlertSeenUnseenJobControllerInstanse.jobAlertSeenUnseenJobApi(widget.jobID) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // extendBody: true,
      // extendBodyBehindAppBar: true,
        appBar: AppBar(
          // toolbarHeight: 45,
          backgroundColor: AppColors.black,
          leading: GestureDetector(
            onTap: () {

            },
            child: IconButton(
              onPressed: () {
                Get.back() ;
                seekerJobAlertListControllerInstanse.viewSeekerJobAlertListApi() ;
              },
              icon: Image.asset(
                "assets/images/icon_back_blue.png",height: 55,
              ),
            ),
          ),
          // title: Text("Job Alerts",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
        ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          if(didPop) {
            seekerJobAlertListControllerInstanse.viewSeekerJobAlertListApi() ;
          }
        },
        child: Stack(
            children: [
              PageView.builder(
                // controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: seekerJobAlertWiseJobListingControllerInstanse
                    .viewSeekerJobAlertWiseJobListingData.value.jobList?.length,
                itemBuilder: (context, index) {
                  if (seekerJobAlertWiseJobListingControllerInstanse
                      .viewSeekerJobAlertWiseJobListingData.value.jobList?[index]
                      .workExperience != null &&
                      seekerJobAlertWiseJobListingControllerInstanse
                          .viewSeekerJobAlertWiseJobListingData.value
                          .jobList?[index].workExperience
                          .toString()

                          .length != 0) {
                    var experience = seekerJobAlertWiseJobListingControllerInstanse
                        .viewSeekerJobAlertWiseJobListingData.value
                        .jobList?[index].workExperience.toString().split(".");
                    if (experience?.length == 2) {
                      if (experience?[0] != null && experience?[0].length != 0 &&
                          experience?[0].toString() != "0") {
                        years = "${experience?[0]} year";
                      }
                      if (experience?[1] != null && experience?[1].length != 0 &&
                          experience?[1].toString() != "00") {
                        months = "${experience?[1]} month";
                      }
                    }
                  }
                  return SingleChildScrollView(
                    // controller: _scrollController,
                    // physics: const BouncingScrollPhysics(),
                    clipBehavior: Clip.hardEdge,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          CachedNetworkImage(
                            imageUrl: seekerJobAlertWiseJobListingControllerInstanse
                                .viewSeekerJobAlertWiseJobListingData.value
                                .jobList?[index].featureImg ?? "",
                            placeholder: (context, url) =>
                                SizedBox(height: Get.height,
                                  child: const Center(
                                      child: CircularProgressIndicator()),),
                            imageBuilder: (context, imageProvider) =>
                                Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),),
                                ),),
                          // Positioned(
                          //   right: 10,
                          //   top: Get.height * 0.16,
                          //   child: Column(
                          //     children: [
                          //       GestureDetector(
                          //         onTap:
                          //             () {
                          //           showSeekerHomePagePercentageProfile(context, getJobsListingController.getJobsListing.value.jobs?[index]);
                          //         },
                          //         child:
                          //         Container(
                          //           padding: const EdgeInsets.all(4.0) ,
                          //           decoration: BoxDecoration(
                          //               shape: BoxShape.circle,
                          //               color: Colors.transparent,
                          //               border: Border.all(color: AppColors.white, width: 2)),
                          //           child:
                          //           Stack(
                          //             children: [
                          //               Container(
                          //                   padding: const EdgeInsets.all(4.0) ,
                          //                   decoration: BoxDecoration(
                          //                       shape: BoxShape.circle,
                          //                       color: AppColors.blueThemeColor,
                          //                       border: Border.all(color: AppColors.white, width: 2)),
                          //                   child: SizedBox(
                          //                     height: 70,
                          //                     width : 70 ,
                          //                     child: CircularProgressIndicator(
                          //                       value: getJobsListingController.getJobsListing.value.jobs?[index].jobMatchPercentage / 100,
                          //                       backgroundColor: AppColors.white,
                          //                       color: AppColors.green,
                          //                       strokeWidth: 12,
                          //                     ),
                          //                   )
                          //               ),
                          //               Container(
                          //                 margin: const EdgeInsets.all(4.0),
                          //                 height: 70,
                          //                 width : 70 ,
                          //                 alignment: Alignment.center,
                          //                 child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          //                   children: [
                          //                     Text('${getJobsListingController.getJobsListing.value.jobs?[index].jobMatchPercentage}%',
                          //                         style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white)),
                          //                     Text('match',
                          //                         style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white, fontSize: 7)),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Positioned(
                            left: 12,
                            top: Get.height * 0.16,
                            child: Column(
                              children: [
                                GestureDetector(
                                    onTap:
                                        () {
                                      // getJobsListingController.saved.value=true;
                                      CommonFunctions.confirmationDialog(context,
                                          message: seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].postSaved ? "Do you want to remove the\n post from saved posts" : "Do you want to save the post",
                                          onTap: () async {
                                            Get.back();
                                            if (seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].postSaved == true) {
                                              CommonFunctions.showLoadingDialog(
                                                  context, "removing...");
                                              var result = await unSavePostController.unSavePost(seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].id.toString(),
                                                  "1", context, true);
                                              if (result == true) {
                                                if (kDebugMode) {
                                                  print("inside result");
                                                }
                                                seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].postSaved = false;
                                                setState(() {});
                                              }
                                            } else {
                                              CommonFunctions.showLoadingDialog(
                                                  context, "Saving");
                                              var result = await seekerSaveJobController.saveJobApi(seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].id, 1);
                                              if (result == true) {
                                                if (kDebugMode) {
                                                  print("inside result");
                                                }
                                                seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].postSaved = true;
                                                setState(() {});
                                              }
                                            }
                                          });
                                    },
                                    child: seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].postSaved == false
                                        ? Image.asset(
                                      "assets/images/icon_unsave_post.png",
                                      height: 50,
                                      width: 50,
                                    )
                                        : Image.asset(
                                      "assets/images/icon_Save_post.png",
                                      height: 50,
                                      width: 50,
                                    )),
                                SizedBox(
                                  height: Get.height *
                                      .01,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (seekerJobAlertWiseJobListingControllerInstanse
                                        .viewSeekerJobAlertWiseJobListingData
                                        .value.jobList?[index].shortVideo ==
                                        null ||
                                        seekerJobAlertWiseJobListingControllerInstanse
                                            .viewSeekerJobAlertWiseJobListingData
                                            .value.jobList?[index].shortVideo
                                            ?.length == 0) {
                                      Utils.showMessageDialog(
                                          context, "video not uploaded yet");
                                    } else {
                                      Get.back();
                                      Get.to(() =>
                                          VideoPlayerScreen(
                                              videoPath: seekerJobAlertWiseJobListingControllerInstanse
                                                  .viewSeekerJobAlertWiseJobListingData
                                                  .value.jobList?[index]
                                                  .shortVideo ?? ""));
                                    }
                                  },
                                  child:
                                  Container(alignment: Alignment.center,
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.blueThemeColor),
                                    child: Image.asset(
                                      "assets/images/icon_video.png",
                                      height: 18, fit: BoxFit.cover,),
                                  ),),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: Get.height * .15 - position.value,
                            left: 12,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: Get.width * .8,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: const Color(0xff0D5AFE)
                                            .withOpacity(.6),
                                        borderRadius: BorderRadius.circular(22)
                                    ),
                                    child: Text(
                                      "${seekerJobAlertWiseJobListingControllerInstanse
                                          .viewSeekerJobAlertWiseJobListingData
                                          .value.jobList?[index].jobPositions ??
                                          ""}",
                                      // getJobsListingController.getJobsListing.value.jobs?[currentPage].jobPositions ?? "No job position",
                                      overflow: TextOverflow.ellipsis,
                                      style: Get.theme.textTheme.displaySmall!
                                          .copyWith(color: AppColors.white),),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Get.to(() =>  RecruiterProfileTabBar(recruiterID: getJobsListingController.getJobsListing.value.jobs?[currentPage].recruiterDetails?.recruiterId.toString(),isSeeker: true,) ,);
                                      },
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: Get.width * .5
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: const Color(0xff0D5AFE)
                                                .withOpacity(.6),
                                            borderRadius: BorderRadius.circular(
                                                22)),
                                        child: Text(
                                          seekerJobAlertWiseJobListingControllerInstanse
                                              .viewSeekerJobAlertWiseJobListingData
                                              .value.jobList?[index]
                                              .recruiterDetails?.companyName ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: Get.theme.textTheme.bodyLarge!
                                              .copyWith(color: AppColors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: const Color(0xff0D5AFE)
                                              .withOpacity(.6),
                                          borderRadius: BorderRadius.circular(
                                              22)),
                                      child: Text(
                                        "${seekerJobAlertWiseJobListingControllerInstanse
                                            .viewSeekerJobAlertWiseJobListingData
                                            .value.jobList?[index].jobsDetail
                                            ?.minSalaryExpectation} - ${seekerJobAlertWiseJobListingControllerInstanse
                                            .viewSeekerJobAlertWiseJobListingData
                                            .value.jobList?[index].jobsDetail
                                            ?.maxSalaryExpectation}",
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.theme.textTheme.bodyLarge!
                                            .copyWith(color: AppColors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),),
                                    ),
                                  ],),
                                const SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: Get.width * .5),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: const Color(0xff0D5AFE)
                                              .withOpacity(.6),
                                          borderRadius: BorderRadius.circular(
                                              22)),
                                      child: Text(
                                        "${seekerJobAlertWiseJobListingControllerInstanse
                                            .viewSeekerJobAlertWiseJobListingData
                                            .value.jobList?[index].jobLocation ??
                                            "No location"}",
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.theme.textTheme.bodyLarge!
                                            .copyWith(
                                            color: AppColors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),),
                                    ),
                                    // const SizedBox(width: 10,),
                                    // CountryFlag.fromCountryCode( getJobsListingController.getJobsListing.value.jobs?[currentPage].countryCode ?? "GB",
                                    //   height: 40, width: 40,
                                    //   // borderRadius: 20,
                                    // )
                                  ],
                                ),
                                const SizedBox(height: 10,),
                              ],),
                          ),
                        ],),
                        SizedBox(height: Get.height * 0.025,),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height * .03,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/icon_job_description.png",
                                    height: 20, width: 20,),
                                  SizedBox(width: Get.width * .02,),
                                  Text("Job Description",
                                    style: Get.theme.textTheme.labelMedium!
                                        .copyWith(color: AppColors.black),),
                                ],
                              ),
                              CommonWidgets.divider(),
                              seekerJobAlertWiseJobListingControllerInstanse
                                  .viewSeekerJobAlertWiseJobListingData.value
                                  .jobList?[index].description == null ||
                                  CommonFunctions
                                      .parseHTML(
                                      seekerJobAlertWiseJobListingControllerInstanse
                                          .viewSeekerJobAlertWiseJobListingData
                                          .value.jobList?[index].description)
                                      .toString()
                                      .trim()
                                      .length == 0 ?
                              Text("No job description", style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: AppColors.black,
                                  fontWeight: FontWeight.w400),) :
                              HtmlWidget(
                                seekerJobAlertWiseJobListingControllerInstanse
                                    .viewSeekerJobAlertWiseJobListingData.value
                                    .jobList?[index].description ??
                                    'No job description',
                                textStyle: Get.theme.textTheme.labelLarge!
                                    .copyWith(color: AppColors.silverColor,
                                    fontWeight: FontWeight.w400),),
                              SizedBox(height: Get.height * 0.03,),
                              Row(
                                children: [
                                  Image.asset("assets/images/icon_requirment.png",
                                    height: Get.height * .03,),
                                  SizedBox(width: Get.width * .02,),
                                  Text("Requirements",
                                    style: Get.theme.textTheme.labelMedium!
                                        .copyWith(color: AppColors.black),),
                                ],
                              ),
                              CommonWidgets.divider(),
                              seekerJobAlertWiseJobListingControllerInstanse
                                  .viewSeekerJobAlertWiseJobListingData.value
                                  .jobList?[index].requirements == null ||
                                  CommonFunctions
                                      .parseHTML(
                                      seekerJobAlertWiseJobListingControllerInstanse
                                          .viewSeekerJobAlertWiseJobListingData
                                          .value.jobList?[index].description)
                                      .toString()
                                      .trim()
                                      .length == 0 ?
                              Text("No requirements", style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: AppColors.black,
                                  fontWeight: FontWeight.w400),) :
                              HtmlWidget(
                                seekerJobAlertWiseJobListingControllerInstanse
                                    .viewSeekerJobAlertWiseJobListingData.value
                                    .jobList?[index].requirements ??
                                    'No requirements',
                                textStyle: Get.theme.textTheme.labelLarge!
                                    .copyWith(color: AppColors.silverColor,
                                    fontWeight: FontWeight.w400),),
                              SizedBox(height: Get.height * 0.025,),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/icon_location_seeker.png",
                                    height: 20, width: 20,),
                                  SizedBox(width: Get.width * .02,),
                                  Text("Location",
                                    style: Get.theme.textTheme.labelMedium!
                                        .copyWith(color: AppColors.black),),
                                ],
                              ),
                              CommonWidgets.divider(),
                              // SizedBox(height: Get.height * 0.015,),
                              Text(seekerJobAlertWiseJobListingControllerInstanse
                                  .viewSeekerJobAlertWiseJobListingData.value
                                  .jobList?[index].jobLocation ??
                                  "No job location",
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.labelLarge!.copyWith(
                                    color: AppColors.silverColor,
                                    fontWeight: FontWeight.w400),),
                              SizedBox(height: Get.height * 0.015,),
                              SizedBox(height: 300,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(double.tryParse(
                                        "${seekerJobAlertWiseJobListingControllerInstanse
                                            .viewSeekerJobAlertWiseJobListingData
                                            .value.jobList?[index].lat}")!,
                                        double.tryParse(
                                            "${seekerJobAlertWiseJobListingControllerInstanse
                                                .viewSeekerJobAlertWiseJobListingData
                                                .value.jobList?[index].long}")!),
                                    zoom: 12,
                                  ),
                                  markers: <Marker>{
                                    Marker(
                                      markerId: const MarkerId("1"),
                                      position: LatLng(double.tryParse(
                                          "${seekerJobAlertWiseJobListingControllerInstanse
                                              .viewSeekerJobAlertWiseJobListingData
                                              .value.jobList?[index].lat}")!,
                                          double.tryParse(
                                              "${seekerJobAlertWiseJobListingControllerInstanse
                                                  .viewSeekerJobAlertWiseJobListingData
                                                  .value.jobList?[index]
                                                  .long}")!),
                                      infoWindow: const InfoWindow(
                                        title: "Job Location",
                                      ),
                                    ),
                                  },
                                  mapType: MapType.normal,
                                  myLocationEnabled: true,
                                  compassEnabled: true,
                                  zoomControlsEnabled: false,
                                  onLongPress: (argument) => Get.to(
                                      GoogleMapIntegration(jobPageView: true,
                                          lat: double.tryParse(
                                              "${seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].lat}")!, long: double.tryParse("${seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].long}")!)),
                                  onMapCreated: (GoogleMapController controller) {
                                    mapController.complete(controller);
                                    if (kDebugMode) {
                                      print("inside 1");
                                    }
                                  },
                                ),
                                // GoogleMapIntegration(jobPageView: true,lat: double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].lat}"),long:  double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].long}"),)
                              ),
                              const SizedBox(height: 30,),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/icon_information.png",
                                    height: 20, width: 20,),
                                  SizedBox(width: Get.width * .02,),
                                  Text("Information",
                                    style: Get.theme.textTheme.labelMedium!
                                        .copyWith(color: AppColors.black),),
                                ],
                              ),
                              CommonWidgets.divider(),
                              // SizedBox(height: Get.height * 0.015,),
                              Text("Position",
                                style: Get.theme.textTheme.titleSmall!.copyWith(
                                    color: AppColors.black),),
                              SizedBox(height: Get.height * 0.015,),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: AppColors.homeGrey,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text(
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobPositions ??
                                      "No position",
                                  style: Get.theme.textTheme.bodyLarge!.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400),),
                              ),
                              // const Divider(color: Colors.grey, thickness: 0.2,),
                              const SizedBox(height: 25,),
                              Text("Qualification",
                                style: Get.theme.textTheme.titleSmall!.copyWith(
                                    color: AppColors.black),),
                              SizedBox(height: Get.height * 0.015,),
                              seekerJobAlertWiseJobListingControllerInstanse
                                  .viewSeekerJobAlertWiseJobListingData.value
                                  .jobList?[index].education.toString()
                                  .toLowerCase() == "null" ||
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].education
                                      .toString()
                                      .length == 0
                                  ? Text("No qualification",
                                style: Get.theme.textTheme.bodyLarge!.copyWith(
                                    color: AppColors.black),) :
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: AppColors.homeGrey,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text(
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].education ?? "",
                                  style: Get.theme.textTheme.bodyLarge!.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(height: 25,),
                              Text("Experience",
                                style: Get.theme.textTheme.titleSmall!.copyWith(
                                    color: AppColors.black),),
                              SizedBox(height: Get.height * 0.015,),
                              Container(padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: AppColors.homeGrey,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: years
                                    .toString()
                                    .length == 0 && months
                                    .toString()
                                    .length == 0 ? Text("No experience",
                                    style: Get.theme.textTheme.bodyLarge!
                                        .copyWith(color: AppColors.black)) :
                                Text("${years ?? ""} ${ months ?? ""}",
                                  style: Get.theme.textTheme.bodyLarge!.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(height: 25,),
                              Text("Job Type",
                                style: Get.theme.textTheme.titleSmall!.copyWith(
                                    color: AppColors.black),),
                              SizedBox(height: Get.height * 0.015,),
                              Container(padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: AppColors.homeGrey,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text(
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].employmentType ??
                                      "No job type",
                                  style: Get.theme.textTheme.bodyLarge!.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400),),
                              ),
                              const SizedBox(height: 25,),
                              // const Divider(color: Colors.grey, thickness: 0.2,),
                              Text("Specialization",
                                style: Get.theme.textTheme.titleSmall!.copyWith(
                                    color: AppColors.black),),
                              SizedBox(height: Get.height * 0.015,),
                              Container(padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: AppColors.homeGrey,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text(
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].specialization ??
                                      "No specialization",
                                  style: Get.theme.textTheme.bodyLarge!.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400),),
                              ),
                              const SizedBox(height: 25,),
                              // const Divider(color: Colors.grey, thickness: 0.2,),
                              Text("Type of workplace",
                                style: Get.theme.textTheme.titleSmall!.copyWith(
                                    color: AppColors.black),),
                              SizedBox(height: Get.height * 0.015,),
                              Container(padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: AppColors.homeGrey,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text(
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].typeOfWorkplace ??
                                      "No workplace",
                                  style: Get.theme.textTheme.bodyLarge!.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400),),
                              ),
                              const SizedBox(height: 25,),
                              // const Divider(color: Colors.grey, thickness: 0.2,),
                              Text("Preferred work experience",
                                style: Get.theme.textTheme.titleSmall!.copyWith(
                                    color: AppColors.black),
                              ),
                              SizedBox(height: Get.height * 0.015,),
                              Container(padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: AppColors.homeGrey,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text(
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].preferredWorkExperience ??
                                      "No preferred work experience",
                                  style: Get.theme.textTheme.bodyLarge!.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(height: 25,),
                              Text("Language",
                                style: Get.theme.textTheme.titleSmall!.copyWith(
                                    color: AppColors.black),),
                              SizedBox(height: Get.height * 0.015,),
                              seekerJobAlertWiseJobListingControllerInstanse
                                  .viewSeekerJobAlertWiseJobListingData.value
                                  .jobList?[index].languageName == null ||
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].languageName?.length == 0 ?
                              Text("No language",
                                style: Get.theme.textTheme.bodyLarge!.copyWith(
                                    color: AppColors.black),) :
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for(int i = 0; i <
                                      seekerJobAlertWiseJobListingControllerInstanse
                                          .viewSeekerJobAlertWiseJobListingData
                                          .value.jobList![index].languageName!
                                          .length; i++ )
                                    Container(padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.only(bottom: 8),
                                      decoration: BoxDecoration(
                                          color: AppColors.homeGrey,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(
                                        seekerJobAlertWiseJobListingControllerInstanse
                                            .viewSeekerJobAlertWiseJobListingData
                                            .value.jobList?[index]
                                            .languageName?[i].languages ?? "",
                                        style: Get.theme.textTheme.bodyLarge!
                                            .copyWith(color: AppColors.black,
                                            fontWeight: FontWeight.w400),
                                      ),),
                                ],),
                              SizedBox(height: Get.height * .02,),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/skillsvg.png", height: 20,
                                    width: 20,),
                                  SizedBox(width: Get.width * .02,),
                                  Text("Skills",
                                    style: Get.theme.textTheme.labelMedium!
                                        .copyWith(color: AppColors.black),),
                                ],
                              ),
                              CommonWidgets.divider(),
                              Text("Soft Skills",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: AppColors.black),
                              ),
                              SizedBox(height: Get.height * 0.01,),
                              seekerJobAlertWiseJobListingControllerInstanse
                                  .viewSeekerJobAlertWiseJobListingData.value
                                  .jobList?[index].jobsDetail?.skillName ==
                                  null ||
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobsDetail?.skillName
                                      ?.length == 0 ?
                              Text("No skills",
                                style: Get.theme.textTheme.bodyLarge!.copyWith(
                                    color: AppColors.black),) :
                              Wrap(
                                spacing: 6.0,
                                runSpacing: 6.0,
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: List.generate(
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobsDetail?.skillName
                                      ?.length ?? 0,
                                      (i) {
                                    return Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.homeGrey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                          seekerJobAlertWiseJobListingControllerInstanse
                                              .viewSeekerJobAlertWiseJobListingData
                                              .value.jobList?[index].jobsDetail
                                              ?.skillName?[i].skills ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: Get.theme.textTheme.labelLarge!
                                              .copyWith(color: AppColors.black,
                                              fontWeight: FontWeight.w400)
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: Get.height * 0.04,),
                              Text("Passion",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: AppColors.black),
                              ),
                              SizedBox(height: Get.height * 0.01,),
                              seekerJobAlertWiseJobListingControllerInstanse
                                  .viewSeekerJobAlertWiseJobListingData.value
                                  .jobList?[index].jobsDetail?.passionName ==
                                  null ||
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobsDetail?.passionName
                                      ?.length == 0 ?
                              Text("No skills",
                                style: Get.theme.textTheme.bodyLarge!.copyWith(
                                    color: AppColors.black),) :
                              Wrap(
                                spacing: 6.0,
                                runSpacing: 6.0,
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: List.generate(
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobsDetail?.passionName
                                      ?.length ?? 0,
                                      (i) {
                                    return Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.homeGrey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                          seekerJobAlertWiseJobListingControllerInstanse
                                              .viewSeekerJobAlertWiseJobListingData
                                              .value.jobList?[index].jobsDetail
                                              ?.passionName?[i].passion ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: Get.theme.textTheme.labelLarge!
                                              .copyWith(color: AppColors.black,
                                              fontWeight: FontWeight.w400)
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: Get.height * 0.04,),
                              Text(
                                "industry preference",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: AppColors.black),
                              ),
                              SizedBox(height: Get.height * 0.01,),
                              seekerJobAlertWiseJobListingControllerInstanse
                                  .viewSeekerJobAlertWiseJobListingData.value
                                  .jobList?[index].jobsDetail
                                  ?.industryPreferenceName == null ||
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobsDetail
                                      ?.industryPreferenceName?.length == 0 ?
                              Text("No skills",
                                style: Get.theme.textTheme.bodyLarge!.copyWith(
                                    color: AppColors.black),) :
                              Wrap(
                                spacing: 6.0,
                                runSpacing: 6.0,
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: List.generate(
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobsDetail
                                      ?.industryPreferenceName?.length ?? 0,
                                      (i) {
                                    return Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.homeGrey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                          seekerJobAlertWiseJobListingControllerInstanse
                                              .viewSeekerJobAlertWiseJobListingData
                                              .value.jobList?[index].jobsDetail
                                              ?.industryPreferenceName?[i]
                                              .industryPreferences ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: Get.theme.textTheme.labelLarge!
                                              .copyWith(color: AppColors.black,
                                              fontWeight: FontWeight.w400)
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: Get.height * 0.04,),
                              Text("Strengths",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: AppColors.black),),
                              SizedBox(height: Get.height * 0.01,),
                              seekerJobAlertWiseJobListingControllerInstanse
                                  .viewSeekerJobAlertWiseJobListingData.value
                                  .jobList?[index].jobsDetail?.strengthsName ==
                                  null ||
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobsDetail?.strengthsName
                                      ?.length == 0 ?
                              Text("No skills",
                                style: Get.theme.textTheme.bodyLarge!.copyWith(
                                    color: AppColors.black),) :
                              Wrap(
                                spacing: 6.0,
                                runSpacing: 6.0,
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: List.generate(
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobsDetail?.strengthsName
                                      ?.length ?? 0,
                                      (i) {
                                    return Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.homeGrey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                          seekerJobAlertWiseJobListingControllerInstanse
                                              .viewSeekerJobAlertWiseJobListingData
                                              .value.jobList?[index].jobsDetail
                                              ?.strengthsName?[i].strengths ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: Get.theme.textTheme.labelLarge!
                                              .copyWith(color: AppColors.black,
                                              fontWeight: FontWeight.w400)
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: Get.height * 0.04,),
                              Text("Salary expectation",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: AppColors.black),
                              ),
                              SizedBox(height: Get.height * 0.01,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.homeGrey,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                child: Text(
                                  '${seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobsDetail
                                      ?.minSalaryExpectation ??
                                      ''} - ${seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobsDetail
                                      ?.maxSalaryExpectation ??
                                      'No salary expectation'} ',
                                  style: Get.theme.textTheme.labelLarge!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.04,),
                              Text("When can i start working?",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: AppColors.black),
                              ),
                              SizedBox(height: Get.height * 0.01,),
                              seekerJobAlertWiseJobListingControllerInstanse
                                  .viewSeekerJobAlertWiseJobListingData.value
                                  .jobList?[index].jobsDetail?.startWorkName ==
                                  null ||
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobsDetail?.startWorkName
                                      ?.length == 0 ?
                              Text("No skills",
                                style: Get.theme.textTheme.bodyLarge!.copyWith(
                                    color: AppColors.black),) :
                              Wrap(
                                spacing: 6.0,
                                runSpacing: 6.0,
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: List.generate(
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobsDetail?.startWorkName
                                      ?.length ?? 0,
                                      (i) {
                                    return Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.homeGrey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                          seekerJobAlertWiseJobListingControllerInstanse
                                              .viewSeekerJobAlertWiseJobListingData
                                              .value.jobList?[index].jobsDetail
                                              ?.startWorkName?[i].startWork ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: Get.theme.textTheme.labelLarge!
                                              .copyWith(color: AppColors.black,
                                              fontWeight: FontWeight.w400)
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: Get.height * 0.04,),
                              Text("Availability",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: AppColors.black),
                              ),
                              SizedBox(height: Get.height * 0.01,),
                              seekerJobAlertWiseJobListingControllerInstanse
                                  .viewSeekerJobAlertWiseJobListingData.value
                                  .jobList?[index].jobsDetail?.availabityName ==
                                  null ||
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobsDetail?.availabityName
                                      ?.length == 0 ?
                              Text("No skills",
                                style: Get.theme.textTheme.labelLarge!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400),) :
                              Wrap(
                                spacing: 6.0,
                                runSpacing: 6.0,
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: List.generate(
                                  seekerJobAlertWiseJobListingControllerInstanse
                                      .viewSeekerJobAlertWiseJobListingData.value
                                      .jobList?[index].jobsDetail?.availabityName
                                      ?.length ?? 0,
                                      (i) {
                                    return Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.homeGrey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                          seekerJobAlertWiseJobListingControllerInstanse
                                              .viewSeekerJobAlertWiseJobListingData
                                              .value.jobList?[index].jobsDetail
                                              ?.availabityName?[i].availabity ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                          style: Get.theme.textTheme.labelLarge!
                                              .copyWith(color: AppColors.black,
                                              fontWeight: FontWeight.w400)
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: Get.height *.05,),
                              Center(
                                child: MyButton(title: seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].postApplied == true ? "Applied" : "Apply", onTap1: () {
                                    showReferralSubmissionDialog(context, index) ;
                                },),
                              ),
                              SizedBox(height: Get.height * 0.055,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )]),
      ));

// void showSeekerHomePagePercentageProfile(BuildContext context, dynamic data) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: AppColors.textFieldFilledColor,
//         contentPadding: EdgeInsets.zero,
//         insetPadding: const EdgeInsets.symmetric(horizontal: 20),
//         content: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   GestureDetector(
//                     onTap: () => Get.back(),
//                     child: Stack(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: AppColors.blueThemeColor,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: const Icon(
//                             Icons.close,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: Get.height * .03,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50),
//                     border: Border.all(color: AppColors.white, width: 2)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: Container(
//                       decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: AppColors.blueThemeColor),
//                       child: CircleAvatar(
//                           radius: 34,
//                           backgroundColor: Colors.transparent,
//                           child: Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text('${data?.jobMatchPercentage}%',
//                                     style: Get.theme.textTheme.bodySmall!
//                                         .copyWith(color: AppColors.white)),
//                                 Text('match',
//                                     style: Get.theme.textTheme.bodySmall!
//                                         .copyWith(
//                                         color: AppColors.white,
//                                         fontSize: 7)),
//                               ],
//                             ),
//                           ))),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * .03,
//               ),
//               Text(
//                 'Profile Match ${data?.jobMatchPercentage}%',
//                 style: Theme.of(context)
//                     .textTheme
//                     .headlineSmall
//                     ?.copyWith(fontWeight: FontWeight.w700),
//               ),
//               SizedBox(
//                 height: Get.height * .015,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Text(
//                   "According to your skills your profile is match for this job.",
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.graySilverColor,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * .05,
//               ),
//             ],
//           ),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//       );
//     },
//   );
// }

}

  Future<bool?> showReferralSubmissionDialog(BuildContext context, int index) async {
    var controller = TextEditingController();
    var _formKey = GlobalKey<FormState>();
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        applyJobController.errorMessageApplyReferral.value = "" ;
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back() ,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.blueThemeColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(52, 52, 52, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'If you have any referral code please enter',
                        style: Get.theme.textTheme.headlineSmall!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      TextFormField(
                        controller: controller,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: const Color(0xff454545),
                            hintText: "Enter Referral Code",
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                              borderSide: BorderSide(color: Color(0xff353535)),),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: const BorderSide(color: Color(0xff353535)),),
                            errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                              borderSide: BorderSide(color: Color(0xff353535)),),
                            disabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(35.0)),
                              borderSide: BorderSide(color: Color(0xff353535)),
                            ),
                            hintStyle: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: const Color(0xffCFCFCF)),
                            contentPadding: EdgeInsets.symmetric(horizontal: Get.width * .06,
                                vertical: Get.height * .027)),
                      ),
                      Obx(() =>  applyJobController.errorMessageApplyReferral.value.isEmpty ?
                      const SizedBox() :
                      Text(applyJobController.errorMessageApplyReferral.value,
                          style: const TextStyle(color: Colors.red,fontSize: 12)),),
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
                                    if (controller.text.isNotEmpty) {
                                      CommonFunctions.showLoadingDialog(context, "Applying");
                                      if (jobFilterController.reset.value) {
                                        var result = await applyJobController.applyJob(context,
                                            seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].id.toString(),
                                            referralCode: controller.text);
                                        if (result) {
                                          seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].postApplied = true;
                                          Get.back(result: true);
                                          setState(() {}) ;
                                        } else {
                                          Get.back(result: false);
                                        }
                                      } else {
                                        var result = await applyJobController.applyJob(context, jobFilterController.jobsData.value.jobs?[index].id.toString(), referralCode: controller.text);
                                        if (result) {
                                          jobFilterController.jobsData.value.jobs?[index].postApplied = true;
                                          Get.back(result: true);
                                          setState(() {}) ;
                                        } else {
                                          Get.back(result: false);
                                        }
                                      }
                                    }else{
                                      applyJobController.errorMessageApplyReferral.value = "Please enter referral code" ;
                                    }
                                  },
                                  title: 'SUBMIT',
                                  style: Get.theme.textTheme.bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
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
                                    CommonFunctions.showLoadingDialog(
                                        context, "Applying");
                                    if (jobFilterController.reset.value) {
                                      var result = await applyJobController.applyJob(context,
                                          seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].id.toString());
                                      if (result) {
                                        seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].postApplied = true;
                                        Get.back(result: true);
                                        setState(() {}) ;
                                      } else {
                                        Get.back(result: false);
                                      }
                                    } else {
                                      var result = await applyJobController.applyJob(context,
                                        jobFilterController.jobsData.value.jobs?[index].id.toString(),
                                      );
                                      if (result) {
                                        jobFilterController.jobsData.value.jobs?[index].postApplied = true;
                                        Get.back(result: true);
                                        setState(() {}) ;
                                      } else {
                                        Get.back(result: false);
                                      }
                                    }
                                  },
                                  child: Text(
                                    'NO',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.black),
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
