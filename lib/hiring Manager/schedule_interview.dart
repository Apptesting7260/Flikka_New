
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Recruiter/Schedule_meeting_calendar/meeting_calendar.dart';
import 'package:flikka/controllers/CandidateJobStatusController/CandidateJobStatusController.dart';
import 'package:flikka/controllers/ViewParticularCandidateController/ViewParticularCandidateController.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../ChatRecruter/CreateFuction.dart';
import '../controllers/AddToTalentPoolController/AddToTalentPoolController.dart';
import '../controllers/RecruiterHomeController/RecruiterHomeController.dart';
import '../data/response/status.dart';
import '../res/components/general_expection.dart';
import '../res/components/internet_exception_widget.dart';
import '../res/components/request_timeout_widget.dart';
import '../res/components/unauthorised_request_widget.dart';
import '../utils/CommonWidgets.dart';
import '../utils/VideoPlayerScreen.dart';

bool isMeetingScheduled = false;
class ScheduleInterview extends StatefulWidget {
 final String seekerID ; final String requestID ; final bool? talentPool ; final String? status ;
 final bool scheduleInterview;
  const ScheduleInterview({Key? key, required this.seekerID, required this.requestID, this.talentPool, this.status, required this.scheduleInterview}) : super(key: key);

  @override
  State<ScheduleInterview> createState() => _ScheduleInterviewState();
}

class _ScheduleInterviewState extends State<ScheduleInterview> {

  bool isButtonVisible = true;

  RecruiterHomeController homeController = Get.put(RecruiterHomeController()) ;
  Createchatrecruter Ctreatechatinstance = Createchatrecruter();

  ViewParticularCandidateController candidateController = Get.put(ViewParticularCandidateController()) ;
  CandidateJobStatusController statusController = Get.put(CandidateJobStatusController()) ;
  // var index ;

  //////refresh//////
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
     candidateController.viewCandidateApi(widget.seekerID);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
     candidateController.viewCandidateApi(widget.seekerID);
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  /////refresh/////

  AddToTalentPoolController poolController = Get.put(AddToTalentPoolController()) ;

  @override
  void initState() {
    candidateController.viewCandidateApi(widget.seekerID) ;
    super.initState();
  }

