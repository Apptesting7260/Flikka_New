import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flikka/models/RecruiterHomePageModel/RecruiterHomePageModel.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/VideoPlayerScreen.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import '../../ChatRecruter/CreateFuction.dart';
import '../../controllers/ApplyJobController/ApplyJobController.dart';
import '../../controllers/RecruiterJobTitleController/RecruiterJobTitleController.dart';
import '../../models/RecuiterJobTitleModel/RecruiterJobTitleModel.dart';


class ViewCandidateProfile extends StatefulWidget {
  final RecruiterHomePageSeekerDetail? recruiterData;
 final List<RecruiterJobTitleList>? titleList ;
  const ViewCandidateProfile({Key? key, this.recruiterData, this.titleList}) : super(key: key);

  @override
  State<ViewCandidateProfile> createState() => _ViewCandidateProfileState();
}

class _ViewCandidateProfileState extends State<ViewCandidateProfile> {

  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController());

  RecruiterJobTitleController jobTitleController = Get.put(RecruiterJobTitleController());
  ApplyJobController applyJobController = Get.put(ApplyJobController()) ;

  Createchatrecruter Ctreatechatinstance=Createchatrecruter();

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
        title: Text(widget.recruiterData?.seeker?.fullname ?? "",
              style: Get.theme.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w700)),
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(color: AppColors.blueThemeColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Stack(children: [
                      CircleAvatar(
                        radius: 40,
                        child: CachedNetworkImage(
                          imageUrl: widget.recruiterData?.seeker?.profileImg ?? '',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ])
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                HtmlWidget(widget.recruiterData?.seeker?.fullname ?? "No data",
                    textStyle: Get.theme.textTheme.displayLarge),
                SizedBox(
                  height: Get.height * 0.005,
                ),
                Text(widget.recruiterData?.positions ?? "No positions",
                    style: Get.theme.textTheme.bodyLarge!
                        .copyWith(color: AppColors.white)),
                SizedBox(
                  height: Get.height * 0.005,
                ),
                HtmlWidget(widget.recruiterData?.seeker?.location ?? "no location",
                    textStyle: Get.theme.textTheme.bodyLarge!
                        .copyWith(color: AppColors.white,overflow: TextOverflow.ellipsis)),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        SeekerIDchat=widget.recruiterData?.seeker?.id.toString();
                        Seekerimgchat=widget.recruiterData?.seeker?.profileImg.toString();
                        SeekerName=widget.recruiterData?.seeker?.fullname.toString();
                        setState(() {
                          SeekerIDchat;
                          Seekerimgchat;
                          SeekerName;
                        });

                        print(SeekerIDchat);
                        print(Seekerimgchat);
                        print(SeekerName);
                        Timer(Duration(seconds: 2), () {
                          if(SeekerIDchat.toString()!="null"&&Seekerimgchat.toString()!="null"&&SeekerName.toString()!="null"){
                            Ctreatechatinstance.CreateChat();
                          }

                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.white),
                          child: Row(
                            children: [
                              Image.asset('assets/images/icon_msg.png',height: Get.height*.06,),
                            ],
                          )),
                    ),
                    SizedBox(
                      width: Get.width * 0.045,
                    ),
                    widget.recruiterData?.seeker?.mobile == null ||
                        widget.recruiterData?.seeker?.mobile.toString().length == 0
                        ? const SizedBox()
                        : Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColors.white),
                                child: GestureDetector(
                                  onTap: () {
                                    if (kDebugMode) {
                                      print("tapped") ;
                                    }
                                    CommonFunctions.launchDialer("${widget.recruiterData?.seeker?.mobile}") ;
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
                        if( widget.recruiterData?.seeker?.video == null ||
                            widget.recruiterData?.seeker?.video.toString().length == 0 ) {
                          Utils.showMessageDialog(context, "video not uploaded yet") ;
                        }
                        else {
                          if (kDebugMode) {
                            print(widget.recruiterData?.seeker?.video) ;
                          }
                          Get.to(() => VideoPlayerScreen(videoPath: widget.recruiterData?.seeker?.video ?? "")) ;
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
                SizedBox(height: Get.height * 0.02,),
                widget.recruiterData?.startWorkName == null ||
                    widget.recruiterData?.startWorkName?.length == 0 ? const SizedBox()
                    : SizedBox(
                        height: Get.height * 0.062,
                        width: Get.width * 0.69,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35))),
                          onPressed: () {},
                          child: Text(
                            widget.recruiterData?.startWorkName?[0].startWork ?? "",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
        //************* scrollable functionality ******************
        DraggableScrollableSheet(
          initialChildSize:  widget.recruiterData?.startWorkName == null || widget.recruiterData?.startWorkName?.length == 0 ? 0.6 : 0.52, // half screen
          minChildSize: widget.recruiterData?.startWorkName == null || widget.recruiterData?.startWorkName?.length == 0 ? 0.6 : 0.52,// half screen
          maxChildSize: 1, // full screen
          builder: (BuildContext context, ScrollController scrollController) {

            return Container(
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
                              topRight: Radius.circular(25))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/icon_phone_call.png",height: Get.height*.03,),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Text("Phone Number",style: Theme.of(context).textTheme.titleSmall,)
                            ],
                          ) ,
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.white,
                          ),
                          Text(widget.recruiterData?.seeker?.mobile ?? "No phone number") ,
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                  child: Image.asset(
                                'assets/images/about.png',
                                height: Get.height * .03,
                              )),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Text(
                                "About",
                                style: Theme.of(context).textTheme.titleSmall,
                                softWrap: true,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          HtmlWidget(
                            widget.recruiterData?.seeker?.aboutMe ?? "No about",
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: const Color(0xffCFCFCF)),
                          ),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                  child: Image.asset(
                                'assets/images/icon work experience.png',
                                height: Get.height * .03,
                              )),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  'Work experience',
                                  style: Get.theme.textTheme.titleSmall!
                                      .copyWith(color: AppColors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          widget.recruiterData?.workExpJob ==
                                      null ||
                                  widget.recruiterData?.workExpJob
                                          ?.length ==
                                      0
                              ?  Text("No work experience",style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)))
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: widget.recruiterData?.workExpJob?.length,
                                  itemBuilder: (context, index) {
                                    var data = widget.recruiterData?.workExpJob?[index];
                                    var endDate ;
                                    var startDate ;
                                    startDate = DateTime.parse("${data?.jobStartDate}") ;
                                    startDate = "${startDate.month.toString().padLeft(2,"0")}-${startDate.day.toString().padLeft(2,"0")}-${startDate.year.toString().padLeft(4,"0")}" ;
                                    if(data?.present == true || data?.jobEndDate.toString().toLowerCase() == "present") {
                                      endDate = "Present" ;
                                    }else {
                                      endDate = DateTime.parse("${data?.jobEndDate}") ;
                                      endDate = "${endDate.month.toString().padLeft(2,"0")}-${endDate.day.toString().padLeft(2,"0")}-${endDate.year.toString().padLeft(4,"0")}" ;
                                    }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        HtmlWidget(
                                          data?.workExpJob ?? "",
                                          textStyle: Get
                                              .theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        // Text(CommonFunctions.parseHTML(data?.workExpJob ?? ""),style: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),
                                        SizedBox(
                                          height: Get.height * 0.001,
                                        ),
                                        HtmlWidget(
                                          data?.companyName ?? "No company name",
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: AppColors
                                                      .ratingcommenttextcolor,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        // Text( CommonFunctions.parseHTML(data?.companyName ?? ""),style: Theme.of(context).textTheme.bodySmall!
                                        //     .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                        // ),
                                        Text("$startDate  -  $endDate",
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                  color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: Get.height * .01,
                                        )
                                      ],
                                    );
                                  }),

                          //******************** for Education **************************
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                      child: Image.asset(
                                    'assets/images/icon education.png',
                                    height: Get.height * .037,
                                  )),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      'Education',
                                      style: Get.theme.textTheme.titleSmall!
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          widget.recruiterData?.educationLevel ==
                                      null ||
                                  widget.recruiterData
                                          ?.educationLevel?.length ==
                                      0
                              ? const Text("No Data")
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: widget.recruiterData?.educationLevel?.length,
                                  itemBuilder: (context, index) {
                                    var data = widget.recruiterData?.educationLevel?[index];
                                    var endDate ;
                                    if(data?.present == true || data?.educationEndDate.toString().toLowerCase() == "present") {
                                      endDate = "Present" ;
                                    } else {
                                      endDate = "${data?.educationEndDate.month.toString().padLeft(2,'0')}-${data?.educationEndDate.day.toString().padLeft(2,'0')}-${data?.educationEndDate.year.toString().padLeft(4,'0')}" ;
                                    }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data?.educationLevel ?? "",
                                          style: Get.theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.001,
                                        ),
                                        Text(
                                          data?.institutionName ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: AppColors
                                                      .ratingcommenttextcolor,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "${data?.educationStartDate.month.toString().padLeft(2,"0").replaceAll("00:00:00.000", "")}-${data?.educationStartDate.day.toString().padLeft(2,"0").replaceAll("00:00:00.000", "")}-${data?.educationStartDate.year.toString().padLeft(4,"0").replaceAll("00:00:00.000", "")}  -  $endDate",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: AppColors
                                                      .ratingcommenttextcolor,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: Get.height * .01,
                                        )
                                      ],
                                    );
                                  }),

                          //******************** for Skill **************************
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                      child: Image.asset(
                                    'assets/images/skillsvg.png',
                                    height: Get.height * .03,
                                  )),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      'Skill',
                                      style: Get.theme.textTheme.labelMedium!
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.white,
                          ),
                          // SizedBox(
                          //   height: Get.height * 0.02,
                          // ),
                          // widget.recruiterData?.skillName == null ||
                          //         widget.recruiterData?.skillName?.length == 0
                          //     ? const Text("No Data")
                          //     : GridView.builder(
                          //         gridDelegate:
                          //             SliverGridDelegateWithMaxCrossAxisExtent(
                          //                 mainAxisExtent: 36,
                          //                 maxCrossAxisExtent: Get.width * 0.4,
                          //                 mainAxisSpacing: 8,
                          //                 crossAxisSpacing: 8),
                          //         itemCount: widget.recruiterData?.skillName?.length,
                          //         shrinkWrap: true,
                          //         physics: const NeverScrollableScrollPhysics(),
                          //         itemBuilder: (context, index) {
                          //           var data = widget.recruiterData?.skillName?[index];
                          //           return Container(
                          //             alignment: Alignment.center,
                          //             decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(12),
                          //               color: AppColors.blackdown,
                          //             ),
                          //             padding: const EdgeInsets.all(8),
                          //             child: Text(
                          //               '${data?.skills}',
                          //               overflow: TextOverflow.ellipsis,
                          //               style: Get.theme.textTheme.bodySmall!
                          //                   .copyWith(
                          //                       color: AppColors.white,
                          //                       fontWeight: FontWeight.w400),
                          //             ),
                          //           );
                          //         }),

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
                          widget.recruiterData?.skillName == null ||
                              widget.recruiterData?.skillName?.length == 0 ?
                          Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                          GridView.builder(gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 39,
                              maxCrossAxisExtent: Get.width * 0.35,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6),
                              itemCount: widget.recruiterData?.skillName?.length,
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
                                  child: Text(widget.recruiterData?.skillName?[index].skills ?? "",
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
                          widget.recruiterData?.passionName == null ||
                              widget.recruiterData?.passionName?.length == 0 ?
                          Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                          GridView.builder(gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 39,
                              maxCrossAxisExtent: Get.width * 0.35,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6),
                              itemCount: widget.recruiterData?.passionName?.length,
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
                                  child: Text( widget.recruiterData?.passionName?[index].passion  ?? '',
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
                          widget.recruiterData?.industryPreferenceName == null ||
                              widget.recruiterData?.industryPreferenceName?.length == 0 ?
                          Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                          GridView.builder(gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 39,
                              maxCrossAxisExtent: Get.width * 0.35,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6),
                              itemCount: widget.recruiterData?.industryPreferenceName?.length,
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
                                  child: Text(widget.recruiterData?.industryPreferenceName?[index].industryPreferences ?? "",
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
                          widget.recruiterData?.strengthsName == null ||
                              widget.recruiterData?.strengthsName?.length == 0 ?
                          Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                          GridView.builder(gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 39,
                              maxCrossAxisExtent: Get.width * 0.35,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6),
                              itemCount: widget.recruiterData?.strengthsName?.length,
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
                                  child: Text( widget.recruiterData?.strengthsName?[index].strengths ?? '',
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
                            child: Text('${ widget.recruiterData?.minSalaryExpectation ?? ''} - ${ widget.recruiterData?.maxSalaryExpectation ?? 'No salary expectation'}',
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
                          widget.recruiterData?.startWorkName == null ||
                              widget.recruiterData?.startWorkName?.length == 0 ?
                          Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                          GridView.builder(gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 39,
                              maxCrossAxisExtent: Get.width * 0.35,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6),
                              itemCount:  widget.recruiterData?.startWorkName?.length,
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
                                  child: Text(  widget.recruiterData?.startWorkName?[index].startWork ?? '',
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
                          widget.recruiterData?.availabityName == null ||
                              widget.recruiterData?.availabityName?.length == 0 ?
                          Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                          GridView.builder(gridDelegate:
                          SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 39,
                              maxCrossAxisExtent: Get.width * 0.35,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6),
                              itemCount:   widget.recruiterData?.availabityName?.length,
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
                                  child: Text(  widget.recruiterData?.availabityName?[index].availabity ?? '',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                      child: Image.asset(
                                    'assets/images/appreciation.png',
                                    height: Get.height * .03,
                                  )),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      'Language',
                                      style: Get.theme.textTheme.titleSmall!
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          widget.recruiterData?.language == null ||
                                  widget.recruiterData?.language?.length == 0
                              ?  Text("No language", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),)
                              : GridView.builder(
                                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                          mainAxisExtent: 36,
                                          maxCrossAxisExtent: Get.width * 0.4,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8),
                                  itemCount: widget.recruiterData?.language?.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var data = widget.recruiterData?.language?[index];
                                    return Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.blackdown,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        '${data?.languages}',
                                        overflow: TextOverflow.ellipsis,
                                        style: Get.theme.textTheme.bodySmall!
                                            .copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w400),
                                      ),
                                    );
                                  }),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                      child: SvgPicture.asset(
                                    'assets/images/language.svg',
                                    height: Get.height * .03,
                                  )),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Text(
                                    'Appreciation',
                                    style: Get.theme.textTheme.titleSmall!
                                        .copyWith(color: AppColors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          widget.recruiterData?.appreciation == null ||
                                  widget.recruiterData?.appreciation?.length == 0
                              ?  Text("No appreciation", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),)
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.recruiterData?.appreciation?.length,
                                  itemBuilder: (context, index) {
                                    var data = widget.recruiterData?.appreciation?[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data?.achievement ?? "",
                                          style: Get.theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.001,
                                        ),
                                        Text(
                                          data?.awardName ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: AppColors
                                                      .ratingcommenttextcolor,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                      ],
                                    );
                                  }),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: Get.height * 0.07,
                                    child: MyButton(
                                        onTap1: () {
                                          jobTitleDialog() ;
                                        }, title: 'ACCEPT'),
                                  ),
                                ),
                                // const SizedBox(
                                //     width:
                                //         20), // Adding spacing between buttons
                                // Expanded(
                                //   child: SizedBox(
                                //     height: Get.height * 0.07,
                                //     child: ElevatedButton(
                                //       style: ElevatedButton.styleFrom(
                                //           backgroundColor: AppColors.white,
                                //           shape: RoundedRectangleBorder(
                                //             borderRadius:
                                //                 BorderRadius.circular(60.0),
                                //           )),
                                //       onPressed: () {},
                                //       child: Text(
                                //         'REJECT',
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .bodyMedium
                                //             ?.copyWith(
                                //                 fontWeight: FontWeight.w700,
                                //                 color: AppColors.black),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                        ],
                      )),
                ],
              ),
            );
          },
        ),
      ]),
    );
  }

  jobTitleDialog () {
    showDialog(context: context, builder: (BuildContext context) {
      String? jobTitleValue;
      String? jobTitleID;
      RxString errorMessage = "".obs ;
      return Dialog(
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none),
        child: StatefulBuilder(
            builder: (context , setState) {
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height *.02, horizontal: Get.width * .04),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Select job for this profile") ,
                      SizedBox(height: Get.height *.02,) ,
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text(
                            jobTitleValue ??  "Select job",
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                color: AppColors.white, fontSize: 12), overflow: TextOverflow.ellipsis,),
                          items: widget.titleList?.map((item) =>
                              DropdownMenuItem(
                                value: item.id,
                                child: Text(item.jobTitle.toString() ,
                                  style: Get.theme.textTheme.bodyLarge!
                                      .copyWith(color: AppColors.white,
                                      fontSize: 12),
                                  overflow: TextOverflow.ellipsis,),
                                onTap: () {
                                  setState(() {
                                    jobTitleID = item.id.toString() ;
                                    jobTitleValue = item.jobTitle ;
                                  });
                                },
                              )).toList(),
                          // value: jobTitleValue,
                          onChanged: (value) {},
                          buttonStyleData: ButtonStyleData(
                            height: Get.height * 0.06,
                            width: Get.width * .55,
                            padding: const EdgeInsets.only(
                                left: 10, right: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                border: Border.all(
                                    color: const Color(0xff686868))
                              // color: Color(0xff353535),
                            ),
                            elevation: 2,
                          ),

                          dropdownStyleData: DropdownStyleData(
                            maxHeight: Get.height * 0.35,
                            width: Get.width * .5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: const Color(0xff353535),
                            ),
                            offset: const Offset(5, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all<
                                  double>(6),
                              thumbVisibility: MaterialStateProperty.all<
                                  bool>(true),
                            ),
                          ),

                        ),
                      ),
                      Obx(() => errorMessage.isEmpty ? const SizedBox() :
                      Text(errorMessage.value , style: const TextStyle(color: AppColors.red),)),
                      SizedBox(height: Get.height *.02,) ,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx( () =>
                              MyButton(
                                  width: Get.width*.25,
                                  height: Get.height*.05,
                                  loading: applyJobController.loading.value,
                                  title: "Select",
                                  onTap1: () {
                                    if(jobTitleID != null) {
                                      applyJobController.applyJob(context,jobTitleID,seekerID: widget.recruiterData?.seekerId.toString(),) ;
                                    }else {
                                      errorMessage.value = "Choose Job before selecting" ;
                                    }
                                  } ),
                          ),
                          MyButton(
                            width: Get.width*.25,
                            height: Get.height*.05,
                            title: "Cancel",
                            onTap1: () {
                              Get.back();
                            },),
                        ],
                      )
                    ],
                  )
              );
            }
        ),
      ) ;
    }) ;
  }
 }
