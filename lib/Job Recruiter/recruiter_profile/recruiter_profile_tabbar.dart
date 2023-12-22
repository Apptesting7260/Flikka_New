import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Recruiter/RecruiterDrawer/drawer_recruiter.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/about.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/home.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/jobs.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/recruiter_profile_edit.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/review.dart';
import 'package:flikka/Job%20Seeker/SeekerDrawer/Drawer_page.dart';
import 'package:flikka/controllers/SeekerViewCompanyController/SeekerViewCompanyController.dart';
import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../bottom_bar/tab_bar.dart';

class RecruiterProfileTabBar extends StatefulWidget {
 final int? index; final bool? isSeeker ; final String? recruiterID ;
  const RecruiterProfileTabBar({ this.index, this.isSeeker, this.recruiterID , super.key,});

  @override
  State<RecruiterProfileTabBar> createState() => _RecruiterProfileTabBarState();
}

class _RecruiterProfileTabBarState extends State<RecruiterProfileTabBar> {
  ViewRecruiterProfileGetController viewRecruiterProfileController = Get.put(ViewRecruiterProfileGetController());
  SeekerViewCompanyController seekerViewCompanyController = Get.put(SeekerViewCompanyController()) ;

  //////refresh//////
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  RefreshController seekerRefreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await viewRecruiterProfileController.viewRecruiterProfileApi();
    _refreshController.refreshCompleted();
  }
  void _onSeekerRefresh() async{
    await seekerViewCompanyController.viewCompany(widget.recruiterID) ;
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await viewRecruiterProfileController.viewRecruiterProfile();
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  void _onSeekerLoading() async{
    await seekerViewCompanyController.viewCompany(widget.recruiterID) ;
    if(mounted)
      setState(() {

      });
    seekerRefreshController.loadComplete();
  }
  /////refresh/////

  int pageIndex = 0;

  String? name ;
  String? position ;
  String? location ;
  String? profileImg ;


  @override
  void initState() {
    pageIndex = widget.index ?? 0;
    if(widget.isSeeker == null || widget.isSeeker == false) {
      viewRecruiterProfileController.viewRecruiterProfileApi();
    } else {
      seekerViewCompanyController.viewCompany(widget.recruiterID) ;
      initializeSeeker() ;
    }
    super.initState();
  }

  initializeSeeker () async {
    SharedPreferences sp = await SharedPreferences.getInstance() ;
    name = sp.getString("seekerName") ;
    location = sp.getString("seekerLocation") ;
    position = sp.getString("seekerPosition") ;
    profileImg = sp.getString("seekerProfileImg") ;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSeeker == null || widget.isSeeker == false) {
      return Obx(() {
        switch (viewRecruiterProfileController.rxRequestStatus.value) {
          case Status.LOADING:
            return const Scaffold(
              backgroundColor: Color(0xff000),
              body: Center(child: CircularProgressIndicator()),
            );
          case Status.ERROR:
            if (viewRecruiterProfileController.error.value == 'No internet') {
              return InterNetExceptionWidget(
                onPress: () {
                  viewRecruiterProfileController.viewRecruiterProfileApi();
                },
              );
            } else {
              return Scaffold(
                  backgroundColor: Color(0xff000),
                  body: GeneralExceptionWidget(onPress: () {
                    viewRecruiterProfileController.viewRecruiterProfileApi();
                  }));
            }
          case Status.COMPLETED:
            return Scaffold(
                endDrawer: const DrawerRecruiter(),
                appBar: AppBar(
                  toolbarHeight: 60,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: InkWell(
                        onTap: () {
                          Get.offAll(TabScreenEmployer(index: 0));
                        },
                        child: Image.asset('assets/images/icon_back_blue.png')),
                  ),
                  title: Text(
                    viewRecruiterProfileController.viewRecruiterProfile.value
                        .recruiterProfileDetails?.companyName ?? "",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  actions: [
                    Builder(
                        builder: (context) {
                          return InkWell(
                              onTap: () => Scaffold.of(context).openEndDrawer(),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 10, right: 10),
                                child: Image.asset(
                                  'assets/images/inactive.png',
                                  height: Get.height * .05,
                                ),
                              ));
                        }
                    )
                  ],
                ),

                body: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: DefaultTabController(
                    initialIndex: pageIndex,
                    length: 4,
                    child: Column(
                        children: [
                          Obx(() =>
                          viewRecruiterProfileController.refreshLoading.value ?
                          const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ) : const SizedBox()
                          ),
                          SizedBox(height: Get.height * .025,),
                          SizedBox(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: Get.height * .22,
                                  width: Get.width,
                                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    imageUrl:  viewRecruiterProfileController.viewRecruiterProfile.value.
                                recruiterProfileDetails?.coverImg ??
                                    "https://urlsdemo.xyz/flikka/public/images/seekers/defalt_profile.png",
                                ),
                                Positioned(
                                    bottom: -40,
                                    left: 10,
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                                        imageUrl:  viewRecruiterProfileController.viewRecruiterProfile.value.
                                    recruiterProfileDetails?.profileImg ??
                                        "https://urlsdemo.xyz/flikka/public/images/seekers/defalt_profile.png" ,
                                    imageBuilder: (context , imageProvider) => Container(
                                      height: Get.width *.25,
                                      width: Get.width *.25,
                                      decoration: BoxDecoration(shape: BoxShape.circle,
                                        image:  DecorationImage(image: imageProvider,fit: BoxFit.cover),),
                                    ),) ,
                                )],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Get.height * .017,
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                  children: [
                                    Text(
                                      viewRecruiterProfileController
                                          .viewRecruiterProfile
                                          .value
                                          .recruiterProfileDetails
                                          ?.companyName ??
                                          "",
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              RecruiterProfileEdit(
                                                profileModel: viewRecruiterProfileController
                                                    .viewRecruiterProfile
                                                    .value,));
                                        },
                                        child: Image.asset(
                                          "assets/images/icon_edit.png",
                                          height: 18,))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * .018,),
                          TabBar(
                            indicatorPadding: EdgeInsets.symmetric(horizontal: Get.width * .02),
                            isScrollable: true,
                            indicator: const UnderlineTabIndicator(
                              borderSide:
                              BorderSide(width: 2.0, color: AppColors.blueThemeColor),),
                            physics: const AlwaysScrollableScrollPhysics(),
                            unselectedLabelColor: const Color(0xffCFCFCF),
                            labelColor: AppColors.blueThemeColor,
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                            tabs: const [
                              Tab(text: "HOME"),
                              Tab(text: "ABOUT",),
                              Tab(text: "JOBS",),
                              Tab(text: "REVIEW",),
                            ],
                          ),
                          Flexible(
                            child: TabBarView(
                              children: [
                                RecruiterHome(
                                  recruiterProfileDetails: viewRecruiterProfileController
                                      .viewRecruiterProfile.value
                                      .recruiterProfileDetails,
                                ),
                                RecruiterAbout(
                                  recruiterProfileDetails: viewRecruiterProfileController
                                      .viewRecruiterProfile.value
                                      .recruiterProfileDetails,
                                ),
                                RecruiterJobs(
                                  recruiterJobsData: viewRecruiterProfileController
                                      .viewRecruiterProfile.value.jobs,
                                  company: viewRecruiterProfileController
                                      .viewRecruiterProfile
                                      .value
                                      .recruiterProfileDetails
                                      ?.companyName,
                                  location: viewRecruiterProfileController
                                      .viewRecruiterProfile
                                      .value
                                      .recruiterProfileDetails
                                      ?.companyLocation,
                                ),
                                Review(isSeeker: false,
                                  avgReview: viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.avgReview.toString(),
                                  totalReviews: viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.totalReview.toString(),
                                  reviews: viewRecruiterProfileController.viewRecruiterProfile.value.reviews, reviewPosted: viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.reviewPosted,),
                              ],
                            ),
                          ),
                        ]),
                  ),
                )
            );
        }
      });
    } else {
      return Obx(() {
        switch (seekerViewCompanyController.rxRequestStatus.value) {
          case Status.LOADING:
            return const Scaffold(
              backgroundColor: Color(0xff000),
              body: Center(child: CircularProgressIndicator()),
            );
          case Status.ERROR:
            if (seekerViewCompanyController.error.value == 'No internet') {
              return InterNetExceptionWidget(
                onPress: () {
                  seekerViewCompanyController.viewCompany(widget.recruiterID) ;
                },
              );
            } else {
              return Scaffold(
                  backgroundColor: const Color(0x000ff000),
                  body: GeneralExceptionWidget(onPress: () {
                    seekerViewCompanyController.viewCompany(widget.recruiterID) ;
                  }));
            }
          case Status.COMPLETED:
            return Scaffold(
                endDrawer: DrawerClass(
                    name: name ?? "", location: location ?? "", jobTitle: position ?? "",
                  profileImage: profileImg ?? "" ,),
                appBar: AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset('assets/images/icon_back_blue.png')),
                  ),
                  title: Text(
                    seekerViewCompanyController.companyData.value.recruiterProfileDetails?.companyName ?? "",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  actions: [
                    Builder(
                        builder: (context) {
                          return InkWell(
                              onTap: () => Scaffold.of(context).openEndDrawer(),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 10, right: 10),
                                child: Image.asset(
                                  'assets/images/inactive.png',
                                  height: Get.height * .05,
                                ),
                              ));
                        }
                    )

                  ],
                ),
                body: SmartRefresher(
                  controller: seekerRefreshController,
                  onRefresh: _onSeekerRefresh,
                  onLoading: _onSeekerLoading,
                  child: DefaultTabController(
                    initialIndex: pageIndex,
                    length: 4,
                    child: Column(
                        children: [
                          SizedBox(height: Get.height * .025,),
                          SizedBox(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: Get.height * .22,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              seekerViewCompanyController.companyData.value.recruiterProfileDetails?.coverImg ??
                                                  "https://urlsdemo.xyz/flikka/public/images/seekers/defalt_profile.png"),
                                          fit: BoxFit.cover)),
                                ),
                                Positioned(
                                    bottom: -40,
                                    left: 10,
                                    child: CircleAvatar(
                                      radius: Get.width * .13,
                                      backgroundImage: NetworkImage(
                                        seekerViewCompanyController.companyData.value.recruiterProfileDetails?.profileImg ??
                                            "https://urlsdemo.xyz/flikka/public/images/seekers/defalt_profile.png",
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Get.height * .017,
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                  children: [
                                    Text(
                                      seekerViewCompanyController.companyData.value.recruiterProfileDetails
                                          ?.companyName ?? "",
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * .018,),
                          TabBar(
                            indicatorPadding:
                            EdgeInsets.symmetric(
                                horizontal: Get.width * .02),
                            isScrollable: true,
                            indicator: const UnderlineTabIndicator(
                              borderSide:
                              BorderSide(width: 2.0,
                                  color: AppColors.blueThemeColor),
                            ),
                            physics: const AlwaysScrollableScrollPhysics(),
                            unselectedLabelColor: const Color(
                                0xffCFCFCF),
                            labelColor: AppColors.blueThemeColor,
                            labelStyle: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium,
                            tabs: const [
                              Tab(text: "HOME"),
                              Tab(text: "ABOUT",),
                              Tab(text: "JOBS",),
                              Tab(text: "REVIEW",),
                            ],
                          ),
                          Flexible(
                            // flex: 4,
                            child: TabBarView(
                              children: [
                                RecruiterHome(
                                  recruiterProfileDetails: seekerViewCompanyController.companyData.value.recruiterProfileDetails,
                                ),
                                RecruiterAbout(
                                  recruiterProfileDetails: seekerViewCompanyController.companyData.value.recruiterProfileDetails,
                                ),
                                RecruiterJobs(
                                  recruiterJobsData: seekerViewCompanyController.companyData.value.jobs,
                                  company: seekerViewCompanyController.companyData.value.recruiterProfileDetails?.companyName,
                                  location: seekerViewCompanyController.companyData.value.recruiterProfileDetails?.companyLocation,
                                  isSeeker: true,
                                ),
                                 Review(isSeeker: true,
                                   avgReview: seekerViewCompanyController.companyData.value.recruiterProfileDetails?.avgReview.toString(),
                                   totalReviews: seekerViewCompanyController.companyData.value.recruiterProfileDetails?.totalReview.toString(),
                                   reviews: seekerViewCompanyController.companyData.value.reviews,
                                   recruiterID: widget.recruiterID,
                                   reviewPosted: seekerViewCompanyController.companyData.value.recruiterProfileDetails?.reviewPosted,),
                              ],
                            ),
                          ),
                        ]),
                  ),
                )
            );
        }
      });
    }
  }
}
