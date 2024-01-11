import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/controllers/SeekerJobFilterController/SeekerJobFilterController.dart';
import 'package:flikka/controllers/SeekerSavedJobsController/SeekerSavedJobsController.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../chatseeker/CreateChat.dart';
import '../../controllers/ApplyJobController/ApplyJobController.dart';
import '../../controllers/GetJobsListingController/GetJobsListingController.dart';
import '../../controllers/SeekerUnSavePostController/SeekerUnSavePostController.dart';
import '../../models/GetJobsListingModel/GetJobsListingModel.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../utils/VideoPlayerScreen.dart';
import '../../widgets/google_map_widget.dart';
import '../../widgets/my_button.dart';
import '../SeekerBottomNavigationBar/TabBarController.dart';
import '../SeekerFilter/filter_page.dart';
import '../SeekerDrawer/Drawer_page.dart';
import '../SeekerJobs/no_job_available.dart';
import 'package:get/get.dart';

String? Recruitername;
String? Recruiterimg;

class FindJobHomeScreen extends StatefulWidget {
  const FindJobHomeScreen({super.key});

  @override
  State<FindJobHomeScreen> createState() => FindJobHomeScreenState();
}

class FindJobHomeScreenState extends State<FindJobHomeScreen> {
  final CardSwiperController controller = CardSwiperController();

  List<CardSwiperDirection> allDirections = CardSwiperDirection.values;

