import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flikka/Job%20Seeker/SeekerHome/JobSearchScreen.dart';
import 'package:flikka/controllers/SeekerJobFilterController/SeekerJobFilterController.dart';
import 'package:flikka/controllers/SeekerSavedJobsController/SeekerSavedJobsController.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/CommonWidgets.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Job Recruiter/recruiter_profile/recruiter_profile_tabbar.dart';
import '../../chatseeker/CreateChat.dart';
import '../../controllers/ApplyJobController/ApplyJobController.dart';
import '../../controllers/GetJobsListingController/GetJobsListingController.dart';
import '../../controllers/JobAlertSeenUnseenJobController/JobAlertSeenUnseenJobController.dart';
import '../../controllers/JobAlertWiseJobListingController/JobAlertWiseJobListingController.dart';
import '../../controllers/SeekerUnSavePostController/SeekerUnSavePostController.dart';
import '../../models/GetJobsListingModel/GetJobsListingModel.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../utils/VideoPlayerScreen.dart';
import '../../widgets/google_map_widget.dart';
import '../SeekerBottomNavigationBar/TabBarController.dart';
import '../SeekerDrawer/Drawer_page.dart';
import '../SeekerJobs/no_job_available.dart';
import 'package:get/get.dart';



class JobViewJobAlert extends StatefulWidget {
  const JobViewJobAlert({super.key});

  @override
  State<JobViewJobAlert> createState() => JobViewJobAlertState();
}

class JobViewJobAlertState extends State<JobViewJobAlert> {

  var years = '';
  var months = '';

  static int currentPage = 0;

  var position = 0.0.obs  ;

  SeekerJobAlertWiseJobListingController seekerJobAlertWiseJobListingControllerInstanse = Get.put(SeekerJobAlertWiseJobListingController()) ;


