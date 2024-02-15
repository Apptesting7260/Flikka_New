import 'package:flikka/Job%20Seeker/Authentication/user/user_profile.dart';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/TabBarController.dart';
import 'package:flikka/Job%20Seeker/SeekerCompanies/companies_seeker_page.dart';
import 'package:flikka/Job%20Seeker/SeekerForum/forum_first_page.dart';
import 'package:flikka/Job%20Seeker/help%20section/help.dart';
import 'package:flikka/widgets/google_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controllers/AvtarImageListController/AvtarImageListController.dart';
import '../../controllers/CompaniesListController/CompaniesListController.dart';
import '../../controllers/GetJobsListingController/GetJobsListingController.dart';
import '../../controllers/SeekerChoosePositionGetController/SeekerChoosePositionGetController.dart';
import '../../controllers/SeekerEarningController/SeekerEarningController.dart';
import '../../controllers/SeekerForumController/ForumIndustryListController.dart';
import '../../controllers/SeekerForumController/SeekerForumDataController.dart';
import '../../controllers/SeekerGetAllSkillsController/SeekerGetAllSkillsController.dart';
import '../../controllers/SeekerJobAlertListController/SeekerJobAlertListController.dart';
import '../../controllers/SeekerMapJobsController/SeekerMapJobsController.dart';
import '../../controllers/SeekerNotificationDataViewController/SeekerNotificationViewDataController.dart';
import '../../controllers/SeekerViewInterviewAllController/SeekerViewInterviewAllController.dart';
import '../../controllers/ViewLanguageController/ViewLanguageController.dart';
import '../../controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import '../../controllers/ViewSeekerProfileController/ViewSeekerProfileControllerr.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../widgets/app_colors.dart';
import '../SeekerForum/FriendsFamily/ContactsController.dart';
import '../SeekerHome/find_job_home_page.dart';


class TabScreen extends StatefulWidget {
  final int index;
  final bool? filtered ;
  final bool? loadData ;
  const TabScreen({super.key, required this.index, this.filtered, this.loadData});

  @override
  TabScreenState createState() => TabScreenState();
}

class TabScreenState extends State<TabScreen> {
 static int? bottomSelectedIndex;
  PageController? pageController;
  DateTime currentBackPressTime = DateTime.now();
  bool loading = false;
  TabBarController tabBarController = Get.put(TabBarController());
  SeekerChoosePositionGetController seekerChoosePositionGetControllerInstanse = Get.put(SeekerChoosePositionGetController());
  ViewSeekerProfileController seekerProfileController = Get.put( ViewSeekerProfileController());
  ViewLanguageController viewLanguageController = Get.put(ViewLanguageController()) ;
  SeekerGetAllSkillsController skillsController = Get.put(SeekerGetAllSkillsController()) ;
  GetJobsListingController getJobsListingController = Get.put(GetJobsListingController()) ;
  SeekerForumDataController forumDataController = Get.put(SeekerForumDataController()) ;
  SeekerForumIndustryController industryController = Get.put(SeekerForumIndustryController()) ;
  CompaniesListController companiesListController = Get.put(CompaniesListController()) ;
  SeekerMapJobsController jobsController = Get.put(SeekerMapJobsController());
  ViewSeekerProfileControllerr seekerProfileControllerr = Get.put( ViewSeekerProfileControllerr());
  AvtarImageListController avtarController = Get.put(AvtarImageListController()) ;
  ContactController contactController = Get.put(ContactController()) ;
  SeekerViewNotificationController SeekerViewNotificationControllerInstanse = Get.put(SeekerViewNotificationController()) ;
  SeekerEarningController seekerEarningController = Get.put(SeekerEarningController());
  SeekerViewInterviewAllController interviewListController = Get.put(SeekerViewInterviewAllController()) ;
 SeekerJobAlertListController seekerJobAlertListControllerInstanse = Get.put(SeekerJobAlertListController()) ;
  var data;
  final drawerKey = GlobalKey<ScaffoldState>();
  @override

