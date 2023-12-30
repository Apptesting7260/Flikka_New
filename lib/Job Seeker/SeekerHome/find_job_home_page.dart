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
import '../SeekerFilter/filter_page.dart';
import '../marketing_page.dart';
import '../SeekerDrawer/Drawer_page.dart';
import '../SeekerJobs/no_job_available.dart';
import 'package:get/get.dart';

String ?Recruitername;
String ?Recruiterimg;
class FindJobHomeScreen extends StatefulWidget {
  const FindJobHomeScreen({super.key});

  @override
  State<FindJobHomeScreen> createState() => _FindJobHomeScreenState();
}

class _FindJobHomeScreenState extends State<FindJobHomeScreen> {
  final CardSwiperController controller = CardSwiperController();

  List<CardSwiperDirection> allDirections = CardSwiperDirection.values;

  //////refresh//////
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
     getJobsListingController.seekerGetAllJobsApi();
     jobFilterController.reset(true) ;
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
     getJobsListingController.seekerGetAllJobsApi();
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  /////refresh/////

  final Ctreatechat Ctreatechatinstance=Ctreatechat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  List<String> cards = [
    'assets/images/icon_view_recruiter_job_background.png', 'assets/images/icon_view_recruiter_job_background.png',
  ];

  GetJobsListingController getJobsListingController = Get.put(GetJobsListingController()) ;
  ViewSeekerProfileController seekerProfileController = Get.put(ViewSeekerProfileController()) ;
  SeekerSaveJobController seekerSaveJobController = Get.put(SeekerSaveJobController()) ;
  ApplyJobController applyJobController = Get.put(ApplyJobController()) ;
  SeekerJobFilterController jobFilterController = Get.put(SeekerJobFilterController()) ;
  SeekerUnSavePostController unSavePostController = Get.put(SeekerUnSavePostController()) ;
  GetJobsListingModel jobModel = GetJobsListingModel() ;
  // final Ctreatechat Ctreatechatinstance = Ctreatechat();
  @override
  void initState() {
    // getJobsListingController.seekerGetAllJobsApi() ;
    // seekerProfileController.viewSeekerProfileApi() ;
    super.initState();
  }

  List? rejected = [];
  List? approved = [];
  List? saved = [];

