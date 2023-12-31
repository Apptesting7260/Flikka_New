import 'package:flikka/Job%20Seeker/Authentication/user/user_profile.dart';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/bottom_navigation_bar.dart';
import 'package:flikka/Job%20Seeker/SeekerChatMessage/message_page.dart';
import 'package:flikka/Job%20Seeker/SeekerCompanies/companies_seeker_page.dart';
import 'package:flikka/Job%20Seeker/SeekerForum/forum_first_page.dart';
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
import '../../controllers/SeekerMapJobsController/SeekerMapJobsController.dart';
import '../../controllers/SeekerNotificationDataViewController/SeekerNotificationViewDataController.dart';
import '../../controllers/ViewLanguageController/ViewLanguageController.dart';
import '../../controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import '../../controllers/ViewSeekerProfileController/ViewSeekerProfileControllerr.dart';
import '../../main.dart';
import '../SeekerFilter/filter_page.dart';
import '../SeekerForum/FriendsFamily/ContactsController.dart';
import '../SeekerHome/find_job_home_page.dart';
import '../location.dart';
import '../saved_post_widget.dart';
import '../search_job.dart';


class TabScreen extends StatefulWidget {
  final int index;
  final bool? filtered ;
  const TabScreen({Key? key, required this.index, this.filtered}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int? bottomSelectedIndex;
  PageController? pageController;
  DateTime currentBackPressTime = DateTime.now();
  bool loading = false;
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
  var data;
  final drawerKey = GlobalKey<ScaffoldState>();

  @override

  void initState() {
    getJobsListingController.seekerGetAllJobsApi() ;
    seekerProfileController.viewSeekerProfileApi() ;
    seekerProfileControllerr.viewSeekerProfileApi();
    viewLanguageController.viewLanguageApi() ;
    skillsController.seekerGetAllSkillsApi() ;
    forumDataController.seekerForumListApi(page: "1") ;
    industryController.industryApi() ;
    companiesListController.getCompaniesApi() ;
    jobsController.mapJobsApi();
    seekerChoosePositionGetControllerInstanse.seekerGetPositionApi(false);
    avtarController.getAvtarListApi() ;
    bottomSelectedIndex = widget.index;
    pageController = PageController(initialPage: widget.index, keepPage: true);
    contactController.loadContacts() ;
    SeekerViewNotificationControllerInstanse.viewSeekerNotificationApi() ;
    seekerEarningController.seekerEarningApi();

    super.initState();
    // studentType = MySharedPreferences.localStorage?.getString(MySharedPreferences.studentType) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    print("this is filtered ${widget.filtered}") ;
    return Scaffold(
      key: drawerKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) => pageChanged(index),
            children:  [
              const FindJobHomeScreen(),
              GoogleMapIntegration(filtered: widget.filtered,),
              const  CompanySeekerPage(),
              const  ForumFirstPage(),
              const UserProfile(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottom(
        bottomSelectedIndex: bottomSelectedIndex!,
        bottomTapped: bottomTapped,
      ),
    );
  }

  void bottomTapped(int index) {
    setState(
          () {
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
}