  void initState() {
    if(widget.loadData == true) {
      getJobsListingController.seekerGetAllJobsApi();
      seekerProfileController.viewSeekerProfileApi();
      seekerProfileControllerr.viewSeekerProfileApi();
      viewLanguageController.viewLanguageApi();
      skillsController.seekerGetAllSkillsApi();
      forumDataController.seekerForumListApi(page: "1");
      industryController.industryApi();
      companiesListController.getCompaniesApi();
      jobsController.mapJobsApi();
      seekerChoosePositionGetControllerInstanse.seekerGetPositionApi(false);
      avtarController.getAvtarListApi();
      bottomSelectedIndex = widget.index;
      contactController.loadContacts();
      SeekerViewNotificationControllerInstanse.viewSeekerNotificationApi();
      seekerEarningController.seekerEarningApi();
      interviewListController.seekerInterViewListApi();
      seekerJobAlertListControllerInstanse.viewSeekerJobAlertListApi() ;
     tabBarController.pageController?.value = PageController(initialPage: widget.index , keepPage: true);
    }
    super.initState();
    // studentType = MySharedPreferences.localStorage?.getString(MySharedPreferences.studentType) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Obx(() {
        switch (getJobsListingController.rxRequestStatus.value) {
          case Status.LOADING:
            return  const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()
          //     Container(
          // height: Get.height,
          //   width: Get.height,
          //   child: Image.asset("assets/images/icon_splash_logo.jpg",fit: BoxFit.cover)),
              ),
            );
          case Status.ERROR:
            if (getJobsListingController.error.value == 'No internet') {
              return Scaffold(
                body: InterNetExceptionWidget(
                  onPress: () {
                    getJobsListingController.seekerGetAllJobsApi();
                    seekerProfileController.viewSeekerProfileApi();
                    seekerProfileControllerr.viewSeekerProfileApi();
                    viewLanguageController.viewLanguageApi();
                    skillsController.seekerGetAllSkillsApi();
                    forumDataController.seekerForumListApi(page: "1");
                    industryController.industryApi();
                    companiesListController.getCompaniesApi();
                    jobsController.mapJobsApi();
                    seekerChoosePositionGetControllerInstanse.seekerGetPositionApi(false);
                    avtarController.getAvtarListApi();
                    bottomSelectedIndex = widget.index;
                    contactController.loadContacts();
                    SeekerViewNotificationControllerInstanse.viewSeekerNotificationApi();
                    seekerEarningController.seekerEarningApi();
                    interviewListController.seekerInterViewListApi();
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
            return SafeArea(
              bottom: false,
              top: false,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Obx( () => PageView(
                    controller: tabBarController.pageController?.value,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      tabBarController.pageChanged(index);
                      } ,
                    children: [
                      // HelpSection(),
                       FindJobHomeScreen(),
                      GoogleMapIntegration(filtered: widget.filtered,),
                       CompanySeekerPage(),
                       ForumFirstPage(),
                       UserProfile(),
                    ],
                  ),
                ),
              ),
            );
        }
      }
      ),
      bottomNavigationBar: Obx( () => AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        opacity: tabBarController.showBottomBar.value ? 1 : 0,
        child: tabBarController.showBottomBar.value ? Container(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25) ,
                topRight: Radius.circular(25)
            ),
            child: Obx( () => BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: buildBottomNavBarItems,
                selectedItemColor: const Color(0xff56B8F6),
                unselectedItemColor: const Color(0xffC4C4C4),
                selectedIconTheme: const IconThemeData(
                  color: Color(0xff56B8F6),),
                unselectedIconTheme: const IconThemeData(
                  color: Color(0xffC4C4C4),),
                elevation: 0,
                backgroundColor: AppColors.homeGrey ,
                currentIndex: tabBarController.bottomSelectedIndex.value ,
                onTap: (index) {
                  tabBarController.bottomTapped(index) ;
                  },
                selectedFontSize: 1,
                unselectedFontSize: 1,
              ),
            ),
          ),
        ) : null,
      ),
      ),
    );
  }

  void bottomTapped(int index) {
    if(index == 0) {
      tabBarController.showListView(true) ;
    }
    setState(() {
        bottomSelectedIndex = index;
        pageController!.animateToPage(index,
            duration: const Duration(microseconds: 1), curve: Curves.ease);
      },
    );
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  // Future<bool> _onWillPop() {
  //   if (bottomSelectedIndex != 1) {
  //     setState(
  //           () {
  //         pageController!.jumpTo(0);
  //       },
  //     );
  //     return Future.value(false);
  //   } else if (bottomSelectedIndex == 1) {
  //     setState(
  //           () {
  //         pageController!.jumpTo(1);
  //       },
  //     );
  //     return Future.value(false);
  //   }
  //   DateTime now = DateTime.now();
  //   if (now.difference(currentBackPressTime) > Duration(milliseconds: 500)) {
  //     currentBackPressTime = now;
  //     SystemNavigator.pop();
  //     return Future.value(false);
  //   } else {
  //     SystemNavigator.pop();
  //   }
  //   return Future.value(true);
  // }

  goAtLikeTab() {
    pageController!.animateToPage(1,
        duration: const Duration(microseconds: 1), curve: Curves.ease);
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems = [
    BottomNavigationBarItem(
        label: "",
        icon: Image.asset("assets/images/icon_unselect_home.png",height: Get.height*.035,),
        activeIcon: Image.asset("assets/images/icon_select_home.png",height: Get.height*.035)),

    BottomNavigationBarItem(
      label: "",
      icon: Image.asset("assets/images/icon_unselect_location.png",height: Get.height*.035,color: AppColors.black,) ,
      activeIcon: Image.asset("assets/images/icon_Select_location.png",height: Get.height*.035,) ,
    ),

    BottomNavigationBarItem(
      label: "",
      icon: Image.asset("assets/images/icon_search.png",height: Get.height*.045),
    ),

    BottomNavigationBarItem(
        label: "",
        icon: Image.asset("assets/images/icon_forum_unselect.png",height: Get.height*.035),
        activeIcon: Image.asset("assets/images/icon_forum_select.png",height: Get.height*.035,)
    ),

    BottomNavigationBarItem(
      label: "",
      icon: Image.asset("assets/images/icon_unselect_person.png",height: Get.height*.035),
      activeIcon: Image.asset("assets/images/icon_select_person.png",height: Get.height*.035),
    ),
  ];
}