  var last = false ;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (getJobsListingController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (getJobsListingController.error.value == 'No internet') {
            return Scaffold(body: InterNetExceptionWidget(
              onPress: () {
                getJobsListingController.seekerGetAllJobsApi() ;
              },
            ),);
          } else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              getJobsListingController.seekerGetAllJobsApi() ;
            }),);
          }
        case Status.COMPLETED:
          return Obx(() {
            switch (seekerProfileController.rxRequestStatus.value) {
              case Status.LOADING:
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),),) ;
              case Status.ERROR:
                if (seekerProfileController.error.value == 'No internet') {
                  return Scaffold(body: InterNetExceptionWidget(
                    onPress: () {
                      seekerProfileController.viewSeekerProfileApi() ;
                    },
                  ),);
                } else {
                  return Scaffold(body: GeneralExceptionWidget(
                      onPress: () {
                        seekerProfileController.viewSeekerProfileApi() ;
                      }),);
                }
              case Status.COMPLETED:
                return Scaffold(
                  endDrawer: DrawerClass(
                    name: '${seekerProfileController.viewSeekerData.value.seekerInfo?.fullname}',
                    location: '${seekerProfileController.viewSeekerData.value.seekerInfo?.location}',
                    jobTitle: '${seekerProfileController.viewSeekerData.value.seekerDetails?.positions ?? ''}',
                    profileImage: '${seekerProfileController.viewSeekerData.value.seekerInfo?.profileImg}',),
                  body: Obx((){
                    return SmartRefresher(
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: SafeArea(
                        child:
                        GestureDetector(
                          onTap: () {
                            if (Scaffold.of(context).isEndDrawerOpen) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Image.asset('assets/images/icon_flikka_logo.png',height: Get.height*.032, ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: Get.height*.03,),
                                      Text(
                                        "Find Job",
                                        style:Theme.of(context).textTheme.displaySmall,
                                      ),
                                      SizedBox(
                                        // width: Get.width*.35,
                                        child: Text(
                                            seekerProfileController.viewSeekerData.value.seekerInfo?.location ?? "No location",
                                            overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.graySilverColor)
                                        ),
                                      )
                                    ],
                                  ),
                                  Builder(
                                      builder: (context) {
                                        return InkWell(
                                            onTap: ()=> Scaffold.of(context).openEndDrawer(),
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 25.0),
                                              child: Image.asset('assets/images/inactive.png',height: Get.height*.05,),
                                            ));
                                      }
                                  ),
                                ],
                              ),
                              Flexible(
                                child:
                                last ? const SeekerNoJobAvailable() :
                                getJobsListingController.getJobsListing.value.jobs?.length == 0 ||
                                    getJobsListingController.getJobsListing.value.jobs == null ?
                                const SeekerNoJobAvailable() :
                                Obx( () =>
                                jobFilterController.reset.value ?
                                CardSwiper(
                                  controller: controller,
                                  cardsCount: getJobsListingController.getJobsListing.value.jobs?.length ?? 0 ,
                                  numberOfCardsDisplayed: getJobsListingController.getJobsListing.value.jobs!.length >= 2 ? 2 : 1,
                                  backCardOffset: const Offset(40, 40),
                                  padding: const EdgeInsets.all(24.0),
                                  allowedSwipeDirection: AllowedSwipeDirection.only(left: true,right: true , up : true),
                                  onSwipe: _onSwipe,
                                  cardBuilder: (context, index,
                                      horizontalThresholdPercentage, verticalThresholdPercentage,) {
                                    // HomeSwiperWidget(jobData: getJobsListingController.jobs?[index],);
                                    var data = getJobsListingController.getJobsListing.value.jobs?[index] ;
                                    var save = false.obs ;
                                    save.value = data?.postSaved ;
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.blackdown, borderRadius: BorderRadius.circular(34)),
                                      height: Get.height,
                                      width: Get.width,
                                      child: Stack(
                                        children: [
                                          //************* for swiper image ************

                                          GestureDetector(
                                            onTap: () {
                                              Get.to(() => MarketingIntern(jobData: data, appliedJobScreen: false,));
                                            },
                                            child: Container(
                                              decoration:
                                              BoxDecoration(borderRadius: BorderRadius.circular(26)),
                                              width: Get.width,
                                              height: Get.height * 0.5,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      placeholder: (context, url) =>
                                                      const Center(child: CircularProgressIndicator()),
                                                      imageUrl: "${data?.featureImg}")
                                                // Image.network("${data?.featureImg}",
                                                //   fit: BoxFit.cover,
                                                // ),
                                              ),
                                            ),
                                          ),
                                          //************* for 50% match ************
                                          Positioned(
                                            right: 20,
                                            top: 10,
                                            child: Stack(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showSeekerHomePagePercentageProfile(context,data) ;
                                                  },
                                                  child: Container(
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
                                                              radius: 30,
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
                                                )
                                              ],
                                            ),
                                          ),
                                          //************* for bookmarks ************

                                          Positioned(
                                            left: 12,
                                            top: 15,
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      // getJobsListingController.saved.value=true;
                                                      CommonFunctions.confirmationDialog(context, message: getJobsListingController.getJobsListing.value.jobs?[index].postSaved ?
                                                      "Do you want to remove the\n post from saved posts" : "Do you want to save the post", onTap: () async {
                                                        Get.back();
                                                        if(data?.postSaved == true) {
                                                          CommonFunctions.showLoadingDialog(context, "removing...");
                                                          var result = await unSavePostController.unSavePost(data?.id.toString(), "1", context,true) ;
                                                          if(result == true) {
                                                            if (kDebugMode) {
                                                              print("inside result") ;
                                                            }
                                                            // getJobsListingController.refreshJobsApi() ;
                                                            getJobsListingController.getJobsListing.value.jobs?[index].postSaved = false ;
                                                            setState(() {});
                                                          }
                                                        } else {
                                                          CommonFunctions.showLoadingDialog(context, "Saving");
                                                          var result = await seekerSaveJobController.saveJobApi(data?.id, 1) ;
                                                          if(result == true) {
                                                            if (kDebugMode) {
                                                              print("inside result") ;
                                                            }
                                                            // getJobsListingController.refreshJobsApi() ;
                                                            getJobsListingController.getJobsListing.value.jobs?[index].postSaved = true ;
                                                            setState(() {});
                                                          }
                                                        }
                                                      });
                                                    },
                                                    child:  getJobsListingController.getJobsListing.value.jobs?[index].postSaved == false  ?
                                                    Image.asset("assets/images/icon_unsave_post.png",
                                                      height: Get.height * .043,
                                                    ):
                                                    Image.asset("assets/images/icon_Save_post.png",
                                                      height: Get.height * .043,
                                                    )
                                                ),
                                                SizedBox(
                                                  height: Get.height * .01,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      Get.to(() => const FilterPage());
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/icon_filter_seeker_home.png",
                                                      height: Get.height * .043,
                                                    )),
                                                SizedBox(
                                                  height: Get.height * .01,
                                                ),

                                                GestureDetector(
                                                  onTap: () {
                                                    if( data?.video == null ||
                                                        data?.video?.length == 0 ){
                                                      Utils.showMessageDialog(context, "video not uploaded yet") ;
                                                    }
                                                    else{
                                                      Get.back() ;
                                                      Get.to(() => VideoPlayerScreen(videoPath: data?.video ?? "")) ;
                                                    }
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 34,
                                                    width: 34,
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
                                                SizedBox(
                                                  height: Get.height * .01,
                                                ),
                                                data?.jobMatchPercentage == 100 ?
                                                InkWell(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 34,
                                                    width: 34,
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors.blueThemeColor
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/icon_msg_blue.png',height: Get.height*.06,),
                                                  ),
                                                  onTap: (){
                                                    RecruiterId=data?.recruiterId.toString();
                                                    Recruitername=data?.recruiterDetails?.companyName;
                                                    Recruiterimg=data?.recruiterDetails?.profileImg;

                                                    setState(() {
                                                      RecruiterId;
                                                      Recruitername;
                                                      Recruiterimg;
                                                    });
                                                    if (kDebugMode) {
                                                      print( RecruiterId);
                                                      print( Recruitername);
                                                      print( Recruiterimg);
                                                    }
                                                    Ctreatechatinstance.CreateChat();
                                                  },
                                                ) : const SizedBox(),
                                                SizedBox(
                                                  height: Get.height * .01,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      showPound(context,data?.recruiterDetails?.companyName,"${data?.jobsDetail?.minSalaryExpectation/20}".split(".")[0]) ;
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/icon_pound.png",
                                                      height: Get.height * .043,
                                                    )),
                                              ],
                                            ),
                                          ),

                                          //************* for marketing intern text  ************
                                          Positioned(
                                            //height: Get.height / 2.5-Get.height*0.12 ,
                                            bottom: Get.height * 0.05,
                                            left: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(() => MarketingIntern(jobData: data, appliedJobScreen: false,));
                                              },
                                              child: Container(
                                                height: Get.height * 0.35,
                                                padding: const EdgeInsets.all(20),
                                                decoration: const BoxDecoration(
                                                  color: AppColors.blackdown,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(22),
                                                      topRight: Radius.circular(22)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data?.jobTitle ?? "No job title", overflow: TextOverflow.ellipsis,
                                                      style: Theme.of(context).textTheme.displayLarge,
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * .003,
                                                    ),
                                                    Text(
                                                      data?.jobPositions ?? "No positions",overflow: TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                                      softWrap: true,
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * .003,
                                                    ),
                                                    Text(
                                                      data?.recruiterDetails?.companyName ?? "No company name",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.03,
                                                    ),
                                                    Text(
                                                      "Job Description",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall
                                                          ?.copyWith(fontWeight: FontWeight.w700),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * .008,
                                                    ),
                                                    data?.description == null || CommonFunctions.parseHTML(data?.description).toString().trim().length == 0 ?
                                                    Text("No job description", style: Theme.of(context).textTheme.labelLarge!
                                                        .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),maxLines: 3,) :
                                                    Text(CommonFunctions.parseHtmlAndAddNewline( data?.description ?? "No job description"),overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelLarge!
                                                        .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400,),),
                                                    SizedBox(
                                                      height: Get.height * 0.03,
                                                    ),
                                                    Text(
                                                      "Requirements",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall
                                                          ?.copyWith(fontWeight: FontWeight.w700),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * .007,
                                                    ),
                                                    data?.requirements == null || CommonFunctions.parseHTML(data?.requirements).toString().trim().length == 0 ?
                                                    Text("No requirements",style: Theme.of(context).textTheme.labelLarge!
                                                        .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),) :
                                                    Text(CommonFunctions.parseHtmlAndAddNewline(data?.requirements ?? "No requirements"), overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelLarge!
                                                        .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),),
                                                    Flexible(
                                                      child: SizedBox(
                                                        height: Get.height * .02,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Align(
                                              alignment: AlignmentDirectional.bottomCenter,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[900],
                                                  borderRadius: const BorderRadius.only(
                                                      bottomLeft: Radius.circular(20),
                                                      bottomRight: Radius.circular(22)),
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    // Row(
                                                    //   children: [
                                                    //     IconButton(
                                                    //         onPressed: () => toggleFavorite(),
                                                    //         icon: selectedFav == false
                                                    //             ? SvgPicture.asset(
                                                    //                 'assets/images/likesvg.svg',
                                                    //                 width: Get.width * 0.027,
                                                    //                 height: Get.height * 0.027,
                                                    //                 color: buttonColor,
                                                    //               )
                                                    //             : const Icon(
                                                    //                 Icons.favorite_rounded,
                                                    //                 color: AppColors.red,
                                                    //               )),
                                                    //     Text("12",
                                                    //         style: Theme.of(context)
                                                    //             .textTheme
                                                    //             .bodySmall!
                                                    //             .copyWith(
                                                    //                 color: AppColors.white, fontSize: 14)),
                                                    //     SizedBox(
                                                    //       width: Get.width * 0.04,
                                                    //     ),
                                                    //
                                                    //     //*************************
                                                    //
                                                    //     IconButton(
                                                    //       onPressed: () {
                                                    //         showCommentDialog();
                                                    //       },
                                                    //       icon:
                                                    //           SvgPicture.asset('assets/images/commentsvg.svg'),
                                                    //     ),
                                                    //     Text("10",
                                                    //         style: Theme.of(context)
                                                    //             .textTheme
                                                    //             .bodySmall!
                                                    //             .copyWith(
                                                    //                 color: AppColors.white, fontSize: 14)),
                                                    //   ],
                                                    // ),
                                                    // Padding(
                                                    //   padding: const EdgeInsets.only(right: 14.0),
                                                    //   child: Row(
                                                    //     children: [
                                                    //       InkWell(
                                                    //         onTap: () {
                                                    //           showDialog(
                                                    //             barrierDismissible: false,
                                                    //             context: context,
                                                    //             builder: (BuildContext context) {
                                                    //               return Stack(children: [
                                                    //                 AlertDialog(
                                                    //                   shape: RoundedRectangleBorder(
                                                    //                       borderRadius:
                                                    //                           BorderRadius.circular(17)),
                                                    //                   //contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                                                    //                   content: SingleChildScrollView(
                                                    //                     child: Column(
                                                    //                       children: [
                                                    //                         Image.asset(
                                                    //                             'assets/images/personpng.png'),
                                                    //                         SizedBox(height: Get.height * 0.02),
                                                    //                         Text(
                                                    //                           "Refer a friend",
                                                    //                           style: Theme.of(context)
                                                    //                               .textTheme
                                                    //                               .headlineSmall!
                                                    //                               .copyWith(
                                                    //                                   color: AppColors.white),
                                                    //                         ),
                                                    //                         SizedBox(height: Get.height * 0.01),
                                                    //                         Text.rich(
                                                    //                           TextSpan(
                                                    //                             children: [
                                                    //                               TextSpan(
                                                    //                                 text: "Earn up to ",
                                                    //                                 style: Theme.of(context)
                                                    //                                     .textTheme
                                                    //                                     .headlineSmall!
                                                    //                                     .copyWith(
                                                    //                                         color: AppColors
                                                    //                                             .ratingcommenttextcolor,
                                                    //                                         fontWeight:
                                                    //                                             FontWeight
                                                    //                                                 .w400),
                                                    //                               ),
                                                    //                               TextSpan(
                                                    //                                 text: "£100",
                                                    //                                 style: Theme.of(context)
                                                    //                                     .textTheme
                                                    //                                     .headlineSmall!
                                                    //                                     .copyWith(
                                                    //                                         color: Colors
                                                    //                                             .blue), // Change to the desired blue color
                                                    //                               ),
                                                    //                               TextSpan(
                                                    //                                 text:
                                                    //                                     " by referring friends.",
                                                    //                                 style: Theme.of(context)
                                                    //                                     .textTheme
                                                    //                                     .titleLarge!
                                                    //                                     .copyWith(
                                                    //                                         color: AppColors
                                                    //                                             .ratingcommenttextcolor,
                                                    //                                         fontWeight:
                                                    //                                             FontWeight
                                                    //                                                 .w400),
                                                    //                               ),
                                                    //                             ],
                                                    //                           ),
                                                    //                         ),
                                                    //                         SizedBox(
                                                    //                             height: Get.height * 0.055),
                                                    //                         TextFormField(
                                                    //                           style: Theme.of(context)
                                                    //                               .textTheme
                                                    //                               .bodyLarge
                                                    //                               ?.copyWith(
                                                    //                                   color: Color(0xff000000),
                                                    //                                   fontWeight:
                                                    //                                       FontWeight.w600),
                                                    //                           decoration: InputDecoration(
                                                    //                             contentPadding:
                                                    //                                 EdgeInsets.symmetric(
                                                    //                                     horizontal:
                                                    //                                         Get.width * 0.06,
                                                    //                                     vertical:
                                                    //                                         Get.height * 0.027),
                                                    //                             enabledBorder:
                                                    //                                 OutlineInputBorder(
                                                    //                               borderRadius:
                                                    //                                   BorderRadius.circular(35),
                                                    //                               borderSide: const BorderSide(
                                                    //                                 color: AppColors.blackdown,
                                                    //                               ),
                                                    //                             ),
                                                    //                             focusedBorder:
                                                    //                                 OutlineInputBorder(
                                                    //                               borderRadius:
                                                    //                                   BorderRadius.circular(35),
                                                    //                               borderSide: const BorderSide(
                                                    //                                 color: AppColors.blackdown,
                                                    //                               ),
                                                    //                             ),
                                                    //                             hintText: 'Name',
                                                    //                             filled: true,
                                                    //                             fillColor: AppColors.white
                                                    //                                 .withOpacity(0.1),
                                                    //                             hintStyle: Theme.of(context)
                                                    //                                 .textTheme
                                                    //                                 .bodyMedium
                                                    //                                 ?.copyWith(
                                                    //                                     color:
                                                    //                                         Color(0xffCFCFCF),
                                                    //                                     fontWeight:
                                                    //                                         FontWeight.w500),
                                                    //                           ),
                                                    //                           onFieldSubmitted: (value) {},
                                                    //                           validator: (value) {
                                                    //                             if (value == null ||
                                                    //                                 value.isEmpty) {
                                                    //                               return 'Please enter your name';
                                                    //                             }
                                                    //                             return null;
                                                    //                           },
                                                    //                         ),
                                                    //                         SizedBox(
                                                    //                             height: Get.height * 0.018),
                                                    //                         TextFormField(
                                                    //                           style: Theme.of(context)
                                                    //                               .textTheme
                                                    //                               .bodyLarge
                                                    //                               ?.copyWith(
                                                    //                                   color: Color(0xff000000),
                                                    //                                   fontWeight:
                                                    //                                       FontWeight.w600),
                                                    //                           decoration: InputDecoration(
                                                    //                             contentPadding:
                                                    //                                 EdgeInsets.symmetric(
                                                    //                                     horizontal:
                                                    //                                         Get.width * 0.06,
                                                    //                                     vertical:
                                                    //                                         Get.height * 0.027),
                                                    //                             enabledBorder:
                                                    //                                 OutlineInputBorder(
                                                    //                               borderRadius:
                                                    //                                   BorderRadius.circular(35),
                                                    //                               borderSide: const BorderSide(
                                                    //                                 color: AppColors.blackdown,
                                                    //                               ),
                                                    //                             ),
                                                    //                             focusedBorder:
                                                    //                                 OutlineInputBorder(
                                                    //                               borderRadius:
                                                    //                                   BorderRadius.circular(35),
                                                    //                               borderSide: const BorderSide(
                                                    //                                 color: AppColors.blackdown,
                                                    //                               ),
                                                    //                             ),
                                                    //                             hintText: 'Email address',
                                                    //                             filled: true,
                                                    //                             fillColor: AppColors.white
                                                    //                                 .withOpacity(0.1),
                                                    //                             hintStyle: Theme.of(context)
                                                    //                                 .textTheme
                                                    //                                 .bodyMedium
                                                    //                                 ?.copyWith(
                                                    //                                     color:
                                                    //                                         Color(0xffCFCFCF),
                                                    //                                     fontWeight:
                                                    //                                         FontWeight.w500),
                                                    //                           ),
                                                    //                           onFieldSubmitted: (value) {},
                                                    //                           validator: (value) {
                                                    //                             if (value == null ||
                                                    //                                 value.isEmpty) {
                                                    //                               return 'Please enter an email address';
                                                    //                             } else if (!_isValidEmail(
                                                    //                                 value)) {
                                                    //                               return 'Please enter a valid email address';
                                                    //                             }
                                                    //                             return null;
                                                    //                           },
                                                    //                         ),
                                                    //                         SizedBox(
                                                    //                             height: Get.height * 0.035),
                                                    //                         Center(
                                                    //                           child: MyButton(
                                                    //                             title: "CONTINUE",
                                                    //                             onTap1: () {
                                                    //                               // Get.to(() => LocationPopUp());
                                                    //                             },
                                                    //                           ),
                                                    //                         ),
                                                    //                         SizedBox(height: Get.height * 0.02),
                                                    //                       ],
                                                    //                     ),
                                                    //                   ),
                                                    //                 ),
                                                    //                 //**************** for close on alert dialog **************
                                                    //                 Stack(children: [
                                                    //                   GestureDetector(
                                                    //                     onTap: () {
                                                    //                       Navigator.of(context)
                                                    //                           .pop(); // Close the dialog
                                                    //                     },
                                                    //                     child: Align(
                                                    //                       alignment:
                                                    //                           AlignmentDirectional.topEnd,
                                                    //                       child: Container(
                                                    //                         height: Get.height * 0.50,
                                                    //                         width: Get.width * 0.50,
                                                    //                         child: Center(
                                                    //                           child: Stack(children: [
                                                    //                             Positioned(
                                                    //                                 top: Get.height * 0.135,
                                                    //                                 right: Get.width * 0.10,
                                                    //                                 child: Container(
                                                    //                                   decoration: BoxDecoration(
                                                    //                                     borderRadius:
                                                    //                                         BorderRadius
                                                    //                                             .circular(60.0),
                                                    //                                     gradient:
                                                    //                                         const LinearGradient(
                                                    //                                       colors: [
                                                    //                                         Color(0xFF56B8F6),
                                                    //                                         Color(0xFF4D6FED),
                                                    //                                       ],
                                                    //                                       begin: Alignment
                                                    //                                           .topCenter, // Start from the top center
                                                    //                                       end: Alignment
                                                    //                                           .bottomCenter, // End at the bottom center
                                                    //                                     ),
                                                    //                                   ),
                                                    //                                   child: Icon(
                                                    //                                     Icons.close,
                                                    //                                     color: AppColors.white,
                                                    //                                     size:
                                                    //                                         Get.height * 0.028,
                                                    //                                   ),
                                                    //                                 )),
                                                    //                           ]),
                                                    //                         ),
                                                    //                       ),
                                                    //                     ),
                                                    //                   ),
                                                    //                   // ******************* for close icon in in *************
                                                    //                 ])
                                                    //               ]);
                                                    //             },
                                                    //           );
                                                    //         },
                                                    //         child: Stack(
                                                    //           children: [
                                                    //             Image.asset(
                                                    //               'assets/images/personicons.png',
                                                    //               height: Get.height * .05,
                                                    //             ),
                                                    //             // CircleAvatar(
                                                    //             //   backgroundColor: AppColors.blueThemeColor,
                                                    //             //   radius: 17,
                                                    //             //   child: Image.asset(
                                                    //             //       'assets/images/personicons.png'),
                                                    //             // ),
                                                    //           ],
                                                    //         ),
                                                    //       ),
                                                    //       // IconButton(
                                                    //       //   onPressed: text.isEmpty &&
                                                    //       //           imagePaths.isEmpty &&
                                                    //       //           uri.isEmpty
                                                    //       //       ? null
                                                    //       //       : () => _onShare(context),
                                                    //       //   icon: SvgPicture.asset(
                                                    //       //     'assets/images/sharesvg.svg',
                                                    //       //   ),
                                                    //       // ),
                                                    //       // Text("2",
                                                    //       //     style: Theme.of(context)
                                                    //       //         .textTheme
                                                    //       //         .bodySmall!
                                                    //       //         .copyWith(
                                                    //       //             color: AppColors.white, fontSize: 14)),
                                                    //     ],
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );

                                    // HomeSwiperWidget(jobData: getJobsListingController.getJobsListing.value.jobs?[index],index: index,);

                                  },
                                )
                                    : jobFilterController.jobsData.value.jobs?.length == 0 ||
                                    jobFilterController.jobsData.value.jobs == null ?
                                const SeekerNoJobAvailable() : CardSwiper(
                                  controller: controller,
                                  cardsCount: jobFilterController.jobsData.value.jobs?.length ?? 0 ,
                                  numberOfCardsDisplayed: jobFilterController.jobsData.value.jobs?.length == 1 ? 1 : 2,
                                  backCardOffset: const Offset(40, 40),
                                  padding: const EdgeInsets.all(24.0),
                                  allowedSwipeDirection: AllowedSwipeDirection.only(left: true,right: true , up : true),
                                  onSwipe: _onSwipe,
                                  cardBuilder: (context, index,
                                      horizontalThresholdPercentage, verticalThresholdPercentage,) {
                                    var data = jobFilterController.jobsData.value.jobs?[index] ;
                                    return  Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.blackdown, borderRadius: BorderRadius.circular(34)),
                                      height: Get.height,
                                      width: Get.width,
                                      child: Stack(
                                        children: [
                                          //************* for swiper image ************

                                          GestureDetector(
                                            onTap: () {
                                              Get.to(() => MarketingIntern(jobData: data, appliedJobScreen: false,));
                                            },
                                            child: Container(
                                              decoration:
                                              BoxDecoration(borderRadius: BorderRadius.circular(26)),
                                              width: Get.width,
                                              height: Get.height * 0.5,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      placeholder: (context, url) =>
                                                      const Center(child: CircularProgressIndicator()),
                                                      imageUrl: "${data?.featureImg}")
                                              ),
                                            ),
                                          ),
                                          //************* for 50% match ************
                                          Positioned(
                                            right: 20,
                                            top: 10,
                                            child: Stack(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showSeekerHomePagePercentageProfile(context,data) ;
                                                  },
                                                  child: Container(
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
                                                              radius: 30,
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
                                                )
                                              ],
                                            ),
                                          ),
                                          //************* for bookmarks ************

                                          Positioned(
                                            left: 12,
                                            top: 15,
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      // getJobsListingController.saved.value=true;
                                                      CommonFunctions.confirmationDialog(context, message: jobFilterController.jobsData.value.jobs?[index].postSaved ?
                                                      "Do you want to remove the\n post from saved posts" : "Do you want to save the post", onTap: () async {
                                                        Get.back();
                                                        if(data?.postSaved == true) {
                                                          CommonFunctions.showLoadingDialog(context, "removing...");
                                                          var result = await unSavePostController.unSavePost(data?.id.toString(), "1", context,true) ;
                                                          if(result == true) {
                                                            if (kDebugMode) {
                                                              print("inside result") ;
                                                            }
                                                            jobFilterController.jobsData.value.jobs?[index].postSaved = false ;
                                                            setState(() {});
                                                          }
                                                        } else {
                                                          CommonFunctions.showLoadingDialog(context, "Saving");
                                                          var result = await seekerSaveJobController.saveJobApi(data?.id, 1) ;
                                                          if(result == true) {
                                                            if (kDebugMode) {
                                                              print("inside result") ;
                                                            }
                                                            jobFilterController.jobsData.value.jobs?[index].postSaved = true ;
                                                            setState(() {});
                                                          }
                                                        }
                                                      });
                                                    },
                                                    child:  jobFilterController.jobsData.value.jobs?[index].postSaved == false  ?
                                                    Image.asset("assets/images/icon_unsave_post.png",
                                                      height: Get.height * .043,
                                                    ):
                                                    Image.asset("assets/images/icon_Save_post.png",
                                                      height: Get.height * .043,
                                                    )
                                                ),
                                                SizedBox(
                                                  height: Get.height * .01,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      Get.to(() => const FilterPage());
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/icon_filter_seeker_home.png",
                                                      height: Get.height * .043,
                                                    )),
                                                SizedBox(
                                                  height: Get.height * .01,
                                                ),

                                                GestureDetector(
                                                  onTap: () {
                                                    if( data?.video == null || data?.video?.length == 0 ){
                                                      Utils.showMessageDialog(context, "video not uploaded yet") ;
                                                    }
                                                    else{
                                                      Get.back() ;
                                                      Get.to(() => VideoPlayerScreen(videoPath: data?.video ?? "")) ;
                                                    }
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 34,
                                                    width: 34,
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
                                                data?.jobMatchPercentage == 100 ?
                                                InkWell(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 34,
                                                    width: 34,
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors.blueThemeColor
                                                    ),
                                                    child: Image.asset(
                                                      'assets/images/icon_msg_blue.png',height: Get.height*.06,),
                                                  ),
                                                  onTap: (){
                                                    RecruiterId=data?.recruiterId.toString();
                                                    Recruitername=data?.recruiterDetails?.companyName;
                                                    Recruiterimg=data?.recruiterDetails?.profileImg;

                                                    setState(() {
                                                      RecruiterId;
                                                      Recruitername;
                                                      Recruiterimg;
                                                    });
                                                    if (kDebugMode) {
                                                      print( RecruiterId);
                                                      print( Recruitername);
                                                      print( Recruiterimg);
                                                    }
                                                    Ctreatechatinstance.CreateChat();
                                                  },
                                                ) : const SizedBox(),
                                              ],
                                            ),
                                          ),
                                          //************* for marketing intern text  ************
                                          Positioned(
                                            //height: Get.height / 2.5-Get.height*0.12 ,
                                            bottom: Get.height * 0.05,
                                            left: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(() => MarketingIntern(jobData: data, appliedJobScreen: false,));
                                              },
                                              child: Container(
                                                height: Get.height * 0.35,
                                                padding: const EdgeInsets.all(20),
                                                decoration: const BoxDecoration(
                                                  color: AppColors.blackdown,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(22),
                                                      topRight: Radius.circular(22)),
                                                ),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        data?.jobTitle ?? "", overflow: TextOverflow.ellipsis,
                                                        style: Theme.of(context).textTheme.displayLarge,
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * .003,
                                                      ),
                                                      Text(
                                                        data?.jobPositions ?? "",overflow: TextOverflow.ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                                        softWrap: true,
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * .003,
                                                      ),
                                                      Text(
                                                        data?.recruiterDetails?.companyName ?? "",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * 0.03,
                                                      ),
                                                      Text(
                                                        "Job Description",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall
                                                            ?.copyWith(fontWeight: FontWeight.w700),
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * .008,
                                                      ),
                                                      data?.description == null || data?.description.toString().length == 0 ?
                                                      Text("No job description",style: TextStyle(color: Colors.white),) :
                                                      HtmlWidget(data?.description ?? "No job description",textStyle: Theme.of(context).textTheme.labelLarge!
                                                          .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),),
                                                      SizedBox(
                                                        height: Get.height * 0.03,
                                                      ),
                                                      Text(
                                                        "Requirements",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall
                                                            ?.copyWith(fontWeight: FontWeight.w700),
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * .007,
                                                      ),
                                                      HtmlWidget(data?.requirements ?? "No requirements",textStyle: Theme.of(context).textTheme.labelLarge!
                                                          .copyWith(color: AppColors.ratingcommenttextcolor,fontWeight: FontWeight.w400),),
                                                      SizedBox(
                                                        height: Get.height * .02,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Align(
                                              alignment: AlignmentDirectional.bottomCenter,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[900],
                                                  borderRadius: const BorderRadius.only(
                                                      bottomLeft: Radius.circular(20),
                                                      bottomRight: Radius.circular(22)),
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    // Row(
                                                    //   children: [
                                                    //     IconButton(
                                                    //         onPressed: () => toggleFavorite(),
                                                    //         icon: selectedFav == false
                                                    //             ? SvgPicture.asset(
                                                    //                 'assets/images/likesvg.svg',
                                                    //                 width: Get.width * 0.027,
                                                    //                 height: Get.height * 0.027,
                                                    //                 color: buttonColor,
                                                    //               )
                                                    //             : const Icon(
                                                    //                 Icons.favorite_rounded,
                                                    //                 color: AppColors.red,
                                                    //               )),
                                                    //     Text("12",
                                                    //         style: Theme.of(context)
                                                    //             .textTheme
                                                    //             .bodySmall!
                                                    //             .copyWith(
                                                    //                 color: AppColors.white, fontSize: 14)),
                                                    //     SizedBox(
                                                    //       width: Get.width * 0.04,
                                                    //     ),
                                                    //
                                                    //     //*************************
                                                    //
                                                    //     IconButton(
                                                    //       onPressed: () {
                                                    //         showCommentDialog();
                                                    //       },
                                                    //       icon:
                                                    //           SvgPicture.asset('assets/images/commentsvg.svg'),
                                                    //     ),
                                                    //     Text("10",
                                                    //         style: Theme.of(context)
                                                    //             .textTheme
                                                    //             .bodySmall!
                                                    //             .copyWith(
                                                    //                 color: AppColors.white, fontSize: 14)),
                                                    //   ],
                                                    // ),
                                                    // Padding(
                                                    //   padding: const EdgeInsets.only(right: 14.0),
                                                    //   child: Row(
                                                    //     children: [
                                                    //       InkWell(
                                                    //         onTap: () {
                                                    //           showDialog(
                                                    //             barrierDismissible: false,
                                                    //             context: context,
                                                    //             builder: (BuildContext context) {
                                                    //               return Stack(children: [
                                                    //                 AlertDialog(
                                                    //                   shape: RoundedRectangleBorder(
                                                    //                       borderRadius:
                                                    //                           BorderRadius.circular(17)),
                                                    //                   //contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                                                    //                   content: SingleChildScrollView(
                                                    //                     child: Column(
                                                    //                       children: [
                                                    //                         Image.asset(
                                                    //                             'assets/images/personpng.png'),
                                                    //                         SizedBox(height: Get.height * 0.02),
                                                    //                         Text(
                                                    //                           "Refer a friend",
                                                    //                           style: Theme.of(context)
                                                    //                               .textTheme
                                                    //                               .headlineSmall!
                                                    //                               .copyWith(
                                                    //                                   color: AppColors.white),
                                                    //                         ),
                                                    //                         SizedBox(height: Get.height * 0.01),
                                                    //                         Text.rich(
                                                    //                           TextSpan(
                                                    //                             children: [
                                                    //                               TextSpan(
                                                    //                                 text: "Earn up to ",
                                                    //                                 style: Theme.of(context)
                                                    //                                     .textTheme
                                                    //                                     .headlineSmall!
                                                    //                                     .copyWith(
                                                    //                                         color: AppColors
                                                    //                                             .ratingcommenttextcolor,
                                                    //                                         fontWeight:
                                                    //                                             FontWeight
                                                    //                                                 .w400),
                                                    //                               ),
                                                    //                               TextSpan(
                                                    //                                 text: "£100",
                                                    //                                 style: Theme.of(context)
                                                    //                                     .textTheme
                                                    //                                     .headlineSmall!
                                                    //                                     .copyWith(
                                                    //                                         color: Colors
                                                    //                                             .blue), // Change to the desired blue color
                                                    //                               ),
                                                    //                               TextSpan(
                                                    //                                 text:
                                                    //                                     " by referring friends.",
                                                    //                                 style: Theme.of(context)
                                                    //                                     .textTheme
                                                    //                                     .titleLarge!
                                                    //                                     .copyWith(
                                                    //                                         color: AppColors
                                                    //                                             .ratingcommenttextcolor,
                                                    //                                         fontWeight:
                                                    //                                             FontWeight
                                                    //                                                 .w400),
                                                    //                               ),
                                                    //                             ],
                                                    //                           ),
                                                    //                         ),
                                                    //                         SizedBox(
                                                    //                             height: Get.height * 0.055),
                                                    //                         TextFormField(
                                                    //                           style: Theme.of(context)
                                                    //                               .textTheme
                                                    //                               .bodyLarge
                                                    //                               ?.copyWith(
                                                    //                                   color: Color(0xff000000),
                                                    //                                   fontWeight:
                                                    //                                       FontWeight.w600),
                                                    //                           decoration: InputDecoration(
                                                    //                             contentPadding:
                                                    //                                 EdgeInsets.symmetric(
                                                    //                                     horizontal:
                                                    //                                         Get.width * 0.06,
                                                    //                                     vertical:
                                                    //                                         Get.height * 0.027),
                                                    //                             enabledBorder:
                                                    //                                 OutlineInputBorder(
                                                    //                               borderRadius:
                                                    //                                   BorderRadius.circular(35),
                                                    //                               borderSide: const BorderSide(
                                                    //                                 color: AppColors.blackdown,
                                                    //                               ),
                                                    //                             ),
                                                    //                             focusedBorder:
                                                    //                                 OutlineInputBorder(
                                                    //                               borderRadius:
                                                    //                                   BorderRadius.circular(35),
                                                    //                               borderSide: const BorderSide(
                                                    //                                 color: AppColors.blackdown,
                                                    //                               ),
                                                    //                             ),
                                                    //                             hintText: 'Name',
                                                    //                             filled: true,
                                                    //                             fillColor: AppColors.white
                                                    //                                 .withOpacity(0.1),
                                                    //                             hintStyle: Theme.of(context)
                                                    //                                 .textTheme
                                                    //                                 .bodyMedium
                                                    //                                 ?.copyWith(
                                                    //                                     color:
                                                    //                                         Color(0xffCFCFCF),
                                                    //                                     fontWeight:
                                                    //                                         FontWeight.w500),
                                                    //                           ),
                                                    //                           onFieldSubmitted: (value) {},
                                                    //                           validator: (value) {
                                                    //                             if (value == null ||
                                                    //                                 value.isEmpty) {
                                                    //                               return 'Please enter your name';
                                                    //                             }
                                                    //                             return null;
                                                    //                           },
                                                    //                         ),
                                                    //                         SizedBox(
                                                    //                             height: Get.height * 0.018),
                                                    //                         TextFormField(
                                                    //                           style: Theme.of(context)
                                                    //                               .textTheme
                                                    //                               .bodyLarge
                                                    //                               ?.copyWith(
                                                    //                                   color: Color(0xff000000),
                                                    //                                   fontWeight:
                                                    //                                       FontWeight.w600),
                                                    //                           decoration: InputDecoration(
                                                    //                             contentPadding:
                                                    //                                 EdgeInsets.symmetric(
                                                    //                                     horizontal:
                                                    //                                         Get.width * 0.06,
                                                    //                                     vertical:
                                                    //                                         Get.height * 0.027),
                                                    //                             enabledBorder:
                                                    //                                 OutlineInputBorder(
                                                    //                               borderRadius:
                                                    //                                   BorderRadius.circular(35),
                                                    //                               borderSide: const BorderSide(
                                                    //                                 color: AppColors.blackdown,
                                                    //                               ),
                                                    //                             ),
                                                    //                             focusedBorder:
                                                    //                                 OutlineInputBorder(
                                                    //                               borderRadius:
                                                    //                                   BorderRadius.circular(35),
                                                    //                               borderSide: const BorderSide(
                                                    //                                 color: AppColors.blackdown,
                                                    //                               ),
                                                    //                             ),
                                                    //                             hintText: 'Email address',
                                                    //                             filled: true,
                                                    //                             fillColor: AppColors.white
                                                    //                                 .withOpacity(0.1),
                                                    //                             hintStyle: Theme.of(context)
                                                    //                                 .textTheme
                                                    //                                 .bodyMedium
                                                    //                                 ?.copyWith(
                                                    //                                     color:
                                                    //                                         Color(0xffCFCFCF),
                                                    //                                     fontWeight:
                                                    //                                         FontWeight.w500),
                                                    //                           ),
                                                    //                           onFieldSubmitted: (value) {},
                                                    //                           validator: (value) {
                                                    //                             if (value == null ||
                                                    //                                 value.isEmpty) {
                                                    //                               return 'Please enter an email address';
                                                    //                             } else if (!_isValidEmail(
                                                    //                                 value)) {
                                                    //                               return 'Please enter a valid email address';
                                                    //                             }
                                                    //                             return null;
                                                    //                           },
                                                    //                         ),
                                                    //                         SizedBox(
                                                    //                             height: Get.height * 0.035),
                                                    //                         Center(
                                                    //                           child: MyButton(
                                                    //                             title: "CONTINUE",
                                                    //                             onTap1: () {
                                                    //                               // Get.to(() => LocationPopUp());
                                                    //                             },
                                                    //                           ),
                                                    //                         ),
                                                    //                         SizedBox(height: Get.height * 0.02),
                                                    //                       ],
                                                    //                     ),
                                                    //                   ),
                                                    //                 ),
                                                    //                 //**************** for close on alert dialog **************
                                                    //                 Stack(children: [
                                                    //                   GestureDetector(
                                                    //                     onTap: () {
                                                    //                       Navigator.of(context)
                                                    //                           .pop(); // Close the dialog
                                                    //                     },
                                                    //                     child: Align(
                                                    //                       alignment:
                                                    //                           AlignmentDirectional.topEnd,
                                                    //                       child: Container(
                                                    //                         height: Get.height * 0.50,
                                                    //                         width: Get.width * 0.50,
                                                    //                         child: Center(
                                                    //                           child: Stack(children: [
                                                    //                             Positioned(
                                                    //                                 top: Get.height * 0.135,
                                                    //                                 right: Get.width * 0.10,
                                                    //                                 child: Container(
                                                    //                                   decoration: BoxDecoration(
                                                    //                                     borderRadius:
                                                    //                                         BorderRadius
                                                    //                                             .circular(60.0),
                                                    //                                     gradient:
                                                    //                                         const LinearGradient(
                                                    //                                       colors: [
                                                    //                                         Color(0xFF56B8F6),
                                                    //                                         Color(0xFF4D6FED),
                                                    //                                       ],
                                                    //                                       begin: Alignment
                                                    //                                           .topCenter, // Start from the top center
                                                    //                                       end: Alignment
                                                    //                                           .bottomCenter, // End at the bottom center
                                                    //                                     ),
                                                    //                                   ),
                                                    //                                   child: Icon(
                                                    //                                     Icons.close,
                                                    //                                     color: AppColors.white,
                                                    //                                     size:
                                                    //                                         Get.height * 0.028,
                                                    //                                   ),
                                                    //                                 )),
                                                    //                           ]),
                                                    //                         ),
                                                    //                       ),
                                                    //                     ),
                                                    //                   ),
                                                    //                   // ******************* for close icon in in *************
                                                    //                 ])
                                                    //               ]);
                                                    //             },
                                                    //           );
                                                    //         },
                                                    //         child: Stack(
                                                    //           children: [
                                                    //             Image.asset(
                                                    //               'assets/images/personicons.png',
                                                    //               height: Get.height * .05,
                                                    //             ),
                                                    //             // CircleAvatar(
                                                    //             //   backgroundColor: AppColors.blueThemeColor,
                                                    //             //   radius: 17,
                                                    //             //   child: Image.asset(
                                                    //             //       'assets/images/personicons.png'),
                                                    //             // ),
                                                    //           ],
                                                    //         ),
                                                    //       ),
                                                    //       // IconButton(
                                                    //       //   onPressed: text.isEmpty &&
                                                    //       //           imagePaths.isEmpty &&
                                                    //       //           uri.isEmpty
                                                    //       //       ? null
                                                    //       //       : () => _onShare(context),
                                                    //       //   icon: SvgPicture.asset(
                                                    //       //     'assets/images/sharesvg.svg',
                                                    //       //   ),
                                                    //       // ),
                                                    //       // Text("2",
                                                    //       //     style: Theme.of(context)
                                                    //       //         .textTheme
                                                    //       //         .bodySmall!
                                                    //       //         .copyWith(
                                                    //       //             color: AppColors.white, fontSize: 14)),
                                                    //     ],
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );

                                  },
                                ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    );}
                  ),
                );
            }
          }) ;

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
        // print("swiped left");
      } else if (direction.name == "right") {
        CommonFunctions.confirmationDialog(context, message: "Do you want to Apply for the post", onTap: () {
          Get.back() ;
          CommonFunctions.showLoadingDialog(context, "Applying") ;
          jobFilterController.reset.value ?   applyJobController.applyJob(getJobsListingController.getJobsListing.value.jobs?[previousIndex].id.toString()) :
          applyJobController.applyJob(jobFilterController.jobsData.value.jobs?[previousIndex].id.toString()) ;
        }) ;
      } else if (direction.name == "top") {
        CommonFunctions.confirmationDialog(context, message: "Do you want to save the post", onTap: () {
          Get.back() ;
          CommonFunctions.showLoadingDialog(context, "Saving") ;
          jobFilterController.reset.value ?  seekerSaveJobController.saveJobApi(getJobsListingController.getJobsListing.value.jobs?[previousIndex].id , 1) :
          seekerSaveJobController.saveJobApi(jobFilterController.jobsData.value.jobs?[previousIndex].id , 1) ;
        }) ;
      }
    }
      return true;

  }

  void showSeekerHomePagePercentageProfile(BuildContext context , dynamic data) {
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
                              borderRadius: BorderRadius.circular(12),),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),),

                        ],
                      ),
                    )],),
                SizedBox(height: Get.height*.03,) ,
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
                ) ,
                SizedBox(height: Get.height*.03,) ,
                Text('Profile Match ${data?.jobMatchPercentage}%',style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
                SizedBox(height: Get.height*.015,) ,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("According to your skills your profile is match for this job.",textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: AppColors.graySilverColor,),),
                ) ,
                SizedBox(height: Get.height*.05,) ,
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
  void showPound(BuildContext context ,String companyName, dynamic minimumSalary) {
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
                SizedBox(height: Get.height*.015,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width*.6,
                        child: Text(companyName,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.displaySmall,)) ,
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.blueThemeColor,
                          borderRadius: BorderRadius.circular(12),),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),),
                    ),
                  ],
                ),
                SizedBox(height: Get.height*.015,),
                SizedBox(
                  height: Get.height*.2,
                  child: Stack(
                    children: [
                      Center(child: Image.asset("assets/images/icon_earn.png",height: Get.height*.2,)),
                      Center(
                        child: Text("$minimumSalary £",style: Theme.of(context).textTheme.displaySmall,),
                      )
                    ],
                  ),
                ),
                //Text("According to this job you will get $minimumSalary for successful referral",textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: AppColors.graySilverColor,),),
                SizedBox(height: Get.height*.015,),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.graySilverColor,
                    ),
                    children: [
                      const TextSpan(text: 'According to this job you will get '),
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
                SizedBox(height: Get.height*.03,),
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