  //////refresh//////
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    getJobsListingController.seekerGetAllJobsApi();
    jobFilterController.reset(true);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    getJobsListingController.seekerGetAllJobsApi();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }
  /////refresh/////

  final Ctreatechat Ctreatechatinstance = Ctreatechat();

  var years = '';
  var months = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

 static bool showBottomBar = true;
  int _currentPage = 0;
  Timer? _scrollTimer;
  double _previousScrollOffset = 0.0;
  double _appBarOpacity = 0.0;

  TabBarController tabBarController = Get.put(TabBarController());
  GetJobsListingController getJobsListingController = Get.put(GetJobsListingController());
  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController());
  SeekerSaveJobController seekerSaveJobController = Get.put(SeekerSaveJobController());
  ApplyJobController applyJobController = Get.put(ApplyJobController());
  SeekerJobFilterController jobFilterController = Get.put(SeekerJobFilterController());
  SeekerUnSavePostController unSavePostController = Get.put(SeekerUnSavePostController());
  GetJobsListingModel jobModel = GetJobsListingModel();
  // final Ctreatechat Ctreatechatinstance = Ctreatechat();
  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });

    _scrollController.addListener(() {
      setState(() {
        _appBarOpacity = _scrollController.offset > 150 ? 1.0 : _scrollController.offset / 150;
      });
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        tabBarController.showBottomBar(true);
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        tabBarController.showBottomBar(false);
      }
      if (_scrollTimer != null && _scrollTimer!.isActive) {
        // If the timer is active, cancel it (user is still scrolling)
        _scrollTimer!.cancel();
      }
      // Start a new timer when scrolling stops
      _scrollTimer = Timer(Duration(milliseconds: 150), () {
        if(_scrollController.position.pixels - _previousScrollOffset >= 50 || _previousScrollOffset - _scrollController.position.pixels >= 50  ) {
          print("scrolled") ;
        }
        setState(() {
          // Update _previousScrollOffset once scrolling stops
          _previousScrollOffset = _scrollController.position.pixels;
          print("Scroll Ended. Previous Offset: $_previousScrollOffset");
        });
      });
    });
    super.initState();
  }
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();


  var last = false;
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
                  endDrawer: DrawerClass(
                    name: '${seekerProfileController.viewSeekerData.value.seekerInfo?.fullname}',
                    location: '${seekerProfileController.viewSeekerData.value.seekerInfo?.location}',
                    jobTitle: '${seekerProfileController.viewSeekerData.value.seekerDetails?.positions ?? ''}',
                    profileImage: '${seekerProfileController.viewSeekerData.value.seekerInfo?.profileImg}',
                  ),
                  body: Obx(() {
                    return SmartRefresher(
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: SafeArea(
                        child: GestureDetector(
                          onTap: () {
                            if (Scaffold.of(context).isEndDrawerOpen) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Stack(
                            children: [
                              last
                                  ? const SeekerNoJobAvailable()
                                  : getJobsListingController.getJobsListing.value.jobs?.length == 0 ||
                                          getJobsListingController.getJobsListing.value.jobs == null
                                      ? const SeekerNoJobAvailable() :
                                      // : Obx(() => jobFilterController.reset.value
                                      //         ?
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
                                            itemCount: getJobsListingController.getJobsListing.value.jobs?.length,
                                            itemBuilder: (context, index) {
                                              if( getJobsListingController.getJobsListing.value.jobs?[index].workExperience != null &&  getJobsListingController.getJobsListing.value.jobs?[index].workExperience.toString().length != 0) {
                                                var experience = getJobsListingController.getJobsListing.value.jobs?[index].workExperience.toString().split(".");
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
                                                controller: _scrollController,
                                                child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Stack(children: [
                                                      CachedNetworkImage(imageUrl: getJobsListingController.getJobsListing.value.jobs?[index].featureImg ?? "" ,
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
                                                        right: 20,
                                                        top: Get.height * 0.13,
                                                        child: Stack(
                                                          children: [
                                                            GestureDetector(
                                                              onTap:
                                                                  () {
                                                                showSeekerHomePagePercentageProfile(context, getJobsListingController.getJobsListing.value.jobs?[index]);
                                                              },
                                                              child:
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(50),
                                                                    border: Border.all(color: AppColors.white, width: 2)),
                                                                child:
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets.all(3.0),
                                                                  child: Container(
                                                                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.blueThemeColor),
                                                                      child: CircleAvatar(
                                                                          radius: 30,
                                                                          backgroundColor: Colors.transparent,
                                                                          child: Center(
                                                                            child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Text('${getJobsListingController.getJobsListing.value.jobs?[index].jobMatchPercentage}%', style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white)),
                                                                                Text('match', style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white, fontSize: 7)),
                                                                              ],
                                                                            ),
                                                                          ))),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 12,
                                                        top: Get.height * 0.13,
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
                                                                  height: Get.height * .043,
                                                                )
                                                                    : Image.asset(
                                                                  "assets/images/icon_Save_post.png",
                                                                  height: Get.height * .043,
                                                                )),
                                                            SizedBox(
                                                              height: Get.height *
                                                                  .01,
                                                            ),
                                                            GestureDetector(
                                                                onTap:
                                                                    () {
                                                                  Get.to(() => const FilterPage());
                                                                },
                                                                child:
                                                                Image.asset(
                                                                  "assets/images/icon_filter_seeker_home.png",
                                                                  height:
                                                                  Get.height * .043,
                                                                )),
                                                            SizedBox(height: Get.height * .01,),
                                                            GestureDetector(
                                                              onTap:
                                                                  () {
                                                                if (getJobsListingController.getJobsListing.value.jobs?[index].video == null ||
                                                                    getJobsListingController.getJobsListing.value.jobs?[index].video?.length == 0) {
                                                                  Utils.showMessageDialog(context,
                                                                      "video not uploaded yet");
                                                                } else {
                                                                  Get.back();
                                                                  Get.to(() =>
                                                                      VideoPlayerScreen(videoPath: getJobsListingController.getJobsListing.value.jobs?[index]?.video ?? ""));
                                                                }
                                                              },
                                                              child:
                                                              Container(
                                                                alignment:
                                                                Alignment.center,
                                                                height:
                                                                34,
                                                                width:
                                                                34,
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: AppColors.blueThemeColor),
                                                                child:
                                                                Image.asset(
                                                                  "assets/images/icon_video.png",
                                                                  height:
                                                                  18,
                                                                  fit:
                                                                  BoxFit.cover,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: Get.height * .01,),
                                                            getJobsListingController.getJobsListing.value.jobs?[index].jobMatchPercentage == 100
                                                                ? InkWell(
                                                              child: Container(
                                                                alignment: Alignment.center,
                                                                height: 34,
                                                                width: 34,
                                                                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.blueThemeColor),
                                                                child: Image.asset(
                                                                  'assets/images/icon_msg_blue.png',
                                                                  height: Get.height * .06,
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                RecruiterId = getJobsListingController.getJobsListing.value.jobs?[index].recruiterId.toString();
                                                                Recruitername = getJobsListingController.getJobsListing.value.jobs?[index].recruiterDetails?.companyName;
                                                                Recruiterimg = getJobsListingController.getJobsListing.value.jobs?[index].recruiterDetails?.profileImg;

                                                                setState(() {
                                                                  RecruiterId;
                                                                  Recruitername;
                                                                  Recruiterimg;
                                                                });
                                                                if (kDebugMode) {
                                                                  print(RecruiterId);
                                                                  print(Recruitername);
                                                                  print(Recruiterimg);
                                                                }
                                                                Ctreatechatinstance.CreateChat();
                                                              },
                                                            )
                                                                : const SizedBox(),
                                                            SizedBox(height: Get.height * .01,),
                                                            GestureDetector(
                                                                onTap:
                                                                    () {
                                                                  showPound(
                                                                      context,
                                                                      getJobsListingController.getJobsListing.value.jobs?[index].recruiterDetails?.companyName,
                                                                      "${getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.minSalaryExpectation / 20}".split(".")[0]);
                                                                },
                                                                child: Image
                                                                    .asset(
                                                                  "assets/images/icon_pound.png",
                                                                  height: Get.height *
                                                                      .043,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: Get.height *.15,
                                                        left: 12,
                                                        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                          Container(
                                                            padding: const EdgeInsets.all(8),
                                                            decoration: BoxDecoration(
                                                              color: const Color(0xff0D5AFE).withOpacity(.2),
                                                              borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child:  Text(getJobsListingController.getJobsListing.value.jobs?[index].jobPositions ?? "No job position",overflow: TextOverflow.ellipsis,
                                                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),),
                                                          ),
                                                          const SizedBox(height: 10,) ,
                                                          Container(
                                                            padding: const EdgeInsets.all(8),
                                                            decoration: BoxDecoration(
                                                              color: const Color(0xff0D5AFE).withOpacity(.2),
                                                              borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child:  Text(getJobsListingController.getJobsListing.value.jobs?[index].recruiterDetails?.companyName ?? "No company name",overflow: TextOverflow.ellipsis,
                                                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),),
                                                          ),
                                                          const SizedBox(height: 10,) ,
                                                          Container(
                                                            padding: const EdgeInsets.all(8),
                                                            decoration: BoxDecoration(
                                                              color: const Color(0xff0D5AFE).withOpacity(.2),
                                                              borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child:  Text(getJobsListingController.getJobsListing.value.jobs?[index].jobLocation ?? "No job location",overflow: TextOverflow.ellipsis,
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
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(getJobsListingController.getJobsListing.value.jobs?[index].jobTitle ?? "No job title", overflow: TextOverflow.ellipsis,
                                                            style:  Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.black),),
                                                          SizedBox(height: Get.height * 0.004,),
                                                          Text(getJobsListingController.getJobsListing.value.jobs?[index].jobPositions ?? "No job position",overflow: TextOverflow.ellipsis,
                                                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),),
                                                          SizedBox(height: Get.height * 0.004,),
                                                          Text("${getJobsListingController.getJobsListing.value.jobs?[index].recruiterDetails?.companyName ?? "No company name"}", overflow: TextOverflow.ellipsis,
                                                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),),
                                                          SizedBox(height: Get.height * 0.03,),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                             Image.asset("assets/images/icon_job_description.png",height: Get.height*.03,),
                                                              SizedBox(width: Get.width*.02,) ,
                                                              Text("Job Description",
                                                                style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
                                                            ],
                                                          ),
                                                          SizedBox(height: Get.height * 0.015,),
                                                          getJobsListingController.getJobsListing.value.jobs?[index].description == null || CommonFunctions.parseHTML(getJobsListingController.getJobsListing.value.jobs?[index].description).toString().trim().length == 0 ?
                                                          Text("No job description",style: Theme.of(context).textTheme.labelLarge!
                                                              .copyWith(color: AppColors.black,fontWeight: FontWeight.w400),) :
                                                          HtmlWidget(getJobsListingController.getJobsListing.value.jobs?[index].description ?? 'No job description',textStyle:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black) ,),
                                                          SizedBox(height: Get.height * 0.03,),
                                                          Row(
                                                            children: [
                                                              Image.asset("assets/images/icon_requirment.png",height: Get.height*.03,),
                                                              SizedBox(width: Get.width*.02,) ,
                                                              Text("Requirements", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
                                                            ],
                                                          ),
                                                          SizedBox(height: Get.height * 0.015,),
                                                          getJobsListingController.getJobsListing.value.jobs?[index].requirements == null || CommonFunctions.parseHTML(getJobsListingController.getJobsListing.value.jobs?[index].requirements).toString().trim().length == 0 ?
                                                          Text("No requirements",style: Theme.of(context).textTheme.labelLarge!
                                                              .copyWith(color: AppColors.black,fontWeight: FontWeight.w400),) :
                                                          HtmlWidget(getJobsListingController.getJobsListing.value.jobs?[index].requirements ?? 'No requirements',textStyle: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),),
                                                          SizedBox(height: Get.height * 0.025,),
                                                          Row(
                                                            children: [
                                                              Image.asset("assets/images/icon_location_seeker.png",height: Get.height*.03,),
                                                              SizedBox(width: Get.width*.02,) ,
                                                              Text("Locations", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
                                                            ],
                                                          ),
                                                          SizedBox(height: Get.height * 0.015,),
                                                          Text(getJobsListingController.getJobsListing.value.jobs?[index].jobLocation ?? "No job location",overflow: TextOverflow.ellipsis, style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),),
                                                          SizedBox(height: Get.height * 0.015,),
                                                          InkWell(
                                                            // onTap: () {
                                                            // Get.to( GoogleMapIntegration(jobPageView: true,lat: double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].lat}"),long:  double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].long}")));},
                                                              child: SizedBox( height: Get.height * 0.3,
                                                                  child: GoogleMapIntegration(jobPageView: true,lat: double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].lat}"),long:  double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].long}"),))),
                                                          SizedBox(height: Get.height * 0.035,),
                                                          Row(
                                                            children: [
                                                              Image.asset("assets/images/icon_information.png",height: Get.height*.03,),
                                                              SizedBox(width: Get.width*.02,) ,
                                                              Text("Information", style:Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
                                                            ],
                                                          ),
                                                          SizedBox(height: Get.height * 0.015,),
                                                          Text("Position", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
                                                          SizedBox(height: Get.height * 0.015,),
                                                          Container(
                                                            padding: const EdgeInsets.all(8),
                                                            decoration: BoxDecoration(
                                                                color: AppColors.homeGrey,
                                                                borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child: Text(getJobsListingController.getJobsListing.value.jobs?[index].jobPositions ?? "No position",
                                                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),),
                                                          ),
                                                          const Divider(color: Colors.grey, thickness: 0.2,),
                                                          const Text("Qualification",
                                                            style: TextStyle(color: AppColors.black, fontSize: 14),),
                                                          SizedBox(height: Get.height * 0.015,),
                                                          getJobsListingController.getJobsListing.value.jobs?[index].education.toString().toLowerCase() == "null" ||
                                                              getJobsListingController.getJobsListing.value.jobs?[index].education.toString().length == 0
                                                              ? Text("No qualification", style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
                                                          Container(
                                                            padding: const EdgeInsets.all(8),
                                                            decoration: BoxDecoration(
                                                                color: AppColors.homeGrey,
                                                                borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child: Text(
                                                              getJobsListingController.getJobsListing.value.jobs?[index].education ?? "",
                                                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),
                                                            ),
                                                          ),
                                                          const Divider(
                                                            color: Colors.grey,
                                                            thickness: 0.2,
                                                          ),
                                                          const Text("Experience",
                                                            style: TextStyle(color: AppColors.black, fontSize: 14),),
                                                          SizedBox(height: Get.height * 0.015,),
                                                          Container(  padding: const EdgeInsets.all(8),
                                                            decoration: BoxDecoration(
                                                                color: AppColors.homeGrey,
                                                                borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child: years.toString().length == 0 && months.toString().length == 0 ? Text("No experience", style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black)) :
                                                            Text("${years ?? ""} ${ months ?? ""}", style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),
                                                            ),
                                                          ),
                                                          const Divider(
                                                            color: Colors.grey,
                                                            thickness: 0.2,
                                                          ),
                                                          const Text("Job Type", style: TextStyle(color: AppColors.black, fontSize: 14),),
                                                          SizedBox(height: Get.height * 0.015,),
                                                          Container( padding: const EdgeInsets.all(8),
                                                            decoration: BoxDecoration(
                                                                color: AppColors.homeGrey,
                                                                borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child: Text(getJobsListingController.getJobsListing.value.jobs?[index].employmentType ?? "No job type",
                                                              style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),),
                                                          ),
                                                          const Divider(color: Colors.grey, thickness: 0.2,),
                                                          const Text("Specialization", style: TextStyle(color: AppColors.black, fontSize: 14),),
                                                          SizedBox(height: Get.height * 0.015,),
                                                          Container( padding: const EdgeInsets.all(8),
                                                            decoration: BoxDecoration(
                                                                color: AppColors.homeGrey,
                                                                borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child: Text(getJobsListingController.getJobsListing.value.jobs?[index].specialization ?? "No specialization",
                                                              style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),),
                                                          ),
                                                          const Divider(color: Colors.grey, thickness: 0.2,),
                                                          const Text("Type of workplace",
                                                            style: TextStyle(color: AppColors.black, fontSize: 14),),
                                                          SizedBox(height: Get.height * 0.015,),
                                                          Container( padding: const EdgeInsets.all(8),
                                                            decoration: BoxDecoration(
                                                                color: AppColors.homeGrey,
                                                                borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child: Text(getJobsListingController.getJobsListing.value.jobs?[index].typeOfWorkplace ?? "No workplace",
                                                              style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),),
                                                          ),
                                                          const Divider(color: Colors.grey, thickness: 0.2,),
                                                          const Text("Preferred work experience",
                                                            style: TextStyle(color: AppColors.black, fontSize: 14),
                                                          ),
                                                          SizedBox(height: Get.height * 0.015,),
                                                          Container( padding: const EdgeInsets.all(8),
                                                            decoration: BoxDecoration(
                                                                color: AppColors.homeGrey,
                                                                borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child: Text(
                                                              getJobsListingController.getJobsListing.value.jobs?[index].preferredWorkExperience ?? "No preferred work experience",
                                                              style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),
                                                            ),
                                                          ),
                                                          const Divider(
                                                            color: Colors.grey,
                                                            thickness: 0.2,
                                                          ),
                                                          const Text("Language", style: TextStyle(color: AppColors.black, fontSize: 14),),
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
                                                                    style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),
                                                                  ),),
                                                            ],),
                                                          SizedBox(height: Get.height * .02,),
                                                          Row(
                                                            children: [
                                                              Image.asset("assets/images/skillsvg.png",height: Get.height*.03,),
                                                              SizedBox(width: Get.width*.02,) ,
                                                              Text("Skills", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
                                                            ],
                                                          ),
                                                          const Divider(
                                                            color: Colors.grey,
                                                            thickness: 0.2,
                                                          ),
                                                          Text("Soft Skills",
                                                            style: Theme.of(context).textTheme.titleSmall!
                                                                .copyWith(color: AppColors.black),
                                                          ),
                                                          SizedBox(height: Get.height*0.01,),
                                                          getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.skillName == null ||
                                                              getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.skillName?.length == 0 ?
                                                          Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
                                                          Wrap(
                                                            spacing: 6.0,
                                                            runSpacing: 6.0,
                                                            alignment: WrapAlignment.start,
                                                            crossAxisAlignment: WrapCrossAlignment.start,
                                                            children: List.generate(
                                                              getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.skillName?.length ?? 0,
                                                                  (i) {
                                                                return Container(
                                                                  padding: const EdgeInsets.all(8),
                                                                  decoration: BoxDecoration(
                                                                    color: AppColors.homeGrey,
                                                                    borderRadius: BorderRadius.circular(10),
                                                                  ),
                                                                  child: Text(
                                                                      getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.skillName?[i].skills ?? "",
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black)
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(height: Get.height*0.04,),
                                                          Text("Passion",
                                                            style: Theme.of(context).textTheme.titleSmall!
                                                                .copyWith(color: AppColors.black),
                                                          ),
                                                          SizedBox(height: Get.height*0.01,),
                                                          getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.passionName == null ||
                                                              getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.passionName?.length == 0 ?
                                                          Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
                                                          Wrap(
                                                            spacing: 6.0,
                                                            runSpacing: 6.0,
                                                            alignment: WrapAlignment.start,
                                                            crossAxisAlignment: WrapCrossAlignment.start,
                                                            children: List.generate(
                                                              getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.passionName?.length ?? 0,
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
                                                                      style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black)
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(height: Get.height * 0.04,),
                                                          Text(
                                                            "industry preference",
                                                            style: Theme.of(context).textTheme.titleSmall!
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
                                                                      style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black)
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(height: Get.height * 0.04,),
                                                          Text("Strengths",
                                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.black),),
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
                                                                      style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black)
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(height: Get.height * 0.04,),
                                                          Text("Salary expectation",
                                                            style: Theme.of(context).textTheme.titleSmall!
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
                                                              style: Get.theme.textTheme.bodySmall!.copyWith(
                                                                color: AppColors.black,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: Get.height * 0.04,),
                                                          Text("When can i start working?",
                                                            style: Theme.of(context).textTheme.titleSmall!
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
                                                                      style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black)
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(height: Get.height * 0.04,),
                                                          Text("Availability",
                                                            style: Theme.of(context).textTheme.titleSmall!
                                                                .copyWith(color: AppColors.black),
                                                          ),
                                                          SizedBox(height: Get.height * 0.01,),
                                                          getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.availabityName == null ||
                                                              getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.availabityName?.length == 0 ?
                                                          Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
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
                                                                      style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black)
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(height: Get.height * 0.055,),
                                                          Center(
                                                            child: Obx( () => MyButton(
                                                                title: getJobsListingController.getJobsListing.value.jobs?[index].postApplied == true ? "APPLIED" : "APPLY NOW",
                                                                onTap1: () async {
                                                                  if(getJobsListingController.getJobsListing.value.jobs?[index].postApplied == true ){}else{
                                                                    applyJobController.errorMessageApplyReferral.value = "" ;
                                                                    showReferralSubmissionDialog(context,index) ;
                                                                  }
                                                                }
                                                            ),
                                                            ),
                                                          ),
                                                          SizedBox(height: Get.height*.025,),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          ),
                                              // : jobFilterController.jobsData.value.jobs?.length == 0 ||
                                              //         jobFilterController.jobsData.value.jobs == null
                                              //     ? const SeekerNoJobAvailable()
                                              //     : CardSwiper(
                                              //         controller: controller,
                                              //         cardsCount: jobFilterController.jobsData.value.jobs?.length ?? 0,
                                              //         numberOfCardsDisplayed: jobFilterController.jobsData.value.jobs?.length == 1 ? 1 : 2,
                                              //         backCardOffset: const Offset(40, 40),
                                              //         padding: const EdgeInsets.all(24.0),
                                              //         allowedSwipeDirection: AllowedSwipeDirection.only(left: true, right: true, up: true),
                                              //         onSwipe: _onSwipe,
                                              //         cardBuilder: (context, index, horizontalThresholdPercentage, verticalThresholdPercentage,
                                              //         ) {
                                              //           var data = jobFilterController.jobsData.value.jobs?[index];
                                              //           return Container(
                                              //             decoration: BoxDecoration(
                                              //                 color: AppColors.blackdown,
                                              //                 borderRadius: BorderRadius.circular(34)),
                                              //             height: Get.height,
                                              //             width: Get.width,
                                              //             child: Stack(
                                              //               children: [
                                              //                 //************* for swiper image ************
                                              //                 GestureDetector(
                                              //                   onTap: () {
                                              //                     Get.to(() =>
                                              //                         MarketingIntern(
                                              //                           jobData: data,
                                              //                           appliedJobScreen: false,
                                              //                         ));
                                              //                   },
                                              //                   child:
                                              //                       Container(
                                              //                     decoration: BoxDecoration(
                                              //                         borderRadius:
                                              //                             BorderRadius.circular(26)),
                                              //                     width: Get.width,
                                              //                     height: Get.height * 0.5,
                                              //                     child: ClipRRect(
                                              //                         borderRadius: BorderRadius.circular(20),
                                              //                         child: CachedNetworkImage(
                                              //                             fit: BoxFit.cover,
                                              //                             placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                              //                             imageUrl: "${data?.featureImg}")),
                                              //                   ),
                                              //                 ),
                                              //                 //************* for 50% match ************
                                              //                 Positioned(
                                              //                   right: 20,
                                              //                   top: 10,
                                              //                   child: Stack(
                                              //                     children: [
                                              //                       GestureDetector(
                                              //                         onTap:
                                              //                             () {
                                              //                           showSeekerHomePagePercentageProfile(context, data);
                                              //                         },
                                              //                         child:
                                              //                             Container(
                                              //                           decoration: BoxDecoration(
                                              //                               borderRadius: BorderRadius.circular(50),
                                              //                               border: Border.all(color: AppColors.white, width: 2)),
                                              //                           child:
                                              //                               Padding(
                                              //                             padding:
                                              //                                 const EdgeInsets.all(3.0),
                                              //                             child: Container(
                                              //                                 decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.blueThemeColor),
                                              //                                 child: CircleAvatar(
                                              //                                     radius: 30,
                                              //                                     backgroundColor: Colors.transparent,
                                              //                                     child: Center(
                                              //                                       child: Column(
                                              //                                         mainAxisAlignment: MainAxisAlignment.center,
                                              //                                         children: [
                                              //                                           Text('${data?.jobMatchPercentage}%', style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white)),
                                              //                                           Text('match', style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white, fontSize: 7)),
                                              //                                         ],
                                              //                                       ),
                                              //                                     ))),
                                              //                           ),
                                              //                         ),
                                              //                       )
                                              //                     ],
                                              //                   ),
                                              //                 ),
                                              //                 //************* for bookmarks ************
                                              //
                                              //                 Positioned(
                                              //                   left: 12,
                                              //                   top: 15,
                                              //                   child: Column(
                                              //                     children: [
                                              //                       GestureDetector(
                                              //                           onTap:
                                              //                               () {
                                              //                             // getJobsListingController.saved.value=true;
                                              //                             CommonFunctions.confirmationDialog(context,
                                              //                                 message: jobFilterController.jobsData.value.jobs?[index].postSaved ? "Do you want to remove the\n post from saved posts" : "Do you want to save the post",
                                              //                                 onTap: () async {
                                              //                               Get.back();
                                              //                               if (data?.postSaved == true) {
                                              //                                 CommonFunctions.showLoadingDialog(context, "removing...");
                                              //                                 var result = await unSavePostController.unSavePost(data?.id.toString(), "1", context, true);
                                              //                                 if (result == true) {
                                              //                                   if (kDebugMode) {
                                              //                                     print("inside result");
                                              //                                   }
                                              //                                   jobFilterController.jobsData.value.jobs?[index].postSaved = false;
                                              //                                   setState(() {});
                                              //                                 }
                                              //                               } else {
                                              //                                 CommonFunctions.showLoadingDialog(context, "Saving");
                                              //                                 var result = await seekerSaveJobController.saveJobApi(data?.id, 1);
                                              //                                 if (result == true) {
                                              //                                   if (kDebugMode) {
                                              //                                     print("inside result");
                                              //                                   }
                                              //                                   jobFilterController.jobsData.value.jobs?[index].postSaved = true;
                                              //                                   setState(() {});
                                              //                                 }
                                              //                               }
                                              //                             });
                                              //                           },
                                              //                           child: jobFilterController.jobsData.value.jobs?[index].postSaved == false
                                              //                               ? Image.asset(
                                              //                                   "assets/images/icon_unsave_post.png",
                                              //                                   height: Get.height * .043,
                                              //                                 )
                                              //                               : Image.asset(
                                              //                                   "assets/images/icon_Save_post.png",
                                              //                                   height: Get.height * .043,
                                              //                                 )),
                                              //                       SizedBox(
                                              //                         height: Get.height *
                                              //                             .01,
                                              //                       ),
                                              //                       GestureDetector(
                                              //                           onTap:
                                              //                               () {
                                              //                             Get.to(() =>
                                              //                                 const FilterPage());
                                              //                           },
                                              //                           child:
                                              //                               Image.asset(
                                              //                             "assets/images/icon_filter_seeker_home.png",
                                              //                             height:
                                              //                                 Get.height * .043,
                                              //                           )),
                                              //                       SizedBox(
                                              //                         height: Get.height *
                                              //                             .01,
                                              //                       ),
                                              //                       GestureDetector(
                                              //                         onTap:
                                              //                             () {
                                              //                           if (data?.video == null ||
                                              //                               data?.video?.length == 0) {
                                              //                             Utils.showMessageDialog(context,
                                              //                                 "video not uploaded yet");
                                              //                           } else {
                                              //                             Get.back();
                                              //                             Get.to(() =>
                                              //                                 VideoPlayerScreen(videoPath: data?.video ?? ""));
                                              //                           }
                                              //                         },
                                              //                         child:
                                              //                             Container(
                                              //                           alignment:
                                              //                               Alignment.center,
                                              //                           height:
                                              //                               34,
                                              //                           width:
                                              //                               34,
                                              //                           decoration: const BoxDecoration(
                                              //                               shape: BoxShape.circle,
                                              //                               color: AppColors.blueThemeColor),
                                              //                           child:
                                              //                               Image.asset(
                                              //                             "assets/images/icon_video.png",
                                              //                             height:
                                              //                                 18,
                                              //                             fit:
                                              //                                 BoxFit.cover,
                                              //                           ),
                                              //                         ),
                                              //                       ),
                                              //                       data?.jobMatchPercentage ==
                                              //                               100
                                              //                           ? InkWell(
                                              //                               child: Container(
                                              //                                 alignment: Alignment.center,
                                              //                                 height: 34,
                                              //                                 width: 34,
                                              //                                 decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.blueThemeColor),
                                              //                                 child: Image.asset(
                                              //                                   'assets/images/icon_msg_blue.png',
                                              //                                   height: Get.height * .06,
                                              //                                 ),
                                              //                               ),
                                              //                               onTap: () {
                                              //                                 RecruiterId = data?.recruiterId.toString();
                                              //                                 Recruitername = data?.recruiterDetails?.companyName;
                                              //                                 Recruiterimg = data?.recruiterDetails?.profileImg;
                                              //
                                              //                                 setState(() {
                                              //                                   RecruiterId;
                                              //                                   Recruitername;
                                              //                                   Recruiterimg;
                                              //                                 });
                                              //                                 if (kDebugMode) {
                                              //                                   print(RecruiterId);
                                              //                                   print(Recruitername);
                                              //                                   print(Recruiterimg);
                                              //                                 }
                                              //                                 Ctreatechatinstance.CreateChat();
                                              //                               },
                                              //                             )
                                              //                           : const SizedBox(),
                                              //                     ],
                                              //                   ),
                                              //                 ),
                                              //                 //************* for marketing intern text  ************
                                              //                 Positioned(
                                              //                   //height: Get.height / 2.5-Get.height*0.12 ,
                                              //                   bottom:
                                              //                       Get.height *
                                              //                           0.05,
                                              //                   left: 0,
                                              //                   right: 0,
                                              //                   child:
                                              //                       GestureDetector(
                                              //                     onTap: () {
                                              //                       Get.to(() =>
                                              //                           MarketingIntern(
                                              //                             jobData:
                                              //                                 data,
                                              //                             appliedJobScreen:
                                              //                                 false,
                                              //                           ));
                                              //                     },
                                              //                     child:
                                              //                         Container(
                                              //                       height: Get
                                              //                               .height *
                                              //                           0.35,
                                              //                       padding: const EdgeInsets
                                              //                           .all(
                                              //                           20),
                                              //                       decoration:
                                              //                           const BoxDecoration(
                                              //                         color: AppColors
                                              //                             .blackdown,
                                              //                         borderRadius: BorderRadius.only(
                                              //                             topLeft:
                                              //                                 Radius.circular(22),
                                              //                             topRight: Radius.circular(22)),
                                              //                       ),
                                              //                       child:
                                              //                           SingleChildScrollView(
                                              //                         child:
                                              //                             Column(
                                              //                           crossAxisAlignment:
                                              //                               CrossAxisAlignment.start,
                                              //                           children: [
                                              //                             Text(
                                              //                               data?.jobTitle ?? "",
                                              //                               overflow: TextOverflow.ellipsis,
                                              //                               style: Theme.of(context).textTheme.displayLarge,
                                              //                             ),
                                              //                             SizedBox(
                                              //                               height: Get.height * .003,
                                              //                             ),
                                              //                             Text(
                                              //                               data?.jobPositions ?? "",
                                              //                               overflow: TextOverflow.ellipsis,
                                              //                               style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),
                                              //                               softWrap: true,
                                              //                             ),
                                              //                             SizedBox(
                                              //                               height: Get.height * .003,
                                              //                             ),
                                              //                             Text(
                                              //                               data?.recruiterDetails?.companyName ?? "",
                                              //                               style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),
                                              //                             ),
                                              //                             SizedBox(
                                              //                               height: Get.height * 0.03,
                                              //                             ),
                                              //                             Text(
                                              //                               "Job Description",
                                              //                               style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                                              //                             ),
                                              //                             SizedBox(
                                              //                               height: Get.height * .008,
                                              //                             ),
                                              //                             data?.description == null || data?.description.toString().length == 0
                                              //                                 ? Text(
                                              //                                     "No job description",
                                              //                                     style: TextStyle(color: Colors.white),
                                              //                                   )
                                              //                                 : HtmlWidget(
                                              //                                     data?.description ?? "No job description",
                                              //                                     textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),
                                              //                                   ),
                                              //                             SizedBox(
                                              //                               height: Get.height * 0.03,
                                              //                             ),
                                              //                             Text(
                                              //                               "Requirements",
                                              //                               style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                                              //                             ),
                                              //                             SizedBox(
                                              //                               height: Get.height * .007,
                                              //                             ),
                                              //                             HtmlWidget(
                                              //                               data?.requirements ?? "No requirements",
                                              //                               textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),
                                              //                             ),
                                              //                             SizedBox(
                                              //                               height: Get.height * .02,
                                              //                             ),
                                              //                           ],
                                              //                         ),
                                              //                       ),
                                              //                     ),
                                              //                   ),
                                              //                 ),
                                              //               ],
                                              //             ),
                                              //           );
                                              //         },
                                              //       ),
                                        // ),
                              Positioned(
                                top: 0,
                                child: Container(
                                  color: Colors.black.withOpacity(_appBarOpacity),
                                  width: Get.width,
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25.0,left: 12,),
                                        child: Image.asset(
                                          'assets/images/icon_flikka_logo.png',
                                          height: Get.height * .032,
                                        ),
                                      ),
                                      // Column(
                                      //   mainAxisAlignment: MainAxisAlignment.center,
                                      //   crossAxisAlignment:
                                      //   CrossAxisAlignment.center,
                                      //   children: [
                                      //     SizedBox(
                                      //       height: Get.height * .03,
                                      //     ),
                                      //     Text(
                                      //       "Find Job",
                                      //       style: Theme.of(context)
                                      //           .textTheme
                                      //           .displaySmall,
                                      //     ),
                                      //     SizedBox(
                                      //       // width: Get.width*.35,
                                      //       child: Text(
                                      //           seekerProfileController.viewSeekerData.value
                                      //               .seekerInfo?.location ?? "No location",
                                      //           overflow: TextOverflow.ellipsis,
                                      //           style: Theme.of(context)
                                      //               .textTheme
                                      //               .labelLarge!
                                      //               .copyWith(
                                      //               color: AppColors
                                      //                   .graySilverColor)),
                                      //     )
                                      //   ],
                                      // ),
                                      Builder(builder: (context) {
                                        return InkWell(
                                            onTap: () => Scaffold.of(context).openEndDrawer(),
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 25.0,right: 20),
                                              child: Image.asset(
                                                'assets/images/icon_seeker_drawer.png',
                                                height: Get.height * .05,
                                              ),
                                            ));
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
            }
          });
      }
    });
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    if (currentIndex != null) {
      if (direction.name == "left") {
        // print("swiped left");
      } else if (direction.name == "right") {
        CommonFunctions.confirmationDialog(context,
            message: "Do you want to Apply for the post", onTap: () {
              applyJobController.errorMessageApplyReferral.value = "" ;
          Get.back();
          showReferralSubmissionDialog(context, previousIndex);
        });
      } else if (direction.name == "top") {
        CommonFunctions.confirmationDialog(context,
            message: "Do you want to save the post", onTap: () {
          Get.back();
          CommonFunctions.showLoadingDialog(context, "Saving");
          jobFilterController.reset.value
              ? seekerSaveJobController.saveJobApi(
                  getJobsListingController
                      .getJobsListing.value.jobs?[previousIndex].id,
                  1)
              : seekerSaveJobController.saveJobApi(
                  jobFilterController.jobsData.value.jobs?[previousIndex].id,
                  1);
        });
      }
    }
    return true;
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

  void showPound(BuildContext context, String companyName, dynamic minimumSalary) {
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
                SizedBox(
                  height: Get.height * .015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: Get.width * .6,
                        child: Text(
                          companyName,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displaySmall,
                        )),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.blueThemeColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * .015,
                ),
                SizedBox(
                  height: Get.height * .2,
                  child: Stack(
                    children: [
                      Center(
                          child: Image.asset(
                        "assets/images/icon_earn.png",
                        height: Get.height * .2,
                      )),
                      Center(
                        child: Text(
                          "$minimumSalary £",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      )
                    ],
                  ),
                ),
                //Text("According to this job you will get $minimumSalary for successful referral",textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: AppColors.graySilverColor,),),
                SizedBox(
                  height: Get.height * .015,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.graySilverColor,
                        ),
                    children: [
                      const TextSpan(
                          text: 'According to this job you will get '),
                      TextSpan(
                        text: "$minimumSalary £",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.blueThemeColor,
                        ),
                      ),
                      const TextSpan(text: ' for successful referral'),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * .03,
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
                                                  getJobsListingController.getJobsListing.value.jobs?[index].id.toString(),
                                                  referralCode: controller.text);
                                          if (result) {
                                            getJobsListingController.getJobsListing.value.jobs?[index].postApplied = true;
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
                                              getJobsListingController.getJobsListing.value.jobs?[index].id.toString());
                                      if (result) {
                                        getJobsListingController.getJobsListing.value.jobs?[index].postApplied = true;
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

  void onSwipeLeft() {
    setState(() {
      if(_currentPage < getJobsListingController.getJobsListing.value.jobs!.length - 1) {
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
    CommonFunctions.confirmationDialog(context, message: "Do you want to apply", onTap: () async {
      Get.back() ;
      var result = await showReferralSubmissionDialog(context, _currentPage) ;
      if(result == true) {
        setState(() {
          if(_currentPage < getJobsListingController.getJobsListing.value.jobs!.length - 1) {
            _currentPage++;
          }else{
            _currentPage = 0 ;
          }
          _pageController.jumpToPage(_currentPage) ;
        });
      }
    }) ;
    if (kDebugMode) {
      print('Swiped to the right');
    }
  }

  // Widget buildPage(int index) {
  //   if( getJobsListingController.getJobsListing.value.jobs?[index]?.workExperience != null &&  getJobsListingController.getJobsListing.value.jobs?[index]?.workExperience.toString().length != 0) {
  //     var experience = getJobsListingController.getJobsListing.value.jobs?[index]?.workExperience.toString().split(".");
  //     if(experience?.length == 2) {
  //       if( experience?[0] != null && experience?[0].length != 0 && experience?[0].toString() != "0") {
  //         years = "${experience?[0]} year";
  //       }
  //       if( experience?[1] != null && experience?[1].length != 0 && experience?[1].toString() != "00") {
  //         months = "${experience?[1]} month";
  //       }
  //     }
  //   }
  //   return SingleChildScrollView(
  //       controller: _scrollController,
  //       child: Column( crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Stack(children: [
  //             CachedNetworkImage(imageUrl: getJobsListingController.getJobsListing.value.jobs?[index].featureImg ?? "" ,
  //             placeholder: (context, url) => SizedBox( height: Get.height,
  //               child: const Center(child: CircularProgressIndicator()),),
  //             imageBuilder: (context, imageProvider) => Container(
  //               height: MediaQuery.of(context).size.height,
  //               decoration: BoxDecoration(
  //                 image: DecorationImage(
  //                   image: imageProvider ,
  //                   fit: BoxFit.cover,
  //                 ),),
  //             ),),
  //             Positioned(
  //               right: 20,
  //               top: Get.height * 0.13,
  //               child: Stack(
  //                 children: [
  //                   GestureDetector(
  //                     onTap:
  //                         () {
  //                       showSeekerHomePagePercentageProfile(context, getJobsListingController.getJobsListing.value.jobs?[index]);
  //                     },
  //                     child:
  //                     Container(
  //                       decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(50),
  //                           border: Border.all(color: AppColors.white, width: 2)),
  //                       child:
  //                       Padding(
  //                         padding:
  //                         const EdgeInsets.all(3.0),
  //                         child: Container(
  //                             decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.blueThemeColor),
  //                             child: CircleAvatar(
  //                                 radius: 30,
  //                                 backgroundColor: Colors.transparent,
  //                                 child: Center(
  //                                   child: Column(
  //                                     mainAxisAlignment: MainAxisAlignment.center,
  //                                     children: [
  //                                       Text('${getJobsListingController.getJobsListing.value.jobs?[index]?.jobMatchPercentage}%', style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white)),
  //                                       Text('match', style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white, fontSize: 7)),
  //                                     ],
  //                                   ),
  //                                 ))),
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             //************* for bookmarks ************
  //             Positioned(
  //               left: 12,
  //               top: Get.height * 0.13,
  //               child: Column(
  //                 children: [
  //                   GestureDetector(
  //                       onTap:
  //                           () {
  //                         // getJobsListingController.saved.value=true;
  //                         CommonFunctions.confirmationDialog(context,
  //                             message: getJobsListingController.getJobsListing.value.jobs?[index].postSaved ? "Do you want to remove the\n post from saved posts" : "Do you want to save the post",
  //                             onTap: () async {
  //                               Get.back();
  //                               if (getJobsListingController.getJobsListing.value.jobs?[index]?.postSaved == true) {
  //                                 CommonFunctions.showLoadingDialog(context, "removing...");
  //                                 var result = await unSavePostController.unSavePost(getJobsListingController.getJobsListing.value.jobs?[index]?.id.toString(), "1", context, true);
  //                                 if (result == true) {
  //                                   if (kDebugMode) {
  //                                     print("inside result");
  //                                   }
  //                                   getJobsListingController.getJobsListing.value.jobs?[index].postSaved = false;
  //                                   setState(() {});
  //                                 }
  //                               } else {
  //                                 CommonFunctions.showLoadingDialog(context, "Saving");
  //                                 var result = await seekerSaveJobController.saveJobApi(getJobsListingController.getJobsListing.value.jobs?[index]?.id, 1);
  //                                 if (result == true) {
  //                                   if (kDebugMode) {
  //                                     print("inside result");
  //                                   }
  //                                   getJobsListingController.getJobsListing.value.jobs?[index].postSaved = true;
  //                                   setState(() {});
  //                                 }
  //                               }
  //                             });
  //                       },
  //                       child: getJobsListingController.getJobsListing.value.jobs?[index].postSaved == false
  //                           ? Image.asset(
  //                         "assets/images/icon_unsave_post.png",
  //                         height: Get.height * .043,
  //                       )
  //                           : Image.asset(
  //                         "assets/images/icon_Save_post.png",
  //                         height: Get.height * .043,
  //                       )),
  //                   SizedBox(
  //                     height: Get.height *
  //                         .01,
  //                   ),
  //                   GestureDetector(
  //                       onTap:
  //                           () {
  //                         Get.to(() =>
  //                         const FilterPage());
  //                       },
  //                       child:
  //                       Image.asset(
  //                         "assets/images/icon_filter_seeker_home.png",
  //                         height:
  //                         Get.height * .043,
  //                       )),
  //                   SizedBox(height: Get.height * .01,),
  //                   GestureDetector(
  //                     onTap:
  //                         () {
  //                       if (getJobsListingController.getJobsListing.value.jobs?[index]?.video == null ||
  //                           getJobsListingController.getJobsListing.value.jobs?[index]?.video?.length == 0) {
  //                         Utils.showMessageDialog(context,
  //                             "video not uploaded yet");
  //                       } else {
  //                         Get.back();
  //                         Get.to(() =>
  //                             VideoPlayerScreen(videoPath: getJobsListingController.getJobsListing.value.jobs?[index]?.video ?? ""));
  //                       }
  //                     },
  //                     child:
  //                     Container(
  //                       alignment:
  //                       Alignment.center,
  //                       height:
  //                       34,
  //                       width:
  //                       34,
  //                       decoration: const BoxDecoration(
  //                           shape: BoxShape.circle,
  //                           color: AppColors.blueThemeColor),
  //                       child:
  //                       Image.asset(
  //                         "assets/images/icon_video.png",
  //                         height:
  //                         18,
  //                         fit:
  //                         BoxFit.cover,
  //                       ),
  //                     ),
  //                   ),
  //                   getJobsListingController.getJobsListing.value.jobs?[index]?.jobMatchPercentage == 100
  //                       ? InkWell(
  //                     child: Container(
  //                       alignment: Alignment.center,
  //                       height: 34,
  //                       width: 34,
  //                       decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.blueThemeColor),
  //                       child: Image.asset(
  //                         'assets/images/icon_msg_blue.png',
  //                         height: Get.height * .06,
  //                       ),
  //                     ),
  //                     onTap: () {
  //                       RecruiterId = getJobsListingController.getJobsListing.value.jobs?[index]?.recruiterId.toString();
  //                       Recruitername = getJobsListingController.getJobsListing.value.jobs?[index]?.recruiterDetails?.companyName;
  //                       Recruiterimg = getJobsListingController.getJobsListing.value.jobs?[index]?.recruiterDetails?.profileImg;
  //
  //                       setState(() {
  //                         RecruiterId;
  //                         Recruitername;
  //                         Recruiterimg;
  //                       });
  //                       if (kDebugMode) {
  //                         print(RecruiterId);
  //                         print(Recruitername);
  //                         print(Recruiterimg);
  //                       }
  //                       Ctreatechatinstance.CreateChat();
  //                     },
  //                   )
  //                       : const SizedBox(),
  //                   SizedBox(height: Get.height * .01,),
  //                   GestureDetector(
  //                             onTap:
  //                                 () {
  //                               showPound(
  //                                   context,
  //                                   getJobsListingController.getJobsListing.value.jobs?[index]?.recruiterDetails?.companyName,
  //                                   "${getJobsListingController.getJobsListing.value.jobs?[index]?.jobsDetail?.minSalaryExpectation / 20}".split(".")[0]);
  //                             },
  //                             child: Image
  //                                 .asset(
  //                               "assets/images/icon_pound.png",
  //                               height: Get.height *
  //                                   .043,
  //                             )),
  //                 ],
  //               ),
  //             ),
  //           ],
  //           ),
  //           SizedBox(
  //             height: Get.height * 0.025,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column( crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   getJobsListingController.getJobsListing.value.jobs?[index].jobTitle ?? "No job title", overflow: TextOverflow.ellipsis,
  //                   style:  Get.theme.textTheme.displayLarge?.copyWith(color: AppColors.black),
  //                 ),
  //                 SizedBox(
  //                   height: Get.height * 0.004,
  //                 ),
  //                 Text(
  //                   getJobsListingController.getJobsListing.value.jobs?[index].jobPositions ?? "No job position",overflow: TextOverflow.ellipsis,
  //                   style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),
  //                 ),
  //                 SizedBox(
  //                   height: Get.height * 0.004,
  //                 ),
  //                 Text(
  //                   "${getJobsListingController.getJobsListing.value.jobs?[index].recruiterDetails?.companyName ?? "No company name"}", overflow: TextOverflow.ellipsis,
  //                   style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),
  //                 ),
  //                 SizedBox(height: Get.height * 0.03,),
  //                 Text("Job Description",
  //                   style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
  //                 SizedBox(height: Get.height * 0.015,),
  //                 getJobsListingController.getJobsListing.value.jobs?[index].description == null || CommonFunctions.parseHTML(getJobsListingController.getJobsListing.value.jobs?[index].description).toString().trim().length == 0 ?
  //                 Text("No job description",style: Theme.of(context).textTheme.labelLarge!
  //                     .copyWith(color: AppColors.black,fontWeight: FontWeight.w400),) :
  //                 HtmlWidget(getJobsListingController.getJobsListing.value.jobs?[index].description ?? 'No job description',textStyle:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black) ,),
  //                 SizedBox(height: Get.height * 0.03,),
  //                 Text("Requirements", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
  //                 SizedBox(height: Get.height * 0.015,),
  //                 getJobsListingController.getJobsListing.value.jobs?[index].requirements == null || CommonFunctions.parseHTML(getJobsListingController.getJobsListing.value.jobs?[index].requirements).toString().trim().length == 0 ?
  //                 Text("No requirements",style: Theme.of(context).textTheme.labelLarge!
  //                     .copyWith(color: AppColors.black,fontWeight: FontWeight.w400),) :
  //                 HtmlWidget(getJobsListingController.getJobsListing.value.jobs?[index].requirements ?? 'No requirements',textStyle: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),),
  //                 SizedBox(height: Get.height * 0.025,),
  //                 Text("Locations", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
  //                 SizedBox(height: Get.height * 0.015,),
  //                 Text(getJobsListingController.getJobsListing.value.jobs?[index].jobLocation ?? "No job location",overflow: TextOverflow.ellipsis, style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),),
  //                 SizedBox(height: Get.height * 0.015,),
  //                 InkWell(
  //                     // onTap: () {
  //                       // Get.to( GoogleMapIntegration(jobPageView: true,lat: double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].lat}"),long:  double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].long}")));},
  //                     child: SizedBox( height: Get.height * 0.3,
  //                         child: GoogleMapIntegration(jobPageView: true,lat: double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].lat}"),long:  double.tryParse("${getJobsListingController.getJobsListing.value.jobs?[index].long}"),))),
  //                 SizedBox(height: Get.height * 0.035,),
  //                 Text("Information", style:Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
  //                 SizedBox(height: Get.height * 0.015,),
  //                 Text("Position", style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black),),
  //                 SizedBox(height: Get.height * 0.015,),
  //                 Container(
  //                   padding: const EdgeInsets.all(8),
  //                   decoration: BoxDecoration(
  //                     color: AppColors.homeGrey,
  //                     borderRadius: BorderRadius.circular(10)
  //                   ),
  //                   child: Text(getJobsListingController.getJobsListing.value.jobs?[index].jobPositions ?? "No position",
  //                     style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),),
  //                 ),
  //                 const Divider(color: Colors.grey, thickness: 0.2,),
  //                 const Text("Qualification",
  //                   style: TextStyle(color: AppColors.black, fontSize: 14),),
  //                 SizedBox(height: Get.height * 0.015,),
  //                 getJobsListingController.getJobsListing.value.jobs?[index].education.toString().toLowerCase() == "null" ||
  //                     getJobsListingController.getJobsListing.value.jobs?[index].education.toString().length == 0
  //                     ? Text("No qualification", style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
  //                 Container(
  //                   padding: const EdgeInsets.all(8),
  //                   decoration: BoxDecoration(
  //                       color: AppColors.homeGrey,
  //                       borderRadius: BorderRadius.circular(10)
  //                   ),
  //                   child: Text(
  //                     getJobsListingController.getJobsListing.value.jobs?[index].education ?? "",
  //                     style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),
  //                   ),
  //                 ),
  //                 const Divider(
  //                   color: Colors.grey,
  //                   thickness: 0.2,
  //                 ),
  //                 const Text("Experience",
  //                   style: TextStyle(color: AppColors.black, fontSize: 14),),
  //                 SizedBox(height: Get.height * 0.015,),
  //                 Container(  padding: const EdgeInsets.all(8),
  //                   decoration: BoxDecoration(
  //                       color: AppColors.homeGrey,
  //                       borderRadius: BorderRadius.circular(10)
  //                   ),
  //                   child: years.toString().length == 0 && months.toString().length == 0 ?  const Text("No experience") : Text("${years ?? ""} ${ months ?? ""}",
  //                     style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),
  //                   ),
  //                 ),
  //                 const Divider(
  //                   color: Colors.grey,
  //                   thickness: 0.2,
  //                 ),
  //                 const Text("Job Type", style: TextStyle(color: AppColors.black, fontSize: 14),),
  //                 SizedBox(height: Get.height * 0.015,),
  //                 Container( padding: const EdgeInsets.all(8),
  //                   decoration: BoxDecoration(
  //                       color: AppColors.homeGrey,
  //                       borderRadius: BorderRadius.circular(10)
  //                   ),
  //                   child: Text(getJobsListingController.getJobsListing.value.jobs?[index].employmentType ?? "No job type",
  //                     style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),),
  //                 ),
  //                 const Divider(color: Colors.grey, thickness: 0.2,),
  //                 const Text("Specialization", style: TextStyle(color: AppColors.black, fontSize: 14),),
  //                 SizedBox(height: Get.height * 0.015,),
  //                 Container( padding: const EdgeInsets.all(8),
  //                   decoration: BoxDecoration(
  //                       color: AppColors.homeGrey,
  //                       borderRadius: BorderRadius.circular(10)
  //                   ),
  //                   child: Text(getJobsListingController.getJobsListing.value.jobs?[index].specialization ?? "No specialization",
  //                     style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),),
  //                 ),
  //                 const Divider(color: Colors.grey, thickness: 0.2,),
  //                 const Text("Type of workplace",
  //                   style: TextStyle(color: AppColors.black, fontSize: 14),),
  //                 SizedBox(height: Get.height * 0.015,),
  //                 Container( padding: const EdgeInsets.all(8),
  //                   decoration: BoxDecoration(
  //                       color: AppColors.homeGrey,
  //                       borderRadius: BorderRadius.circular(10)
  //                   ),
  //                   child: Text(getJobsListingController.getJobsListing.value.jobs?[index].typeOfWorkplace ?? "No workplace",
  //                     style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),),
  //                 ),
  //                 const Divider(color: Colors.grey, thickness: 0.2,),
  //                 const Text("Preferred work experience",
  //                   style: TextStyle(color: AppColors.black, fontSize: 14),
  //                 ),
  //                 SizedBox(height: Get.height * 0.015,),
  //                 Container( padding: const EdgeInsets.all(8),
  //                   decoration: BoxDecoration(
  //                       color: AppColors.homeGrey,
  //                       borderRadius: BorderRadius.circular(10)
  //                   ),
  //                   child: Text(
  //                     getJobsListingController.getJobsListing.value.jobs?[index].preferredWorkExperience ?? "No preferred work experience",
  //                     style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),
  //                   ),
  //                 ),
  //                 const Divider(
  //                   color: Colors.grey,
  //                   thickness: 0.2,
  //                 ),
  //                 const Text("Language", style: TextStyle(color: AppColors.black, fontSize: 14),),
  //                 SizedBox(height: Get.height * 0.015,),
  //                 getJobsListingController.getJobsListing.value.jobs?[index].languageName == null || getJobsListingController.getJobsListing.value.jobs?[index].languageName?.length == 0 ?
  //                 Text("No language", style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
  //                Column( crossAxisAlignment: CrossAxisAlignment.start,
  //                  children: [
  //                    for(int i = 0 ; i < getJobsListingController.getJobsListing.value.jobs![index].languageName!.length  ; i++ )
  //                      Container( padding: const EdgeInsets.all(8),
  //                        margin: const EdgeInsets.only(bottom: 8),
  //                        decoration: BoxDecoration(
  //                            color: AppColors.homeGrey,
  //                            borderRadius: BorderRadius.circular(10)
  //                        ),
  //                        child: Text(getJobsListingController.getJobsListing.value.jobs?[index].languageName?[i].languages ?? "",
  //                          style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),
  //                        ),),
  //                  ],),
  //                 const Divider(
  //                   color: Colors.grey,
  //                   thickness: 0.2,
  //                 ),
  //                 Text("Soft Skills",
  //                   style: Theme.of(context).textTheme.titleSmall!
  //                       .copyWith(color: AppColors.black),
  //                 ),
  //                 SizedBox(height: Get.height*0.01,),
  //                 getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.skillName == null ||
  //                     getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.skillName?.length == 0 ?
  //                 Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
  //                 Wrap(
  //                   spacing: 6.0,
  //                   runSpacing: 6.0,
  //                   alignment: WrapAlignment.start,
  //                   crossAxisAlignment: WrapCrossAlignment.start,
  //                   children: List.generate(
  //                     getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.skillName?.length ?? 0,
  //                         (i) {
  //                       return Container(
  //                         padding: const EdgeInsets.all(8),
  //                         decoration: BoxDecoration(
  //                           color: AppColors.homeGrey,
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         child: Text(
  //                           getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.skillName?[i].skills ?? "",
  //                           overflow: TextOverflow.ellipsis,
  //                           style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black)
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //                 SizedBox(height: Get.height*0.04,),
  //                 Text("Passion",
  //                   style: Theme.of(context).textTheme.titleSmall!
  //                       .copyWith(color: AppColors.black),
  //                 ),
  //                 SizedBox(height: Get.height*0.01,),
  //                 getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.passionName == null ||
  //                     getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.passionName?.length == 0 ?
  //                 Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
  //                 Wrap(
  //                   spacing: 6.0,
  //                   runSpacing: 6.0,
  //                   alignment: WrapAlignment.start,
  //                   crossAxisAlignment: WrapCrossAlignment.start,
  //                   children: List.generate(
  //                     getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.passionName?.length ?? 0,
  //                         (i) {
  //                       return Container(
  //                         padding: const EdgeInsets.all(8),
  //                         decoration: BoxDecoration(
  //                           color: AppColors.homeGrey,
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         child: Text(
  //                             getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.passionName?[i].passion ?? "",
  //                             overflow: TextOverflow.ellipsis,
  //                             style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black)
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //                 SizedBox(height: Get.height * 0.04,),
  //                 Text(
  //                   "industry preference",
  //                   style: Theme.of(context).textTheme.titleSmall!
  //                       .copyWith(color: AppColors.black),
  //                 ),
  //                 SizedBox(height: Get.height*0.01,),
  //                 getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.industryPreferenceName == null ||
  //                     getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.industryPreferenceName?.length == 0 ?
  //                 Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
  //                 Wrap(
  //                   spacing: 6.0,
  //                   runSpacing: 6.0,
  //                   alignment: WrapAlignment.start,
  //                   crossAxisAlignment: WrapCrossAlignment.start,
  //                   children: List.generate(
  //                     getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.industryPreferenceName?.length ?? 0,
  //                         (i) {
  //                       return Container(
  //                         padding: const EdgeInsets.all(8),
  //                         decoration: BoxDecoration(
  //                           color: AppColors.homeGrey,
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         child: Text(
  //                             getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.industryPreferenceName?[i].industryPreferences ?? "",
  //                             overflow: TextOverflow.ellipsis,
  //                             style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black)
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //                 SizedBox(height: Get.height * 0.04,),
  //                 Text("Strengths",
  //                   style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.black),),
  //                 SizedBox(height: Get.height*0.01,),
  //                 getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.strengthsName == null ||
  //                     getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.strengthsName?.length == 0 ?
  //                 Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
  //                 Wrap(
  //                   spacing: 6.0,
  //                   runSpacing: 6.0,
  //                   alignment: WrapAlignment.start,
  //                   crossAxisAlignment: WrapCrossAlignment.start,
  //                   children: List.generate(
  //                     getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.strengthsName?.length ?? 0,
  //                         (i) {
  //                       return Container(
  //                         padding: const EdgeInsets.all(8),
  //                         decoration: BoxDecoration(
  //                           color: AppColors.homeGrey,
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         child: Text(
  //                             getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.strengthsName?[i].strengths ?? "",
  //                             overflow: TextOverflow.ellipsis,
  //                             style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black)
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //                 SizedBox(height: Get.height * 0.04,),
  //                 Text("Salary expectation",
  //                   style: Theme.of(context).textTheme.titleSmall!
  //                       .copyWith(color: AppColors.black),
  //                 ),
  //                 SizedBox(height: Get.height*0.01,),
  //                 Container(
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(20),
  //                     color: AppColors.homeGrey,
  //                   ),
  //                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //                   child: Text(
  //                     '${getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.minSalaryExpectation ?? ''}  ${getJobsListingController.getJobsListing.value.jobs?[index]?.jobsDetail?.maxSalaryExpectation ?? 'No salary expectation'} ',
  //                     style: Get.theme.textTheme.bodySmall!.copyWith(
  //                       color: AppColors.black,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: Get.height * 0.04,),
  //                 Text("When can i start working?",
  //                   style: Theme.of(context).textTheme.titleSmall!
  //                       .copyWith(color: AppColors.black),
  //                 ),
  //                 SizedBox(height: Get.height*0.01,),
  //                 getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.startWorkName == null ||
  //                     getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.startWorkName?.length == 0 ?
  //                 Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
  //                 Wrap(
  //                   spacing: 6.0,
  //                   runSpacing: 6.0,
  //                   alignment: WrapAlignment.start,
  //                   crossAxisAlignment: WrapCrossAlignment.start,
  //                   children: List.generate(
  //                     getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.startWorkName?.length ?? 0,
  //                         (i) {
  //                       return Container(
  //                         padding: const EdgeInsets.all(8),
  //                         decoration: BoxDecoration(
  //                           color: AppColors.homeGrey,
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         child: Text(
  //                             getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.startWorkName?[i].startWork ?? "",
  //                             overflow: TextOverflow.ellipsis,
  //                             style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black)
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //                 SizedBox(height: Get.height * 0.04,),
  //                 Text("Availability",
  //                   style: Theme.of(context).textTheme.titleSmall!
  //                       .copyWith(color: AppColors.black),
  //                 ),
  //                 SizedBox(height: Get.height * 0.01,),
  //                 getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.availabityName == null ||
  //                     getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.availabityName?.length == 0 ?
  //                 Text("No skills", style:Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black),) :
  //                 Wrap(
  //                   spacing: 6.0,
  //                   runSpacing: 6.0,
  //                   alignment: WrapAlignment.start,
  //                   crossAxisAlignment: WrapCrossAlignment.start,
  //                   children: List.generate(
  //                     getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.availabityName?.length ?? 0,
  //                         (i) {
  //                       return Container(
  //                         padding: const EdgeInsets.all(8),
  //                         decoration: BoxDecoration(
  //                           color: AppColors.homeGrey,
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         child: Text(
  //                             getJobsListingController.getJobsListing.value.jobs?[index].jobsDetail?.availabityName?[i].availabity ?? "",
  //                             overflow: TextOverflow.ellipsis,
  //                             style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black)
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //                 SizedBox(height: Get.height * 0.055,),
  //                 Center(
  //                   child: Obx( () => MyButton(
  //                         title: getJobsListingController.getJobsListing.value.jobs?[index].postApplied == true ? "APPLIED" : "APPLY NOW",
  //                         onTap1: () async {
  //                           if(getJobsListingController.getJobsListing.value.jobs?[index].postApplied == true ){}else{
  //                             applyJobController.errorMessageApplyReferral.value = "" ;
  //                             showReferralSubmissionDialog(context,index) ;
  //                           }
  //                         }
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: Get.height*.025,),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  // }
}