  String uri = '';
  bool isWork = false;
  bool isEducation = false;
  bool isAppreciation = false;
  bool isResume = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueThemeColor,
        toolbarHeight: 75,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset('assets/images/backiconsvg.svg')),
        ),
        elevation: 0,
        title:  Text(candidateController.candidateData.value.seekerDetails?.fullname ?? "",
              style: Get.theme.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w700)),
      ),
      body: Obx(() {
        switch (candidateController.rxRequestStatus.value) {
          case Status.LOADING:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),);
          case Status.ERROR:
            if (candidateController.error.value ==
                'No internet') {
              return Scaffold(
                body: InterNetExceptionWidget(
                  onPress: () {
                    candidateController.viewCandidateApi(widget.seekerID);
                  },
                ),);
            } else if (candidateController.error.value == 'Request Time out') {
              return Scaffold(body: RequestTimeoutWidget(onPress: () {
                candidateController.viewCandidateApi(widget.seekerID);
              }),);
            } else
            if (candidateController.error.value == "Unauthorised Request") {
              return Scaffold(body: UnauthorisedRequestWidget(onPress: () {
                candidateController.viewCandidateApi(widget.seekerID);
              }),);
            } else {
              return Scaffold(body: GeneralExceptionWidget(onPress: () {
                candidateController.viewCandidateApi(widget.seekerID);
              }),);
            }
          case Status.COMPLETED:
            return SmartRefresher(
              controller: _refreshController,
              onLoading: _onLoading,
              onRefresh: _onRefresh,
              child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: AppColors.blueThemeColor
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14.0, ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 24.0),
                            //   child: Row(
                            //     children: [
                            //       InkWell(
                            //           onTap: () {
                            //             Get.back();
                            //           },
                            //           child: SvgPicture.asset(
                            //               'assets/images/backiconsvg.svg')),
                            //       SizedBox(width: Get.width * 0.035,),
                            //       Text(candidateController.candidateData.value.seekerDetails?.fullname ?? "",
                            //           style: Get.theme.textTheme.headlineSmall!
                            //               .copyWith(fontWeight: FontWeight.w700)),
                            //
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: Get.height * 0.0200,),
                            Column(
                              children: [
                                Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 48,
                                        child: CachedNetworkImage(
                                          imageUrl: candidateController.candidateData.value.seekerDetails?.profileImg ?? '',
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
                                        // backgroundImage: NetworkImage(candidateController.candidateData.value.seekerDetails?.profileImg ?? ''),
                                      ),
                                    ]
                                )
                              ],
                            ),
                            SizedBox(height: Get.height * 0.015,),
                            Text(candidateController.candidateData.value.seekerDetails?.fullname ?? "No data",
                                style: Get.theme.textTheme.displayLarge),
                            SizedBox(height: Get.height * 0.005,),
                            Text(candidateController.candidateData.value.seekerDetails?.seekerData?.positions ?? "No positions",
                                style: Get.theme.textTheme.bodyLarge!.copyWith(
                                    color: AppColors.white)),
                            SizedBox(height: Get.height * 0.005,),
                            Text(candidateController.candidateData.value.seekerDetails?.location ?? "No location", style: Get
                                .theme.textTheme.bodyLarge!.copyWith(
                                color: AppColors.white)),
                            SizedBox(height: Get.height * 0.021,),
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.white),
                                    child: Row(
                                      children: [
                                             InkWell(
                                               onTap: () {
                                                 SeekerIDchat = candidateController.candidateData.value.seekerDetails?.seekerData?.seekerId.toString() ;
                                                 Seekerimgchat = candidateController.candidateData.value.seekerDetails?.profileImg.toString();
                                                 SeekerName = candidateController.candidateData.value.seekerDetails?.fullname.toString();
                                                 setState(() {
                                                   SeekerIDchat;
                                                   Seekerimgchat;
                                                   SeekerName;
                                                 });

                                                 if (kDebugMode) {
                                                   print(SeekerIDchat);
                                                   print(Seekerimgchat);
                                                   print(SeekerName);
                                                 }

                                                 Timer(const Duration(seconds: 2), () {
                                                   if(SeekerIDchat.toString()!="null"&&Seekerimgchat.toString()!="null"&&SeekerName.toString()!="null"){
                                                     Ctreatechatinstance.CreateChat();
                                                   }

                                                 });
                                               },
                                               child: Image.asset(
                                                  'assets/images/icon_msg.png',height: Get.height*.06),
                                             ),
                                      ],
                                    )),
                                SizedBox(
                                  width: Get.width * 0.045,
                                ),
                                if (candidateController.candidateData.value.seekerDetails?.mobile == null ||
                                    candidateController.candidateData.value.seekerDetails?.mobile.toString().length == 0) const SizedBox() else Row(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: AppColors.white),
                                        child:
                                            GestureDetector(
                                              onTap: () {
                                                if (kDebugMode) {
                                                  print("tapped") ;
                                                }
                                                CommonFunctions.launchDialer("${candidateController.candidateData.value.seekerDetails?.mobile}") ;
                                              },
                                              child: Image.asset(
                                                'assets/images/icon_call.png',
                                                height: Get.height*.06,
                                              ),
                                            )),
                                    SizedBox(
                                      width: Get.width * 0.045,
                                    ),
                                  ],
                                ),

                                    GestureDetector(
                                  onTap: () {
                                    if(  candidateController.candidateData.value.seekerDetails?.video == null ||
                                        candidateController.candidateData.value.seekerDetails?.video.toString().length == 0 ) {
                                      Utils.showMessageDialog(context, "video not uploaded yet") ;
                                    }
                                    else{
                                    Get.back() ;
                                      Get.to(() => VideoPlayerScreen(videoPath: candidateController.candidateData.value.seekerDetails?.video ?? "")) ;
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 45,
                                    width: 45,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.white
                                    ),
                                    child: Image.asset(
                                      "assets/images/icon_video.png",color: AppColors.blueThemeColor,
                                      height: Get.height*.03,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height * 0.035,),
                            candidateController.candidateData.value.seekerDetails?.seekerData?.startWorkName == null ||
                                candidateController.candidateData.value.seekerDetails?.seekerData?.startWorkName?.length == 0 ?
                                const SizedBox() :
                            SizedBox(
                              height: Get.height * 0.072,
                              width: Get.width * 0.69,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(35)
                                    )
                                ),
                                onPressed: () {}, child: Text(candidateController.candidateData.value.seekerDetails?.seekerData?.startWorkName?[0].startWork ?? '',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w700,),
                              ),),
                            )
                          ],
                        ),
                      ),
                    ),
                    //************** scrollable functionality *******************
                    DraggableScrollableSheet(
                      initialChildSize: candidateController.candidateData.value.seekerDetails?.seekerData?.startWorkName == null || candidateController.candidateData.value.seekerDetails?.seekerData?.startWorkName?.length == 0 ? 0.52 : 0.42, // half screen
                      minChildSize:candidateController.candidateData.value.seekerDetails?.seekerData?.startWorkName == null || candidateController.candidateData.value.seekerDetails?.seekerData?.startWorkName?.length == 0 ? 0.52 : 0.42, // half screen
                      maxChildSize: 1, // full screen
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(35),
                                topLeft: Radius.circular(35),
                              ),

                            ),
                            child: ListView(
                              controller: scrollController,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: const BoxDecoration(
                                        color: AppColors.black,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25))
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            InkWell(
                                                child: Image.asset(
                                                  'assets/images/about.png',
                                                  height: Get.height * .04,)),
                                            SizedBox(width: Get.width * 0.02,),
                                            Text("About",
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .titleSmall,
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.015,),
                                        const Divider(thickness: 0.2,
                                          color: AppColors.white,),
                                        SizedBox(height: Get.height * 0.02,),
                                        HtmlWidget(candidateController.candidateData.value.seekerDetails?.aboutMe ?? "No about",textStyle: Theme
                                            .of(context).textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),),
                                        //********************* for work ex ***************************
                                        SizedBox(height: Get.height * 0.04,),
                                        Row(mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            InkWell(
                                                child: Image.asset(
                                                  'assets/images/icon work experience.png',
                                                  height: Get.height * .04,)),
                                            SizedBox(width: Get.width * 0.02,),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0),
                                              child: Text('Work experience',
                                                style: Get.theme.textTheme
                                                    .titleSmall!.copyWith(
                                                    color: AppColors.white),),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02,),
                                        const Divider(thickness: 0.2,
                                          color: AppColors.white,),
                                        SizedBox(height: Get.height * 0.02,),
                                        candidateController.candidateData.value.seekerDetails?.seekerData?.workExpJob == null ||
                                            candidateController.candidateData.value.seekerDetails?.seekerData?.workExpJob?.length == 0 ?
                                        Text("No work experience", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                        ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: candidateController.candidateData.value.seekerDetails?.seekerData?.workExpJob?.length,
                                            itemBuilder: (context, index) {
                                              var data = candidateController.candidateData.value.seekerDetails?.seekerData?.workExpJob?[index];
                                              var endDate ;
                                              var startDate ;
                                              startDate = DateTime.parse("${data?.jobStartDate}") ;
                                              startDate = "${startDate.month.toString().padLeft(2,"0")}-${startDate.day.toString().padLeft(2,"0")}-${startDate.year.toString().padLeft(4,"0")}" ;
                                              if(data?.present == true) {
                                                endDate = "Present" ;
                                              }else {
                                                endDate = DateTime.parse("${data?.jobEndDate}") ;
                                                endDate = "${endDate.month.toString().padLeft(2,"0")}-${endDate.day.toString().padLeft(2,"0")}-${endDate.year.toString().padLeft(4,"0")}" ;
                                              }
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(data?.workExpJob ?? "",
                                                    style: Get.theme.textTheme
                                                        .bodyMedium!.copyWith(
                                                        color: AppColors.white,
                                                        fontWeight: FontWeight
                                                            .w700),),
                                                  // SizedBox(
                                                  //   height: Get.height * 0.01,),
                                                  Text(data?.companyName ?? "",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                        color: AppColors
                                                            .ratingcommenttextcolor,
                                                        fontWeight: FontWeight
                                                            .w400),
                                                  ),
                                                  Text("$startDate  -  $endDate",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                        color: AppColors
                                                            .ratingcommenttextcolor,
                                                        fontWeight: FontWeight
                                                            .w400),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.01,),
                                                ],
                                              );
                                            }
                                        ),

                                        //********************* for Education ***************************
                                        SizedBox(height: Get.height * 0.03,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                InkWell(
                                                    child: Image.asset(
                                                      'assets/images/icon education.png',
                                                      height: Get.height * .05,)),
                                                SizedBox(
                                                  width: Get.width * 0.02,),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 6.0),
                                                  child: Text('Education',
                                                    style: Get.theme.textTheme
                                                        .titleSmall!.copyWith(
                                                        color: AppColors.white),),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02,),
                                        const Divider(thickness: 0.2,
                                          color: AppColors.white,),
                                        SizedBox(height: Get.height * 0.02,),
                                        candidateController.candidateData.value.seekerDetails?.seekerData?.educationLevel == null ||
                                            candidateController.candidateData.value.seekerDetails?.seekerData?.educationLevel?.length == 0 ?
                                        Text("No education", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                        ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: candidateController.candidateData.value.seekerDetails?.seekerData?.educationLevel?.length,
                                            itemBuilder: (context, index) {
                                              var data = candidateController.candidateData.value.seekerDetails?.seekerData?.educationLevel?[index];
                                              var endDate ;
                                              var startDate ;
                                              startDate = DateTime.parse("${data?.educationStartDate}") ;
                                              startDate = "${startDate.month.toString().padLeft(2,"0")}-${startDate.day.toString().padLeft(2,"0")}-${startDate.year.toString().padLeft(4,"0")}" ;
                                              if(data?.present == true) {
                                                endDate = "Present" ;
                                              } else {
                                                endDate = DateTime.parse("${data?.educationEndDate}") ;
                                                endDate = "${endDate.month.toString().padLeft(2,'0')}-${endDate.day.toString().padLeft(2,'0')}-${endDate.year.toString().padLeft(4,'0')}" ;
                                              }
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(data?.educationLevel ?? "",
                                                    style: Get.theme.textTheme
                                                        .bodyMedium!.copyWith(
                                                        color: AppColors.white,
                                                        fontWeight: FontWeight
                                                            .w700),),
                                                  // SizedBox(
                                                  //   height: Get.height * 0.01,),
                                                  Text(
                                                    data?.institutionName ?? "",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                        color: AppColors
                                                            .ratingcommenttextcolor,
                                                        fontWeight: FontWeight
                                                            .w400),
                                                  ),
                                                  Text("$startDate  -  $endDate",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                        color: AppColors
                                                            .ratingcommenttextcolor,
                                                        fontWeight: FontWeight
                                                            .w400),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.01,),
                                                ],
                                              );
                                            }
                                        ),
                                        //********************* for Skill ***************************
                                        SizedBox(height: Get.height * 0.04,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                InkWell(
                                                    child: Image.asset(
                                                      'assets/images/skillsvg.png',
                                                      height: Get.height * .04,)),
                                                SizedBox(
                                                  width: Get.width * 0.02,),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 4.0),
                                                  child:
                                                  Text('Skill',
                                                    style: Get.theme.textTheme
                                                        .labelMedium!.copyWith(
                                                        color: AppColors.white),),
                                                ),
                                              ],
                                            ),

                                          ],
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
                                        candidateController.candidateData.value.seekerDetails?.seekerData?.skillName == null ||
                                            candidateController.candidateData.value.seekerDetails?.seekerData?.skillName?.length == 0 ?
                                        Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount: candidateController.candidateData.value.seekerDetails?.seekerData?.skillName?.length,
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
                                                child: Text(candidateController.candidateData.value.seekerDetails?.seekerData?.skillName?[index].skills ?? "",
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
                                    candidateController.candidateData.value.seekerDetails?.seekerData?.passionName == null ||
                                        candidateController.candidateData.value.seekerDetails?.seekerData?.passionName?.length == 0 ?
                                    Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount: candidateController.candidateData.value.seekerDetails?.seekerData?.passionName?.length,
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
                                                child: Text( candidateController.candidateData.value.seekerDetails?.seekerData?.passionName?[index].passion  ?? '',
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
                                        candidateController.candidateData.value.seekerDetails?.seekerData?.industryPreferenceName == null ||
                                            candidateController.candidateData.value.seekerDetails?.seekerData?.industryPreferenceName?.length == 0 ?
                                        Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount: candidateController.candidateData.value.seekerDetails?.seekerData?.industryPreferenceName?.length,
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
                                                child: Text(candidateController.candidateData.value.seekerDetails?.seekerData?.industryPreferenceName?[index].industryPreferences ?? "",
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
                                        candidateController.candidateData.value.seekerDetails?.seekerData?.strengthsName == null ||
                                            candidateController.candidateData.value.seekerDetails?.seekerData?.strengthsName?.length == 0 ?
                                        Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount: candidateController.candidateData.value.seekerDetails?.seekerData?.strengthsName?.length,
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
                                                child: Text( candidateController.candidateData.value.seekerDetails?.seekerData?.strengthsName?[index].strengths ?? '',
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
                                          child: Text('${ candidateController.candidateData.value.seekerDetails?.seekerData?.minSalaryExpectation ?? ''} - ${ candidateController.candidateData.value.seekerDetails?.seekerData?.maxSalaryExpectation ?? 'No salary expectation'}',
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
                                        candidateController.candidateData.value.seekerDetails?.seekerData?.startWorkName == null ||
                                            candidateController.candidateData.value.seekerDetails?.seekerData?.startWorkName?.length == 0 ?
                                        Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount:  candidateController.candidateData.value.seekerDetails?.seekerData?.startWorkName?.length,
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
                                                child: Text( candidateController.candidateData.value.seekerDetails?.seekerData?.startWorkName?[index].startWork ?? '',
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
                                        candidateController.candidateData.value.seekerDetails?.seekerData?.availabityName == null ||
                                            candidateController.candidateData.value.seekerDetails?.seekerData?.availabityName?.length == 0 ?
                                        Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 39,
                                            maxCrossAxisExtent: Get.width * 0.35,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 6),
                                            itemCount:   candidateController.candidateData.value.seekerDetails?.seekerData?.availabityName?.length,
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
                                                child: Text(  candidateController.candidateData.value.seekerDetails?.seekerData?.availabityName?[index].availabity ?? '',
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: Get.theme.textTheme
                                                      .bodySmall!.copyWith(
                                                      color: AppColors.white,
                                                      fontWeight: FontWeight
                                                          .w400,fontSize: 9),),
                                              );
                                            }),
                                        SizedBox(height: Get.height*.04,) ,
                                        // SizedBox(height: Get.height * 0.02,),
                                        // const Divider(thickness: 0.2,
                                        //   color: AppColors.white,),
                                        // SizedBox(height: Get.height * 0.02,),
                                        // candidateController.candidateData.value.seekerDetails?.seekerData?.skillName == null ||
                                        //     candidateController.candidateData.value.seekerDetails?.seekerData?.skillName?.length == 0 ?
                                        // const Text("No Data") :
                                        // GridView.builder(gridDelegate:
                                        // SliverGridDelegateWithMaxCrossAxisExtent(
                                        //     mainAxisExtent: 36,
                                        //     maxCrossAxisExtent: Get.width * 0.4,
                                        //     mainAxisSpacing: 8,
                                        //     crossAxisSpacing: 8),
                                        //     itemCount: candidateController.candidateData.value.seekerDetails?.seekerData?.skillName?.length,
                                        //     shrinkWrap: true,
                                        //     physics: const NeverScrollableScrollPhysics(),
                                        //     itemBuilder: (context, index) {
                                        //       var data = candidateController.candidateData.value.seekerDetails?.seekerData?.skillName?[index];
                                        //       return Container(
                                        //         alignment: Alignment.center,
                                        //         decoration: BoxDecoration(
                                        //           borderRadius: BorderRadius
                                        //               .circular(12),
                                        //           color: AppColors.blackdown,
                                        //         ),
                                        //         padding: const EdgeInsets.all(
                                        //             8),
                                        //         child: Text('${data?.skills}',
                                        //           overflow: TextOverflow
                                        //               .ellipsis,
                                        //           style: Get.theme.textTheme
                                        //               .bodySmall!.copyWith(
                                        //               color: AppColors.white,
                                        //               fontWeight: FontWeight
                                        //                   .w400),),
                                        //       );
                                        //     }),
                                        //********************* for Language ***************************
                                        SizedBox(height: Get.height * 0.01,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                InkWell(
                                                    child: Image.asset(
                                                      'assets/images/appreciation.png',
                                                      height: Get.height * .04,)),
                                                SizedBox(
                                                  width: Get.width * 0.02,),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 2.0),
                                                  child:
                                                  Text('Language',
                                                    style: Get.theme.textTheme
                                                        .titleSmall!.copyWith(
                                                        color: AppColors.white),),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02,),
                                        const Divider(thickness: 0.2,
                                          color: AppColors.white,),
                                        SizedBox(height: Get.height * 0.02,),
                                       candidateController.candidateData.value.seekerDetails?.seekerData?.languageName == null ||
                                           candidateController.candidateData.value.seekerDetails?.seekerData?.languageName?.length == 0 ?
                                       Text("No language", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                        GridView.builder(gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 36,
                                            maxCrossAxisExtent: Get.width * 0.4,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8),
                                            itemCount: candidateController.candidateData.value.seekerDetails?.seekerData?.languageName?.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var data = candidateController.candidateData.value.seekerDetails?.seekerData?.languageName?[index];
                                              return Container( alignment: Alignment.center,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                                                  color: AppColors.blackdown,),
                                                padding: const EdgeInsets.all(8),
                                                child: Text('${data?.languages}',
                                                  style: Get.theme.textTheme.bodySmall!.copyWith(
                                                      color: AppColors.white, fontWeight: FontWeight.w400),),
                                              );
                                            }),
                                        SizedBox(height: Get.height*0.04,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                InkWell(
                                                    child: SvgPicture.asset(
                                                        'assets/images/language.svg')),
                                                SizedBox(
                                                  width: Get.width * 0.02,),
                                                Text('Appreciation',
                                                  style: Get.theme.textTheme
                                                      .titleSmall!.copyWith(
                                                      color: AppColors.white),),
                                              ],
                                            ),

                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.02,),
                                        const Divider(thickness: 0.2,
                                          color: AppColors.white,),
                                        SizedBox(height: Get.height * 0.02,),
                                        candidateController.candidateData.value.seekerDetails?.seekerData?.appreciation == null ||
                                            candidateController.candidateData.value.seekerDetails?.seekerData?.appreciation?.length == 0 ?
                                        Text("No appreciation", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: candidateController.candidateData.value.seekerDetails?.seekerData?.appreciation?.length,
                                            itemBuilder: (context, index) {
                                              var data = candidateController.candidateData.value.seekerDetails?.seekerData?.appreciation?[index];
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(data?.achievement ?? "",
                                                    style: Get.theme.textTheme
                                                        .bodyMedium!.copyWith(
                                                        color: AppColors.white,
                                                        fontWeight: FontWeight
                                                            .w700),),
                                                  SizedBox(
                                                    height: Get.height * 0.01,),
                                                  Text(data?.awardName ?? "",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                        color: AppColors
                                                            .ratingcommenttextcolor,
                                                        fontWeight: FontWeight
                                                            .w400),
                                                  ),
                                                ],
                                              );
                                            }
                                        ),
                                        SizedBox(height: Get.height * 0.05,),
                                        widget.talentPool == true ? const SizedBox() :
                                        Column(
                                          children: [
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                              MyButton(title: widget.status == "accepted" ? "ACCEPTED" : "ACCEPT",
                                                  width: Get.width *.4,
                                                  onTap1: () {
                                                    if(widget.status == "accepted") {} else {
                                                      CommonFunctions.confirmationDialog(context, message: "Do you want to Accept",
                                                          onTap: () {
                                                            Get.back() ;
                                                            CommonFunctions.showLoadingDialog(context, "Updating...") ;
                                                            statusController.jobStatus("Accepted", widget.requestID) ;
                                                          },) ;

                                                    }
                                              }),
                                              MyButton(title: widget.status == "rejected" ? "REJECTED" : "REJECT",
                                                  width: Get.width *.4,
                                                  onTap1: () {
                                                    if(widget.status == "rejected") {} else {
                                                      CommonFunctions.confirmationDialog(context, message: "Do you want to Reject",
                                                  onTap: () {
                                                  Get.back() ;
                                                  CommonFunctions.showLoadingDialog(context, "Updating...") ;
                                                  statusController.jobStatus("Rejected", widget.requestID) ;
                                                },) ;
                                                    }
                                              }),
                                            ],),
                                            SizedBox(height: Get.height * 0.03,),
                                          widget.status == "accepted" ? Center(
                                              child: MyButton(title: widget.scheduleInterview == true ? "EDIT METTING" : 'SCHEDULE METTING',
                                                onTap1: () {
                                                  Get.to(() => CalendarScreen(requestID: widget.requestID));
                                                },
                                              ),
                                            ) :  MyButton(
                                            height: Get.height * .066,
                                            width: Get.width*.75,
                                            title: "TALENT POOL", onTap1: () {
                                            talentPool(widget.seekerID) ;
                                          },),
                                            SizedBox(height: Get.height * 0.03,),
                                          ],
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),
                          );
                      },
                    ),
                  ]
              ),
            );
        }
      }
      ),
    );
  }

  void talentPool(String seekerID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            "Add note",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: Column( mainAxisSize: MainAxisSize.min,
            children: [
              CommonWidgets.textFieldMaxLines(
                  context, controller, "Add note", onFieldSubmitted: (value) {}),
              SizedBox(height: Get.height * .02,),
              Obx( () => MyButton(
                  height: Get.height * .066,
                  width: Get.width*.75,
                  loading: poolController.loading.value,
                  title: "Save", onTap1: () {
                    poolController.poolSeeker(CommonFunctions.changeToHTML(controller.text), seekerID) ;
                  }),
              )
            ],
          ),
        );
      },
    );
  }
}