  TabBarController tabBarController = Get.put(TabBarController());
  GetJobsListingController getJobsListingController = Get.put(GetJobsListingController());
  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController());
  SeekerSaveJobController seekerSaveJobController = Get.put(SeekerSaveJobController());
  ApplyJobController applyJobController = Get.put(ApplyJobController());
  SeekerUnSavePostController unSavePostController = Get.put(SeekerUnSavePostController());
  GetJobsListingModel jobModel = GetJobsListingModel();

  Completer<GoogleMapController> mapController = Completer();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (getJobsListingController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (getJobsListingController.error.value == 'No internet') {
            return Scaffold(
              body: InterNetExceptionWidget(
                onPress: () {
                  getJobsListingController.seekerGetAllJobsApi();
                },
              ),
            );
          } else {
            return Scaffold(
              body: GeneralExceptionWidget(onPress: () {
                getJobsListingController.seekerGetAllJobsApi();
              }),
            );
          }
        case Status.COMPLETED:
          return Obx(() {
            switch (seekerProfileController.rxRequestStatus.value) {
              case Status.LOADING:
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case Status.ERROR:
                if (seekerProfileController.error.value == 'No internet') {
                  return Scaffold(
                    body: InterNetExceptionWidget(
                      onPress: () {
                        seekerProfileController.viewSeekerProfileApi();
                      },
                    ),
                  );
                } else {
                  return Scaffold(
                    body: GeneralExceptionWidget(onPress: () {
                      seekerProfileController.viewSeekerProfileApi();
                    }),
                  );
                }
              case Status.COMPLETED:
                return Scaffold(
                  backgroundColor: AppColors.white,
                  // extendBody: true,
                  // extendBodyBehindAppBar: true,
                  body: Obx(() {
                    return Stack(
                      children: [
                        PageView.builder(
                          // controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: getJobsListingController.getJobsListing.value.jobs?.length,
                          itemBuilder: (context, index) {
                            if( seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].workExperience != null &&  seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].workExperience.toString().length != 0) {
                              var experience = seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].workExperience.toString().split(".");
                              if(experience?.length == 2) {
                                if( experience?[0] != null && experience?[0].length != 0 && experience?[0].toString() != "0") {
                                  years = "${experience?[0]} year";
                                }
                                if( experience?[1] != null && experience?[1].length != 0 && experience?[1].toString() != "00") {
                                  months = "${experience?[1]} month";
                                }
                              }
                            }
                            return SingleChildScrollView(
                              // controller: _scrollController,
                              physics: const BouncingScrollPhysics(),
                              clipBehavior: Clip.hardEdge,
                              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(children: [
                                    CachedNetworkImage(imageUrl: seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].featureImg ?? "" ,
                                      placeholder: (context, url) => SizedBox( height: Get.height,
                                        child: const Center(child: CircularProgressIndicator()),),
                                      imageBuilder: (context, imageProvider) => Container(
                                        height: MediaQuery.of(context).size.height,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider ,
                                            fit: BoxFit.cover,
                                          ),),
                                      ),),
                                    Positioned(
                                      right: 10,
                                      top: Get.height * 0.16,
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap:
                                                () {
                                              showSeekerHomePagePercentageProfile(context, getJobsListingController.getJobsListing.value.jobs?[index]);
                                            },
                                            child:
                                            Container(
                                              padding: const EdgeInsets.all(4.0) ,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.transparent,
                                                  border: Border.all(color: AppColors.white, width: 2)),
                                              child:
                                              Stack(
                                                children: [
                                                  Container(
                                                      padding: const EdgeInsets.all(4.0) ,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: AppColors.blueThemeColor,
                                                          border: Border.all(color: AppColors.white, width: 2)),
                                                      child: SizedBox(
                                                        height: 70,
                                                        width : 70 ,
                                                        child: CircularProgressIndicator(
                                                          value: getJobsListingController.getJobsListing.value.jobs?[index].jobMatchPercentage / 100,
                                                          backgroundColor: AppColors.white,
                                                          color: AppColors.green,
                                                          strokeWidth: 12,
                                                        ),
                                                      )
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets.all(4.0),
                                                    height: 70,
                                                    width : 70 ,
                                                    alignment: Alignment.center,
                                                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('${getJobsListingController.getJobsListing.value.jobs?[index].jobMatchPercentage}%',
                                                            style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white)),
                                                        Text('match',
                                                            style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white, fontSize: 7)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                                    message: getJobsListingController.getJobsListing.value.jobs?[index].postSaved ? "Do you want to remove the\n post from saved posts" : "Do you want to save the post",
                                                    onTap: () async {
                                                      Get.back();
                                                      if (getJobsListingController.getJobsListing.value.jobs?[index].postSaved == true) {
                                                        CommonFunctions.showLoadingDialog(context, "removing...");
                                                        var result = await unSavePostController.unSavePost(getJobsListingController.getJobsListing.value.jobs?[index].id.toString(), "1", context, true);
                                                        if (result == true) {
                                                          if (kDebugMode) {
                                                            print("inside result");
                                                          }
                                                          getJobsListingController.getJobsListing.value.jobs?[index].postSaved = false;
                                                          setState(() {});
                                                        }
                                                      } else {
                                                        CommonFunctions.showLoadingDialog(context, "Saving");
                                                        var result = await seekerSaveJobController.saveJobApi(getJobsListingController.getJobsListing.value.jobs?[index].id, 1);
                                                        if (result == true) {
                                                          if (kDebugMode) {
                                                            print("inside result");
                                                          }
                                                          getJobsListingController.getJobsListing.value.jobs?[index].postSaved = true;
                                                          setState(() {});
                                                        }
                                                      }
                                                    });
                                              },
                                              child: getJobsListingController.getJobsListing.value.jobs?[index].postSaved == false
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
                                              if (getJobsListingController.getJobsListing.value.jobs?[index].video == null ||
                                                  getJobsListingController.getJobsListing.value.jobs?[index].video?.length == 0) {
                                                Utils.showMessageDialog(context, "video not uploaded yet");
                                              } else {
                                                Get.back();
                                                Get.to(() =>
                                                    VideoPlayerScreen(videoPath: getJobsListingController.getJobsListing.value.jobs?[index]?.video ?? ""));}
                                            },
                                            child:
                                            Container(alignment: Alignment.center,
                                              height: 50, width: 50,
                                              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.blueThemeColor),
                                              child: Image.asset("assets/images/icon_video.png",
                                                height: 18, fit: BoxFit.cover,),
                                            ),),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: Get.height * .23 - position.value ,
                                      left: 12,
                                      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth: Get.width*.8,
                                            ),
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xff0D5AFE).withOpacity(.6),
                                                  borderRadius: BorderRadius.circular(22)
                                              ),
                                              child:  Text("job position",
                                                // getJobsListingController.getJobsListing.value.jobs?[currentPage].jobPositions ?? "No job position",
                                                overflow: TextOverflow.ellipsis,
                                                style: Get.theme.textTheme.displaySmall!.copyWith(color: AppColors.white),),
                                            ),
                                          ),
                                          const SizedBox(height: 10,) ,
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(() =>  RecruiterProfileTabBar(recruiterID: getJobsListingController.getJobsListing.value.jobs?[currentPage].recruiterDetails?.recruiterId.toString(),isSeeker: true,) ,);
                                                },
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                      maxWidth: Get.width * .5
                                                  ),
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: const Color(0xff0D5AFE).withOpacity(.6),
                                                      borderRadius: BorderRadius.circular(22)),
                                                  child: Text("company name",
                                                    // getJobsListingController.getJobsListing.value.jobs?[currentPage].recruiterDetails?.companyName ?? "No company name",
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10,),
                                              Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: const Color(0xff0D5AFE).withOpacity(.6),
                                                    borderRadius: BorderRadius.circular(22)),
                                                child: Text(
                                                  "Salary",
                                                  // "${getJobsListingController.getJobsListing.value.jobs?[currentPage].jobsDetail?.minSalaryExpectation} - "
                                                  //     "${getJobsListingController.getJobsListing.value.jobs?[currentPage].jobsDetail?.maxSalaryExpectation}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white,
                                                      fontSize: 12, fontWeight: FontWeight.w600),),
                                              ),
                                            ],),
                                          const SizedBox(height: 10,) ,
                                          Row(
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(maxWidth: Get.width * .5),
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(color: const Color(0xff0D5AFE).withOpacity(.6),
                                                    borderRadius: BorderRadius.circular(22)),
                                                child: Text("Location",
                                                  // getJobsListingController.getJobsListing.value.jobs?[currentPage].jobLocation ?? "No job location",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Get.theme.textTheme.bodyLarge!.copyWith(
                                                      color: AppColors.white, fontSize: 12, fontWeight: FontWeight.w600),),
                                              ),
                                              const SizedBox(width: 10,),
                                              CountryFlag.fromCountryCode(  getJobsListingController.getJobsListing.value.jobs?[currentPage].countryCode ?? "GB",
                                                height: 40, width: 40,
                                                // borderRadius: 20,
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 10,) ,
                                        ],),
                                    ),
                                  ],),
                                  SizedBox(height: Get.height * 0.025,),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: Get.height*.03,) ,
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.asset("assets/images/icon_job_description.png",height: 20,width: 20,),
                                            SizedBox(width: Get.width*.02,) ,
                                            Text("Job Description",
                                              style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.black),),
                                          ],
                                        ),
                                        CommonWidgets.divider() ,
                                        seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].description == null || CommonFunctions.parseHTML(seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].description).toString().trim().length == 0 ?
                                        Text("No job description",style: Theme.of(context).textTheme.labelLarge!
                                            .copyWith(color: AppColors.black,fontWeight: FontWeight.w400),) :
                                        HtmlWidget(seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].description ?? 'No job description',textStyle:Get.theme.textTheme.labelLarge!.copyWith(color: AppColors.silverColor,fontWeight: FontWeight.w400) ,),
                                        SizedBox(height: Get.height * 0.03,),
                                        Row(
                                          children: [
                                            Image.asset("assets/images/icon_requirment.png",height: Get.height*.03,),
                                            SizedBox(width: Get.width*.02,) ,
                                            Text("Requirements", style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.black),),
                                          ],
                                        ),
                                        CommonWidgets.divider() ,
                                        seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].requirements == null || CommonFunctions.parseHTML(seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].description).toString().trim().length == 0 ?
                                        Text("No requirements",style: Theme.of(context).textTheme.labelLarge!
                                            .copyWith(color: AppColors.black,fontWeight: FontWeight.w400),) :
                                        HtmlWidget(seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].requirements ?? 'No requirements',textStyle: Get.theme.textTheme.labelLarge!.copyWith(color: AppColors.silverColor,fontWeight: FontWeight.w400),),
                                        SizedBox(height: Get.height * 0.025,),
                                        Row(
                                          children: [
                                            Image.asset("assets/images/icon_location_seeker.png",height: 20,width: 20,),
                                            SizedBox(width: Get.width*.02,) ,
                                            Text("Location", style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.black),),
                                          ],
                                        ),
                                        CommonWidgets.divider() ,
                                        // SizedBox(height: Get.height * 0.015,),
                                        Text(seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].jobLocation ?? "No job location",overflow: TextOverflow.ellipsis, style: Get.theme.textTheme.labelLarge!.copyWith(color: AppColors.silverColor,fontWeight: FontWeight.w400),),
                                        SizedBox(height: Get.height * 0.015,),
                                        SizedBox( height: 300,
                                          child: GoogleMap(
                                            initialCameraPosition: CameraPosition(
                                              target: LatLng(double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].lat}")!, double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].long}")!),
                                              zoom: 12,
                                            ),
                                            markers: <Marker>{
                                              Marker(
                                                markerId: const MarkerId("1"),
                                                position: LatLng(double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].lat}")!, double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].long}")!),
                                                infoWindow: const InfoWindow(
                                                  title: "Job Location",
                                                ),
                                              ),
                                            },
                                            mapType: MapType.normal,
                                            myLocationEnabled: true,
                                            compassEnabled: true,
                                            zoomControlsEnabled: false,
                                            onLongPress: (argument) => Get.to( GoogleMapIntegration(jobPageView: true,lat: double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].lat}")!,long:  double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].long}")!)),
                                            onMapCreated: (GoogleMapController controller) {
                                              mapController.complete(controller);
                                              if (kDebugMode) {
                                                print("inside 1") ;
                                              }
                                            },
                                          ),
                                          // GoogleMapIntegration(jobPageView: true,lat: double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].lat}"),long:  double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].long}"),)
                                        ),
                                        const SizedBox(height: 30,),
                                        Row(
                                          children: [
                                            Image.asset("assets/images/icon_information.png",height: 20,width: 20,),
                                            SizedBox(width: Get.width*.02,) ,
                                            Text("Information", style:Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.black),),
                                          ],
                                        ),
                                        CommonWidgets.divider(),
                                        // SizedBox(height: Get.height * 0.015,),
                                        Text("Position", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
                                        SizedBox(height: Get.height * 0.015,),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: AppColors.homeGrey,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Text(seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].jobPositions ?? "No position",
                                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400),),
                                        ),
                                        // const Divider(color: Colors.grey, thickness: 0.2,),
                                        const  SizedBox(height: 25,) ,
                                        Text("Qualification",
                                          style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
                                        SizedBox(height: Get.height * 0.015,),
                                        seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].education.toString().toLowerCase() == "null" ||
                                            seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].education.toString().length == 0
                                            ? Text("No qualification", style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: AppColors.homeGrey,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Text(
                                            seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].education ?? "",
                                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        const  SizedBox(height: 25,) ,
                                        Text("Experience",
                                          style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
                                        SizedBox(height: Get.height * 0.015,),
                                        Container(  padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: AppColors.homeGrey,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: years.toString().length == 0 && months.toString().length == 0 ? Text("No experience", style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black)) :
                                          Text("${years ?? ""} ${ months ?? ""}", style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        const  SizedBox(height: 25,) ,
                                        Text("Job Type", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
                                        SizedBox(height: Get.height * 0.015,),
                                        Container( padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: AppColors.homeGrey,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Text(seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].employmentType ?? "No job type",
                                            style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400),),
                                        ),
                                        const  SizedBox(height: 25,) ,
                                        // const Divider(color: Colors.grey, thickness: 0.2,),
                                        Text("Specialization", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
                                        SizedBox(height: Get.height * 0.015,),
                                        Container( padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: AppColors.homeGrey,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Text(seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].specialization ?? "No specialization",
                                            style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400),),
                                        ),
                                        const  SizedBox(height: 25,) ,
                                        // const Divider(color: Colors.grey, thickness: 0.2,),
                                        Text("Type of workplace",
                                          style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
                                        SizedBox(height: Get.height * 0.015,),
                                        Container( padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: AppColors.homeGrey,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Text(seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].typeOfWorkplace ?? "No workplace",
                                            style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400),),
                                        ),
                                        const  SizedBox(height: 25,) ,
                                        // const Divider(color: Colors.grey, thickness: 0.2,),
                                        Text("Preferred work experience",
                                          style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),
                                        ),
                                        SizedBox(height: Get.height * 0.015,),
                                        Container( padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: AppColors.homeGrey,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Text(
                                            seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].preferredWorkExperience ?? "No preferred work experience",
                                            style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        const  SizedBox(height: 25,) ,
                                        Text("Language", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
                                        SizedBox(height: Get.height * 0.015,),
                                        getJobsListingController.getJobsListing.value.jobs?[index].languageName == null || getJobsListingController.getJobsListing.value.jobs?[index].languageName?.length == 0 ?
                                        Text("No language", style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
                                        Column( crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            for(int i = 0 ; i < getJobsListingController.getJobsListing.value.jobs![index].languageName!.length  ; i++ )
                                              Container( padding: const EdgeInsets.all(8),
                                                margin: const EdgeInsets.only(bottom: 8),
                                                decoration: BoxDecoration(
                                                    color: AppColors.homeGrey,
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Text(getJobsListingController.getJobsListing.value.jobs?[index].languageName?[i].languages ?? "",
                                                  style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400),
                                                ),),
                                          ],),
                                        SizedBox(height: Get.height * .02,),
                                        Row(
                                          children: [
                                            Image.asset("assets/images/skillsvg.png",height: 20,width: 20,),
                                            SizedBox(width: Get.width*.02,) ,
                                            Text("Skills", style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.black),),
                                          ],
                                        ),
                                        CommonWidgets.divider(),
                                        Text("Soft Skills",
                                          style: Theme.of(context).textTheme.labelMedium!
                                              .copyWith(color: AppColors.black),
                                        ),
                                        SizedBox(height: Get.height*0.01,),
                                        seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].jobsDetail?.skillName == null ||
                                            seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].jobsDetail?.skillName?.length == 0 ?
                                        Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
                                        Wrap(
                                          spacing: 6.0,
                                          runSpacing: 6.0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment: WrapCrossAlignment.start,
                                          children: List.generate(
                                            seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].jobsDetail?.skillName?.length ?? 0,
                                                (i) {
                                              return Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: AppColors.homeGrey,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                    seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].jobsDetail?.skillName?[i].skills ?? "",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: Get.theme.textTheme.labelLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400)
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(height: Get.height*0.04,),
                                        Text("Passion",
                                          style: Theme.of(context).textTheme.labelMedium!
                                              .copyWith(color: AppColors.black),
                                        ),
                                        SizedBox(height: Get.height*0.01,),
                                        seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].jobsDetail?.passionName == null ||
                                            seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].jobsDetail?.passionName?.length == 0 ?
                                        Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
                                        Wrap(
                                          spacing: 6.0,
                                          runSpacing: 6.0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment: WrapCrossAlignment.start,
                                          children: List.generate(
                                            seekerJobAlertWiseJobListingControllerInstanse.viewSeekerJobAlertWiseJobListingData.value.jobList?[index].jobsDetail?.passionName?.length ?? 0,
                                                (i) {
                                              return Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: AppColors.homeGrey,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                    getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.passionName?[i].passion ?? "",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: Get.theme.textTheme.labelLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400)
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(height: Get.height * 0.04,),
                                        Text(
                                          "industry preference",
                                          style: Theme.of(context).textTheme.labelMedium!
                                              .copyWith(color: AppColors.black),
                                        ),
                                        SizedBox(height: Get.height*0.01,),
                                        getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.industryPreferenceName == null ||
                                            getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.industryPreferenceName?.length == 0 ?
                                        Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
                                        Wrap(
                                          spacing: 6.0,
                                          runSpacing: 6.0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment: WrapCrossAlignment.start,
                                          children: List.generate(
                                            getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.industryPreferenceName?.length ?? 0,
                                                (i) {
                                              return Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: AppColors.homeGrey,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                    getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.industryPreferenceName?[i].industryPreferences ?? "",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: Get.theme.textTheme.labelLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400)
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(height: Get.height * 0.04,),
                                        Text("Strengths",
                                          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.black),),
                                        SizedBox(height: Get.height*0.01,),
                                        getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.strengthsName == null ||
                                            getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.strengthsName?.length == 0 ?
                                        Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
                                        Wrap(
                                          spacing: 6.0,
                                          runSpacing: 6.0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment: WrapCrossAlignment.start,
                                          children: List.generate(
                                            getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.strengthsName?.length ?? 0,
                                                (i) {
                                              return Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: AppColors.homeGrey,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                    getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.strengthsName?[i].strengths ?? "",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: Get.theme.textTheme.labelLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400)
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(height: Get.height * 0.04,),
                                        Text("Salary expectation",
                                          style: Theme.of(context).textTheme.labelMedium!
                                              .copyWith(color: AppColors.black),
                                        ),
                                        SizedBox(height: Get.height*0.01,),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: AppColors.homeGrey,
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                          child: Text(
                                            '${getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.minSalaryExpectation ?? ''} - ${getJobsListingController.getJobsListing.value.jobs?[index]?.jobsDetail?.maxSalaryExpectation ?? 'No salary expectation'} ',
                                            style: Get.theme.textTheme.labelLarge!.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: Get.height * 0.04,),
                                        Text("When can i start working?",
                                          style: Theme.of(context).textTheme.labelMedium!
                                              .copyWith(color: AppColors.black),
                                        ),
                                        SizedBox(height: Get.height*0.01,),
                                        getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.startWorkName == null ||
                                            getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.startWorkName?.length == 0 ?
                                        Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
                                        Wrap(
                                          spacing: 6.0,
                                          runSpacing: 6.0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment: WrapCrossAlignment.start,
                                          children: List.generate(
                                            getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.startWorkName?.length ?? 0,
                                                (i) {
                                              return Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: AppColors.homeGrey,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                    getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.startWorkName?[i].startWork ?? "",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: Get.theme.textTheme.labelLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400)
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(height: Get.height * 0.04,),
                                        Text("Availability",
                                          style: Theme.of(context).textTheme.labelMedium!
                                              .copyWith(color: AppColors.black),
                                        ),
                                        SizedBox(height: Get.height * 0.01,),
                                        getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.availabityName == null ||
                                            getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.availabityName?.length == 0 ?
                                        Text("No skills", style:Get.theme.textTheme.labelLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400),) :
                                        Wrap(
                                          spacing: 6.0,
                                          runSpacing: 6.0,
                                          alignment: WrapAlignment.start,
                                          crossAxisAlignment: WrapCrossAlignment.start,
                                          children: List.generate(
                                            getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.availabityName?.length ?? 0,
                                                (i) {
                                              return Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: AppColors.homeGrey,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                    getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.availabityName?[i].availabity ?? "",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: Get.theme.textTheme.labelLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.w400)
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(height: Get.height * 0.055,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }),
                );
            }
          });
      }
    });
  }


  void showSeekerHomePagePercentageProfile(BuildContext context, dynamic data) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.textFieldFilledColor,
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                SizedBox(
                  height: Get.height * .03,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColors.white, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.blueThemeColor),
                        child: CircleAvatar(
                            radius: 34,
                            backgroundColor: Colors.transparent,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${data?.jobMatchPercentage}%',
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(color: AppColors.white)),
                                  Text('match',
                                      style: Get.theme.textTheme.bodySmall!
                                          .copyWith(
                                          color: AppColors.white,
                                          fontSize: 7)),
                                ],
                              ),
                            ))),
                  ),
                ),
                SizedBox(
                  height: Get.height * .03,
                ),
                Text(
                  'Profile Match ${data?.jobMatchPercentage}%',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: Get.height * .015,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "According to your skills your profile is match for this job.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.graySilverColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * .05,
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
