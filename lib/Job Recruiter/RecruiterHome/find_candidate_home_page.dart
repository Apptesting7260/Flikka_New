import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/Job%20Recruiter/RecruiterDrawer/drawer_recruiter.dart';
import 'package:flikka/Job%20Recruiter/RecruiterHome/find_candidate_home_page_recruiter.dart';
import 'package:flikka/controllers/RecruiterHomeController/RecruiterHomeController.dart';
import 'package:flikka/controllers/RecruiterHomePageJobsController/RecruiterHomePageJobsController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Job Seeker/SeekerJobs/no_job_available.dart';
import '../../controllers/ApplyJobController/ApplyJobController.dart';
import '../../controllers/RecruiterJobTitleController/RecruiterJobTitleController.dart';
import '../../controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';
import '../../utils/CommonFunctions.dart';
import '../../widgets/app_colors.dart';
import '../../widgets/my_button.dart';


class FindCandidateHomePage extends StatefulWidget {
  const FindCandidateHomePage({super.key});

  @override
  State<FindCandidateHomePage> createState() => _FindCandidateHomePageState();
}

class _FindCandidateHomePageState extends State<FindCandidateHomePage> {

  final CardSwiperController controller = CardSwiperController();

  RecruiterHomeController homeController = Get.put(RecruiterHomeController()) ;
  RecruiterJobTitleController jobTitleController = Get.put(RecruiterJobTitleController());
  ApplyJobController applyJobController = Get.put(ApplyJobController()) ;
  RecruiterHomePageJobsController jobsController = Get.put(RecruiterHomePageJobsController()) ;
  ViewRecruiterProfileGetController viewRecruiterProfileController = Get.put(ViewRecruiterProfileGetController());

  //////refresh//////
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    homeController.recruiterHomeApi();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    homeController.recruiterHomeApi();
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  /////refresh/////

  final List<String> itemsEmp = ['marketing intern','software developer','web developer', 'internship', 'fresher' ,];
  String? employmentType;

  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  Timer? _scrollTimer;
  double _previousScrollOffset = 0.0;
  double _appBarOpacity = 0.0;

  @override
  void initState() {
    homeController.recruiterHomeApi() ;
   jobsController.recruiterJobsApi() ;
   jobTitleController.recruiterJobTitleApi() ;
    viewRecruiterProfileController.viewRecruiterProfileApi() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (homeController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),);
        case Status.ERROR:
          if (homeController.error.value ==
              'No internet') {
            return Scaffold(
              body: InterNetExceptionWidget(
                onPress: () {
                  homeController.recruiterHomeApi();
                },
              ),);
          } else if (homeController.error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {
              homeController.recruiterHomeApi();
            }),);
          } else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              homeController.recruiterHomeApi();
            }),);
          }
        case Status.COMPLETED:
          return Obx(() {
            switch (jobsController.rxRequestStatus.value) {
              case Status.LOADING:
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),);
              case Status.ERROR:
                if (jobsController.error.value ==
                    'No internet') {
                  return Scaffold(
                    body: InterNetExceptionWidget(
                      onPress: () {
                        jobsController.recruiterJobsApi() ;
                      },
                    ),);
                } else if (jobsController.error.value == 'Request Time out') {
                  return Scaffold(body: RequestTimeoutWidget(onPress: () {
                    jobsController.recruiterJobsApi() ;
                  }),);
                } else {
                  return Scaffold(body: GeneralExceptionWidget(onPress: () {
                    jobsController.recruiterJobsApi() ;
                  }),);
                }
              case Status.COMPLETED:
                return Obx(() {
                  switch (viewRecruiterProfileController.rxRequestStatus
                      .value) {
                    case Status.LOADING:
                      return const Scaffold(
                        body: Center(child: CircularProgressIndicator()),);
                    case Status.ERROR:
                      if (viewRecruiterProfileController.error.value ==
                          'No internet') {
                        return Scaffold(
                          body: InterNetExceptionWidget(
                            onPress: () {
                              viewRecruiterProfileController
                                  .viewRecruiterProfileApi();
                            },
                          ),);
                      } else if (viewRecruiterProfileController.error.value ==
                          'Request Time out') {
                        return Scaffold(body: RequestTimeoutWidget(onPress: () {
                          viewRecruiterProfileController
                              .viewRecruiterProfileApi();
                        }),);
                      } else {
                        return Scaffold(body: GeneralExceptionWidget(
                            onPress: () {
                              viewRecruiterProfileController
                                  .viewRecruiterProfileApi();
                            }),);
                      }
                    case Status.COMPLETED:
                      return SafeArea(
                        child: Scaffold(
                          backgroundColor: AppColors.white,
                          endDrawer: const DrawerRecruiter(),
                          body: SmartRefresher(
                            controller: _refreshController,
                            onRefresh: _onRefresh,
                            onLoading: _onLoading,
                            child: Column(
                                children: [
                                  Flexible(
                                    child: homeController.homeData.value.Seeker_Details == null ||
                                        homeController.homeData.value.Seeker_Details?.length == 0 ?
                                    const SeekerNoJobAvailable(message: "No Data Available",) :
                                    GestureDetector(
                                      onHorizontalDragEnd: (details) {
                                        if (details.primaryVelocity! > 0) {
                                          onSwipeRight();
                                        } else if (details.primaryVelocity! < 0) {
                                          onSwipeLeft();
                                        }
                                      }, child: PageView.builder(
                                      controller: _pageController,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: homeController.homeData.value.Seeker_Details?.length,
                                      itemBuilder: (context, index) {
                                        return SingleChildScrollView(
                                          controller: _scrollController,
                                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Stack(children: [
                                                CachedNetworkImage(imageUrl: homeController.homeData.value.Seeker_Details?[index].seeker?.profileImg ?? "" ,
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
                                                  top: 0,
                                                  child: SizedBox(width: Get.width,
                                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              top: Get.height * .03),
                                                          child: Image.asset(
                                                            'assets/images/icon_flikka_logo.png',
                                                            height: Get.height * .032,),
                                                        ),
                                                        Column(mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            SizedBox(height: Get.height * .03,),
                                                            DropdownButtonHideUnderline(
                                                              child: DropdownButton2(
                                                                isExpanded: true,
                                                                hint: Text(
                                                                  employmentType ??
                                                                      homeController.homeData.value
                                                                          .Seeker_Details?[0]
                                                                          .positions ??
                                                                      "No positions",
                                                                  style: Get.theme.textTheme
                                                                      .bodyLarge!
                                                                      .copyWith(
                                                                      color: AppColors.white,
                                                                      fontSize: 12),
                                                                  overflow: TextOverflow.ellipsis,),
                                                                items: jobsController.getJobsDetails
                                                                    .value
                                                                    .jobPositionList?.map((item) =>
                                                                    DropdownMenuItem(
                                                                      value: item.id,
                                                                      child: Text(
                                                                        item.positions.toString(),
                                                                        style: Get.theme.textTheme
                                                                            .bodyLarge!
                                                                            .copyWith(
                                                                            color: AppColors.white,
                                                                            fontSize: 12),
                                                                        overflow: TextOverflow
                                                                            .ellipsis,),
                                                                      onTap: () {
                                                                        setState(() {
                                                                          homeController
                                                                              .recruiterHomeApi(
                                                                              jobPosition: item.id
                                                                                  .toString());
                                                                        });
                                                                      },
                                                                    )).toList(),
                                                                // value: jobTitleValue,
                                                                onChanged: (value) {},
                                                                buttonStyleData: ButtonStyleData(
                                                                  height: Get.height * 0.06,
                                                                  width: Get.width * .45,
                                                                  padding: const EdgeInsets.only(
                                                                      left: 10, right: 5),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(35),
                                                                      border: Border.all(color: const Color(0xff686868))
                                                                  ),
                                                                  elevation: 2,
                                                                ),

                                                                dropdownStyleData: DropdownStyleData(
                                                                  maxHeight: Get.height * 0.35,
                                                                  width: Get.width * .45,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius
                                                                        .circular(14),
                                                                    color: const Color(0xff353535),
                                                                  ),
                                                                  offset: const Offset(5, 0),
                                                                  scrollbarTheme: ScrollbarThemeData(
                                                                    radius: const Radius.circular(40),
                                                                    thickness: MaterialStateProperty
                                                                        .all<
                                                                        double>(6),
                                                                    thumbVisibility: MaterialStateProperty
                                                                        .all<
                                                                        bool>(true),
                                                                  ),
                                                                ),

                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Builder(
                                                            builder: (context) {
                                                              return InkWell(
                                                                  onTap: () =>
                                                                      Scaffold.of(context)
                                                                          .openEndDrawer(),
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: Get.height * .032),
                                                                    child: Image.asset(
                                                                      'assets/images/inactive.png',
                                                                      height: Get.height * .05,),
                                                                  ));
                                                            }
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // Positioned(
                                                //   right: 20,
                                                //   top: Get.height * 0.13,
                                                //   child: Stack(
                                                //     children: [
                                                //       GestureDetector(
                                                //         onTap:
                                                //             () {
                                                //           showSeekerHomePagePercentageProfile(context, homeController.homeData.value.Seeker_Details?[index]);
                                                //         },
                                                //         child:
                                                //         Container(
                                                //           decoration: BoxDecoration(
                                                //               borderRadius: BorderRadius.circular(50),
                                                //               border: Border.all(color: AppColors.white, width: 2)),
                                                //           child:
                                                //           Padding(
                                                //             padding:
                                                //             const EdgeInsets.all(3.0),
                                                //             child: Container(
                                                //                 decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.blueThemeColor),
                                                //                 child: CircleAvatar(
                                                //                     radius: 30,
                                                //                     backgroundColor: Colors.transparent,
                                                //                     child: Center(
                                                //                       child: Column(
                                                //                         mainAxisAlignment: MainAxisAlignment.center,
                                                //                         children: [
                                                //                           Text('${homeController.homeData.value.Seeker_Details?[index].jobMatchPercentage}%', style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white)),
                                                //                           Text('match', style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white, fontSize: 7)),
                                                //                         ],
                                                //                       ),
                                                //                     ))),
                                                //           ),
                                                //         ),
                                                //       )
                                                //     ],
                                                //   ),
                                                // ),
                                                // Positioned(
                                                //   left: 12,
                                                //   top: Get.height * 0.13,
                                                //   child: Column(
                                                //     children: [
                                                //       GestureDetector(
                                                //           onTap:
                                                //               () {
                                                //             // getJobsListingController.saved.value=true;
                                                //             CommonFunctions.confirmationDialog(context,
                                                //                 message: homeController.homeData.value.Seeker_Details?[index].postSaved ? "Do you want to remove the\n post from saved posts" : "Do you want to save the post",
                                                //                 onTap: () async {
                                                //                   Get.back();
                                                //                   if (homeController.homeData.value.Seeker_Details?[index].postSaved == true) {
                                                //                     CommonFunctions.showLoadingDialog(context, "removing...");
                                                //                     var result = await unSavePostController.unSavePost(homeController.homeData.value.Seeker_Details?[index].id.toString(), "1", context, true);
                                                //                     if (result == true) {
                                                //                       if (kDebugMode) {
                                                //                         print("inside result");
                                                //                       }
                                                //                       homeController.homeData.value.Seeker_Details?[index].postSaved = false;
                                                //                       setState(() {});
                                                //                     }
                                                //                   } else {
                                                //                     CommonFunctions.showLoadingDialog(context, "Saving");
                                                //                     var result = await seekerSaveJobController.saveJobApi(homeController.homeData.value.Seeker_Details?[index].id, 1);
                                                //                     if (result == true) {
                                                //                       if (kDebugMode) {
                                                //                         print("inside result");
                                                //                       }
                                                //                       homeController.homeData.value.Seeker_Details?[index].postSaved = true;
                                                //                       setState(() {});
                                                //                     }
                                                //                   }
                                                //                 });
                                                //           },
                                                //           child: homeController.homeData.value.Seeker_Details?[index].postSaved == false
                                                //               ? Image.asset(
                                                //             "assets/images/icon_unsave_post.png",
                                                //             height: Get.height * .043,
                                                //           )
                                                //               : Image.asset(
                                                //             "assets/images/icon_Save_post.png",
                                                //             height: Get.height * .043,
                                                //           )),
                                                //       SizedBox(
                                                //         height: Get.height *
                                                //             .01,
                                                //       ),
                                                //       GestureDetector(
                                                //           onTap:
                                                //               () {
                                                //             Get.to(() => const FilterPage());
                                                //           },
                                                //           child:
                                                //           Image.asset(
                                                //             "assets/images/icon_filter_seeker_home.png",
                                                //             height:
                                                //             Get.height * .043,
                                                //           )),
                                                //       SizedBox(height: Get.height * .01,),
                                                //       GestureDetector(
                                                //         onTap:
                                                //             () {
                                                //           if (homeController.homeData.value.Seeker_Details?[index].video == null ||
                                                //               homeController.homeData.value.Seeker_Details?[index].video?.length == 0) {
                                                //             Utils.showMessageDialog(context,
                                                //                 "video not uploaded yet");
                                                //           } else {
                                                //             Get.back();
                                                //             Get.to(() =>
                                                //                 VideoPlayerScreen(videoPath: homeController.homeData.value.Seeker_Details?[index]?.video ?? ""));
                                                //           }
                                                //         },
                                                //         child:
                                                //         Container(
                                                //           alignment:
                                                //           Alignment.center,
                                                //           height:
                                                //           34,
                                                //           width:
                                                //           34,
                                                //           decoration: const BoxDecoration(
                                                //               shape: BoxShape.circle,
                                                //               color: AppColors.blueThemeColor),
                                                //           child:
                                                //           Image.asset(
                                                //             "assets/images/icon_video.png",
                                                //             height:
                                                //             18,
                                                //             fit:
                                                //             BoxFit.cover,
                                                //           ),
                                                //         ),
                                                //       ),
                                                //       SizedBox(height: Get.height * .01,),
                                                //       homeController.homeData.value.Seeker_Details?[index].jobMatchPercentage == 100
                                                //           ? InkWell(
                                                //         child: Container(
                                                //           alignment: Alignment.center,
                                                //           height: 34,
                                                //           width: 34,
                                                //           decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.blueThemeColor),
                                                //           child: Image.asset(
                                                //             'assets/images/icon_msg_blue.png',
                                                //             height: Get.height * .06,
                                                //           ),
                                                //         ),
                                                //         onTap: () {
                                                //           RecruiterId = homeController.homeData.value.Seeker_Details?[index].recruiterId.toString();
                                                //           Recruitername = homeController.homeData.value.Seeker_Details?[index].recruiterDetails?.companyName;
                                                //           Recruiterimg = homeController.homeData.value.Seeker_Details?[index].recruiterDetails?.profileImg;
                                                //
                                                //           setState(() {
                                                //             RecruiterId;
                                                //             Recruitername;
                                                //             Recruiterimg;
                                                //           });
                                                //           if (kDebugMode) {
                                                //             print(RecruiterId);
                                                //             print(Recruitername);
                                                //             print(Recruiterimg);
                                                //           }
                                                //           Ctreatechatinstance.CreateChat();
                                                //         },
                                                //       )
                                                //           : const SizedBox(),
                                                //       SizedBox(height: Get.height * .01,),
                                                //       GestureDetector(
                                                //           onTap:
                                                //               () {
                                                //             showPound(
                                                //                 context,
                                                //                 homeController.homeData.value.Seeker_Details?[index].recruiterDetails?.companyName,
                                                //                 "${homeController.homeData.value.Seeker_Details?[index].jobsDetail?.minSalaryExpectation / 20}".split(".")[0]);
                                                //           },
                                                //           child: Image
                                                //               .asset(
                                                //             "assets/images/icon_pound.png",
                                                //             height: Get.height *
                                                //                 .043,
                                                //           )),
                                                //     ],
                                                //   ),
                                                // ),
                                                Positioned(
                                                  bottom: Get.height *.12,
                                                  left: 12,
                                                  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                            color: const Color(0xff0D5AFE).withOpacity(.2),
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child:  Text(homeController.homeData.value.Seeker_Details?[index].seeker?.fullname ?? "",overflow: TextOverflow.ellipsis,
                                                          style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),),
                                                      ),
                                                      const SizedBox(height: 10,) ,
                                                      Container(
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                            color: const Color(0xff0D5AFE).withOpacity(.2),
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child:  Text(homeController.homeData.value.Seeker_Details?[index].positions ?? "No Position",overflow: TextOverflow.ellipsis,
                                                          style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),),
                                                      ),
                                                      const SizedBox(height: 10,) ,
                                                      Container(
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                            color: const Color(0xff0D5AFE).withOpacity(.2),
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child:  Text(homeController.homeData.value.Seeker_Details?[index].seeker?.location ?? "No location",overflow: TextOverflow.ellipsis,
                                                          style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),),
                                                      ),
                                                      const SizedBox(height: 10,) ,
                                                      SizedBox( width: Get.width,
                                                        child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                              onTap : () {
                                                                onSwipeLeft() ;
                                                              },
                                                              child: Container(
                                                                height: 50,
                                                                width: 50,
                                                                alignment: Alignment.center,
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape.circle ,
                                                                    color: AppColors.blueThemeColor),
                                                                child: const Icon(Icons.close , color: AppColors.white,),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                onSwipeRight() ;
                                                              },
                                                              child: Container(
                                                                height: 50,
                                                                width: 50,
                                                                margin: const EdgeInsets.only(right: 20),
                                                                alignment: Alignment.center,
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape.circle ,
                                                                    color: AppColors.blueThemeColor),
                                                                child: const Icon(Icons.done , color: AppColors.white,),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],),
                                                ),
                                              ],),
                                              SizedBox(height: Get.height * 0.025,),
                                              Container(
                                                  padding: const EdgeInsets.all(8),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.asset("assets/images/icon_phone_call.png",height: Get.height*.03,),
                                                          SizedBox(
                                                            width: Get.width * 0.02,
                                                          ),
                                                          Text("Phone Number",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.black),)
                                                        ],
                                                      ) ,
                                                      SizedBox(
                                                        height: Get.height * 0.015,
                                                      ),
                                                      const Divider(
                                                        thickness: 0.2,
                                                        color: AppColors.homeGrey,
                                                      ),
                                                      Text(homeController.homeData.value.Seeker_Details?[index].seeker?.mobile ?? "No phone number", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.black),) ,
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
                                                            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.black),
                                                            softWrap: true,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * 0.015,
                                                      ),
                                                      const Divider(
                                                        thickness: 0.2,
                                                        color: AppColors.homeGrey,
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * 0.02,
                                                      ),
                                                      HtmlWidget(
                                                        homeController.homeData.value.Seeker_Details?[index].seeker?.aboutMe ?? "No about",
                                                        textStyle: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge?.copyWith(color: AppColors.black),
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
                                                              style: Get.theme.textTheme.titleSmall?.copyWith(color: AppColors.black),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * 0.02,
                                                      ),
                                                      const Divider(
                                                        thickness: 0.2,
                                                        color: AppColors.homeGrey,
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * 0.02,
                                                      ),
                                                      homeController.homeData.value.Seeker_Details?[index].workExpJob == null ||
                                                          homeController.homeData.value.Seeker_Details?[index].workExpJob?.length == 0
                                                          ?  Text("No work experience",style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)))
                                                          : ListView.builder(
                                                          physics: const NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: homeController.homeData.value.Seeker_Details?[index].workExpJob?.length,
                                                          itemBuilder: (context, i) {
                                                            var data = homeController.homeData.value.Seeker_Details?[index].workExpJob?[i];
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
                                                                      color: AppColors.black,
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
                                                                      .bodyLarge?.copyWith(color: AppColors.black),
                                                                ),
                                                                // Text( CommonFunctions.parseHTML(data?.companyName ?? ""),style: Theme.of(context).textTheme.bodySmall!
                                                                //     .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                                                // ),
                                                                Text("$startDate  -  $endDate",
                                                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                      color: AppColors.black, fontWeight: FontWeight.w400),
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
                                                                  style: Get.theme.textTheme.titleSmall?.copyWith(color: AppColors.black),
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
                                                        color: AppColors.homeGrey,
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * 0.02,
                                                      ),
                                                      homeController.homeData.value.Seeker_Details?[index].educationLevel == null ||
                                                          homeController.homeData.value.Seeker_Details?[index].educationLevel?.length == 0
                                                          ? const Text("No Data")
                                                          : ListView.builder(
                                                          physics: const NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: homeController.homeData.value.Seeker_Details?[index].educationLevel?.length,
                                                          itemBuilder: (context, i) {
                                                            var data = homeController.homeData.value.Seeker_Details?[index].educationLevel?[i];
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
                                                                      color: AppColors.black,
                                                                      fontWeight: FontWeight.w700),
                                                                ),
                                                                SizedBox(
                                                                  height: Get.height * 0.001,
                                                                ),
                                                                Text(
                                                                  data?.institutionName ?? "",
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyLarge?.copyWith(color: AppColors.black),
                                                                ),
                                                                Text(
                                                                  "${data?.educationStartDate.month.toString().padLeft(2,"0").replaceAll("00:00:00.000", "")}-${data?.educationStartDate.day.toString().padLeft(2,"0").replaceAll("00:00:00.000", "")}-${data?.educationStartDate.year.toString().padLeft(4,"0").replaceAll("00:00:00.000", "")}  -  $endDate",
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyLarge?.copyWith(color: AppColors.black),
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
                                                                  style: Get.theme.textTheme.labelMedium?.copyWith(color: AppColors.black)
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
                                                        color: AppColors.homeGrey,
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * 0.03,
                                                      ),
                                                      Text("Soft Skills",
                                                        style: Theme.of(context).textTheme
                                                            .titleSmall?.copyWith(color: AppColors.black),
                                                      ),
                                                      SizedBox(height: Get.height*0.01,),
                                                      /////
                                                      homeController.homeData.value.Seeker_Details?[index].skillName == null ||
                                                          homeController.homeData.value.Seeker_Details?[index].skillName?.length == 0 ?
                                                      Text("No skills", style: Get.theme.textTheme.bodyLarge?.copyWith(color: AppColors.black),) :
                                                      GridView.builder(gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                          mainAxisExtent: 39,
                                                          maxCrossAxisExtent: Get.width * 0.35,
                                                          mainAxisSpacing: 6,
                                                          crossAxisSpacing: 6),
                                                          itemCount: homeController.homeData.value.Seeker_Details?[index].skillName?.length,
                                                          shrinkWrap: true,
                                                          physics: const NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context, i) {
                                                            return Container(
                                                              padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(20),
                                                                color: AppColors.homeGrey,
                                                              ),
                                                              child: Text(homeController.homeData.value.Seeker_Details?[index].skillName?[i].skills ?? "",
                                                                overflow: TextOverflow.ellipsis,
                                                                style: Get.theme.textTheme
                                                                    .bodySmall!.copyWith(
                                                                    color: AppColors.black,
                                                                    fontWeight: FontWeight.w400,fontSize: 9),),
                                                            );
                                                          }),
                                                      ///
                                                      SizedBox(height: Get.height*0.04,),
                                                      Text("Passion",
                                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.black),
                                                      ),
                                                      SizedBox(height: Get.height*0.01,),
                                                      homeController.homeData.value.Seeker_Details?[index].passionName == null ||
                                                          homeController.homeData.value.Seeker_Details?[index].passionName?.length == 0 ?
                                                      Text("No skills", style: Get.theme.textTheme.bodyLarge?.copyWith(color: AppColors.black),) :
                                                      GridView.builder(gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                          mainAxisExtent: 39,
                                                          maxCrossAxisExtent: Get.width * 0.35,
                                                          mainAxisSpacing: 6,
                                                          crossAxisSpacing: 6),
                                                          itemCount: homeController.homeData.value.Seeker_Details?[index].passionName?.length,
                                                          shrinkWrap: true,
                                                          physics: const NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context, i) {
                                                            //var data = seekerProfileController.viewSeekerData.value.seekerDetails?.skillName?[index];
                                                            return Container(
                                                              padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(20),
                                                                color: AppColors.homeGrey,
                                                              ),
                                                              // padding: const EdgeInsets.all(
                                                              //     8),
                                                              child: Text( homeController.homeData.value.Seeker_Details?[index].passionName?[i].passion  ?? '',
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                                style: Get.theme.textTheme
                                                                    .bodySmall!.copyWith(
                                                                    color: AppColors.black,
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
                                                            .titleSmall?.copyWith(color: AppColors.black),
                                                      ),
                                                      SizedBox(height: Get.height*0.01,),
                                                      homeController.homeData.value.Seeker_Details?[index].industryPreferenceName == null ||
                                                          homeController.homeData.value.Seeker_Details?[index].industryPreferenceName?.length == 0 ?
                                                      Text("No skills", style: Get.theme.textTheme.bodyLarge?.copyWith(color: AppColors.black),) :
                                                      GridView.builder(gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                          mainAxisExtent: 39,
                                                          maxCrossAxisExtent: Get.width * 0.35,
                                                          mainAxisSpacing: 6,
                                                          crossAxisSpacing: 6),
                                                          itemCount: homeController.homeData.value.Seeker_Details?[index].industryPreferenceName?.length,
                                                          shrinkWrap: true,
                                                          physics: const NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context, i) {
                                                            //var data = seekerProfileController.viewSeekerData.value.seekerDetails?.skillName?[index];
                                                            return Container(
                                                              padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(20),
                                                                color: AppColors.homeGrey,
                                                              ),
                                                              // padding: const EdgeInsets.all(
                                                              //     8),
                                                              child: Text(homeController.homeData.value.Seeker_Details?[index].industryPreferenceName?[i].industryPreferences ?? "",
                                                                overflow: TextOverflow.ellipsis,
                                                                style: Get.theme.textTheme.bodySmall!.copyWith(
                                                                    color: AppColors.black,
                                                                    fontWeight: FontWeight.w400,fontSize: 9),),
                                                            );
                                                          }),
                                                      SizedBox(height: Get.height * 0.04,),
                                                      Text("Strengths",
                                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.black),
                                                      ),
                                                      SizedBox(height: Get.height*0.01,),
                                                      homeController.homeData.value.Seeker_Details?[index].strengthsName == null ||
                                                          homeController.homeData.value.Seeker_Details?[index].strengthsName?.length == 0 ?
                                                      Text("No skills", style: Get.theme.textTheme.bodyLarge?.copyWith(color: AppColors.black),) :
                                                      GridView.builder(gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                          mainAxisExtent: 39,
                                                          maxCrossAxisExtent: Get.width * 0.35,
                                                          mainAxisSpacing: 6,
                                                          crossAxisSpacing: 6),
                                                          itemCount: homeController.homeData.value.Seeker_Details?[index].strengthsName?.length,
                                                          shrinkWrap: true,
                                                          physics: const NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context, i) {
                                                            return Container(
                                                              padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(20),
                                                                color: AppColors.homeGrey,
                                                              ),
                                                              // padding: const EdgeInsets.all(
                                                              //     8),
                                                              child: Text( homeController.homeData.value.Seeker_Details?[index].strengthsName?[i].strengths ?? '',
                                                                overflow: TextOverflow.ellipsis,
                                                                style: Get.theme.textTheme
                                                                    .bodySmall!.copyWith(
                                                                    color: AppColors.black,
                                                                    fontWeight: FontWeight.w400,fontSize: 9),),
                                                            );
                                                          }),
                                                      SizedBox(
                                                        height: Get.height * 0.04,
                                                      ),
                                                      Text("Salary expectation",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall?.copyWith(color: AppColors.black),
                                                      ),
                                                      SizedBox(height: Get.height*0.01,),
                                                      Container(decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
                                                          color: AppColors.homeGrey),
                                                        padding: const EdgeInsets.symmetric(horizontal : 20 ,vertical: 12),
                                                        child: Text('${ homeController.homeData.value.Seeker_Details?[index].minSalaryExpectation ?? ''} - ${ homeController.homeData.value.Seeker_Details?[index].maxSalaryExpectation ?? ''}',
                                                          overflow: TextOverflow.ellipsis,
                                                          style: Get.theme.textTheme.bodySmall!.copyWith(
                                                              color: AppColors.black,
                                                              fontWeight: FontWeight.w400),),
                                                      ),
                                                      SizedBox(height: Get.height * 0.04,),
                                                      Text(
                                                        "When can i start working?",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall?.copyWith(color: AppColors.black),
                                                      ),
                                                      SizedBox(height: Get.height*0.01,),
                                                      homeController.homeData.value.Seeker_Details?[index].startWorkName == null ||
                                                          homeController.homeData.value.Seeker_Details?[index].startWorkName?.length == 0 ?
                                                      Text("No skills", style: Get.theme.textTheme.bodyLarge?.copyWith(color: AppColors.black),) :
                                                      GridView.builder(gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                          mainAxisExtent: 39,
                                                          maxCrossAxisExtent: Get.width * 0.35,
                                                          mainAxisSpacing: 6,
                                                          crossAxisSpacing: 6),
                                                          itemCount:  homeController.homeData.value.Seeker_Details?[index].startWorkName?.length,
                                                          shrinkWrap: true,
                                                          physics: const NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context, i) {
                                                            return Container(
                                                              padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .circular(20),
                                                                color: AppColors.homeGrey,
                                                              ),
                                                              // padding: const EdgeInsets.all(
                                                              //     8),
                                                              child: Text(  homeController.homeData.value.Seeker_Details?[index].startWorkName?[i].startWork ?? '',
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                                style: Get.theme.textTheme
                                                                    .bodySmall!.copyWith(
                                                                    color: AppColors.black,
                                                                    fontWeight: FontWeight
                                                                        .w400,fontSize: 9),),
                                                            );
                                                          }),
                                                      SizedBox(height: Get.height * 0.04,),
                                                      Text(
                                                        "Availability",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall?.copyWith(color: AppColors.black),
                                                      ),
                                                      SizedBox(height: Get.height*0.01,),
                                                      homeController.homeData.value.Seeker_Details?[index].availabityName == null ||
                                                          homeController.homeData.value.Seeker_Details?[index].availabityName?.length == 0 ?
                                                      Text("No skills", style: Get.theme.textTheme.bodyLarge?.copyWith(color: AppColors.black),) :
                                                      GridView.builder(gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                          mainAxisExtent: 39,
                                                          maxCrossAxisExtent: Get.width * 0.35,
                                                          mainAxisSpacing: 6,
                                                          crossAxisSpacing: 6),
                                                          itemCount:   homeController.homeData.value.Seeker_Details?[index].availabityName?.length,
                                                          shrinkWrap: true,
                                                          physics: const NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context, i) {
                                                            return Container(
                                                              padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .circular(20),
                                                                color: AppColors.homeGrey,
                                                              ),
                                                              // padding: const EdgeInsets.all(
                                                              //     8),
                                                              child: Text(  homeController.homeData.value.Seeker_Details?[index].availabityName?[i].availabity ?? '',
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                                style: Get.theme.textTheme
                                                                    .bodySmall!.copyWith(
                                                                    color: AppColors.black,
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
                                                                  style: Get.theme.textTheme.titleSmall?.copyWith(color: AppColors.black),
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
                                                        color: AppColors.homeGrey,
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * 0.02,
                                                      ),
                                                      homeController.homeData.value.Seeker_Details?[index].language == null ||
                                                          homeController.homeData.value.Seeker_Details?[index].language?.length == 0
                                                          ?  Text("No language", style: Get.theme.textTheme.bodyLarge?.copyWith(color: AppColors.black),)
                                                          : GridView.builder(
                                                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                                              mainAxisExtent: 36,
                                                              maxCrossAxisExtent: Get.width * 0.4,
                                                              mainAxisSpacing: 8,
                                                              crossAxisSpacing: 8),
                                                          itemCount: homeController.homeData.value.Seeker_Details?[index].language?.length,
                                                          shrinkWrap: true,
                                                          physics: const NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context, i) {
                                                            var data = homeController.homeData.value.Seeker_Details?[index].language?[i];
                                                            return Container(
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(12),
                                                                color: AppColors.homeGrey,
                                                              ),
                                                              padding: const EdgeInsets.all(8),
                                                              child: Text(
                                                                '${data?.languages}',
                                                                overflow: TextOverflow.ellipsis,
                                                                style: Get.theme.textTheme.bodySmall!
                                                                    .copyWith(
                                                                    color: AppColors.black,
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
                                                                style: Get.theme.textTheme.titleSmall?.copyWith(color: AppColors.black),
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
                                                        color: AppColors.homeGrey,
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * 0.02,
                                                      ),
                                                      homeController.homeData.value.Seeker_Details?[index].appreciation == null ||
                                                          homeController.homeData.value.Seeker_Details?[index].appreciation?.length == 0
                                                          ?  Text("No appreciation", style: Get.theme.textTheme.bodyLarge?.copyWith(color: AppColors.black),)
                                                          : ListView.builder(
                                                          shrinkWrap: true,
                                                          physics: const NeverScrollableScrollPhysics(),
                                                          itemCount: homeController.homeData.value.Seeker_Details?[index].appreciation?.length,
                                                          itemBuilder: (context, i) {
                                                            var data = homeController.homeData.value.Seeker_Details?[index].appreciation?[i];
                                                            return Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  data?.achievement ?? "",
                                                                  style: Get.theme.textTheme.bodyMedium!
                                                                      .copyWith(
                                                                      color: AppColors.black,
                                                                      fontWeight: FontWeight.w700),
                                                                ),
                                                                SizedBox(
                                                                  height: Get.height * 0.001,
                                                                ),
                                                                Text(
                                                                  data?.awardName ?? "",
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyLarge?.copyWith(color: AppColors.black),
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
                                                                      jobTitleDialog(index) ;
                                                                    }, title: 'ACCEPT'),
                                                              ),
                                                            ),
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
                                    ),
                                    // CardSwiper(
                                    //   controller: controller,
                                    //   cardsCount: homeController.homeData.value.Seeker_Details?.length ?? 0,
                                    //   numberOfCardsDisplayed: homeController.homeData.value.Seeker_Details?.length == 1 ? 1 : 2,
                                    //   backCardOffset: const Offset(40, 40),
                                    //   padding: const EdgeInsets.all(24.0),
                                    //   onSwipe: _onSwipe,
                                    //   cardBuilder: (context, index,
                                    //       horizontalThresholdPercentage,
                                    //       verticalThresholdPercentage,) {
                                    //     return FindCandidateHomePageRecruiter(
                                    //       recruiterData: homeController.homeData.value.Seeker_Details?[index],
                                    //       titleList: jobTitleController.getJobTitleDetails.value.jobTitleList,);
                                    //   },
                                    // ),
                                  ),
                                ]),
                          ),
                        ),
                      );
                  }
                }
                );
            }
          }
          );
      }
    }
    );
  }

  bool _onSwipe(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction,
      ) {
    if(currentIndex != null ) {
      if (direction.name == "left") {
        print("swiped left");
      } else if (direction.name == "right") {
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
                          items: jobTitleController.getJobTitleDetails.value.jobTitleList?.map((item) =>
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
                                    applyJobController.applyJob(context,jobTitleID,seekerID: homeController.homeData.value.Seeker_Details?[previousIndex].seekerId.toString(),) ;
                                  }else {
                                    errorMessage.value = "Select Job before selecting" ;
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
        // CommonFunctions.confirmationDialog(context, message: "Do you want to Apply for the post", onTap: () {
        //   Get.back() ;
        //   CommonFunctions.showLoadingDialog(context, "Applying") ;
        //   // applyJobController.applyJob(homeController.homeData.value.Seeker_Details?[previousIndex].id.toString()) ;
        // }) ;
      }
      // else if (direction.name == "top") {
      //   CommonFunctions.confirmationDialog(context, message: "Do you want to save the post", onTap: () {
      //     Get.back() ;
      //     CommonFunctions.showLoadingDialog(context, "Saving") ;
      //   }) ;
      // }
      debugPrint(
        'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
      );
    }
    return true;

  }

  void onSwipeLeft() {
    setState(() {
      if(_currentPage < homeController.homeData.value.Seeker_Details!.length - 1) {
        _currentPage++;
      }else{
        _currentPage = 0 ;
      }
      _pageController.jumpToPage(_currentPage) ;
    });
    if (kDebugMode) {
      print('Swiped to the left');
    }
  }

  Future<void> onSwipeRight() async {
    // CommonFunctions.confirmationDialog(context, message: "Do you want to apply", onTap: () async {
    //   Get.back() ;
    //   var result = await showReferralSubmissionDialog(context, _currentPage) ;
    //   if(result == true) {
    //     setState(() {
    //       if(_currentPage < homeController.homeData.value.Seeker_Details!.length - 1) {
    //         _currentPage++;
    //       }else{
    //         _currentPage = 0 ;
    //       }
    //       _pageController.jumpToPage(_currentPage) ;
    //     });
    //   }
    // }) ;
    if (kDebugMode) {
      print('Swiped to the right');
    }
  }

  jobTitleDialog (int index ) {
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
                          items: jobTitleController.getJobTitleDetails.value.jobTitleList?.map((item) =>
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
                                      applyJobController.applyJob(context,jobTitleID,seekerID: homeController.homeData.value.Seeker_Details?[index].seekerId.toString(),) ;
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
