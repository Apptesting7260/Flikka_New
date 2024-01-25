import 'package:flikka/Job%20Recruiter/RecruiterTraking/applicant_traking.dart';
import 'package:flikka/Job%20Recruiter/AddJobPage/create_job_post.dart';
import 'package:flikka/Job%20Recruiter/RecruiterHome/find_candidate_home_page.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/recruiter_profile_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' ;
import '../../Job Seeker/SeekerBottomNavigationBar/TabBarController.dart';
import '../../controllers/RecruiterHomeController/RecruiterHomeController.dart';
import '../../controllers/RecruiterHomePageJobsController/RecruiterHomePageJobsController.dart';
import '../../controllers/RecruiterJobTitleController/RecruiterJobTitleController.dart';
import '../../controllers/RecruiterReportController/RecruiterReportController.dart';
import '../../controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import '../../widgets/app_colors.dart';
import '../message/message_page.dart';

class TabScreenEmployer extends StatefulWidget {
  int? profileTabIndex;
  final int index;

  TabScreenEmployer({Key? key, required this.index, this.profileTabIndex})
      : super(key: key);

  @override
  _TabScreenEmployerState createState() => _TabScreenEmployerState();
}

class _TabScreenEmployerState extends State<TabScreenEmployer> {

  int? bottomSelectedIndex;
  PageController? pageController;
  DateTime currentBackPressTime = DateTime.now();
  bool loading = false;
  var data;
  final drawerKey = GlobalKey<ScaffoldState>();
  TabBarController tabBarController = Get.put(TabBarController());
  RecruiterReportController reportController = Get.put(RecruiterReportController());
  ViewRecruiterProfileGetController viewRecruiterProfileController = Get.put(ViewRecruiterProfileGetController());
  RecruiterJobTitleController jobTitleController = Get.put(RecruiterJobTitleController());
  RecruiterHomePageJobsController jobsController = Get.put(RecruiterHomePageJobsController()) ;
  RecruiterHomeController homeController = Get.put(RecruiterHomeController()) ;


  @override
  void initState() {
    homeController.recruiterHomeApi() ;
    jobsController.recruiterJobsApi() ;
    jobTitleController.recruiterJobTitleApi() ;
    viewRecruiterProfileController.viewRecruiterProfileApi() ;
    reportController.reportApi() ;
    bottomSelectedIndex = widget.index ;
    pageController = PageController(initialPage: widget.index, keepPage: false);

    super.initState();
  }


  List<BottomNavigationBarItem> buildBottomNavBarItems = [
    BottomNavigationBarItem(
        label: "",
        icon: Image.asset("assets/images/icon_unselect_home.png",height: Get.height*.035,),
        activeIcon: Image.asset("assets/images/icon_select_home.png",height: Get.height*.035)),

    BottomNavigationBarItem(
        label: "",
        icon: Image.asset("assets/images/icon_unselect_applicant.png", height: Get.height*.035),
        activeIcon: Image.asset("assets/images/icon_select_applicant.png", height: Get.height*.035)),

    BottomNavigationBarItem(
      label: "",
      icon: Image.asset("assets/images/icon_Add_job.png", height: Get.height*.035),
      activeIcon: Image.asset("assets/images/icon_Add_job.png", height: Get.height*.035),),
    BottomNavigationBarItem(
        label: "",
        icon: Image.asset("assets/images/icon_unselect_msg.png", height: Get.height*.035),
        activeIcon: Image.asset("assets/images/icon_select_msg.png", height: Get.height*.035)),

    BottomNavigationBarItem(
      label: "",
      icon: Image.asset("assets/images/icon_unselect_person.png",height: Get.height*.035),
      activeIcon: Image.asset("assets/images/icon_select_person.png",height: Get.height*.035),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      extendBody: true,
      body: SafeArea(
        top: false,
        bottom: false,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) => pageChanged(index),
            children: [
              const FindCandidateHomePage(),
              const ApplicantTracking(),
              const CreateJobPost(),
              const RecruiterMessagePage(),
              RecruiterProfileTabBar(index: widget.profileTabIndex ?? 0,)
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: tabBarController.showBottomBarRecruiter.value ? 1 : 0,
            child: tabBarController.showBottomBarRecruiter.value
                ? Container(
                    color: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25) ,
                        topRight: Radius.circular(25)
                      ),
                      child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        items: buildBottomNavBarItems,
                        selectedItemColor: Color(0xff56B8F6),
                        unselectedItemColor: Color(0xffC4C4C4),
                        selectedIconTheme: IconThemeData(color: Color(0xff56B8F6),),
                        unselectedIconTheme: IconThemeData(color: Color(0xffC4C4C4),),
                        elevation: 0,
                        backgroundColor: AppColors.homeGrey,
                        currentIndex: bottomSelectedIndex ?? 0,
                        onTap: (index) => bottomTapped(index),
                        selectedFontSize: 1,
                        unselectedFontSize: 1,
                      ),),) : null,
          )),
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

  Future<bool> _onWillPop() {
    if (bottomSelectedIndex != 1) {
      setState(
        () {
          pageController!.jumpTo(0);
        },
      );
      return Future.value(false);
    } else if (bottomSelectedIndex == 1) {
      setState(
        () {
          pageController!.jumpTo(1);
        },
      );
      return Future.value(false);
    }
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(milliseconds: 500)) {
      currentBackPressTime = now;
      SystemNavigator.pop();
      return Future.value(false);
    } else {
      SystemNavigator.pop();
    }
    return Future.value(true);
  }

  goAtLikeTab() {
    pageController!.animateToPage(1,
        duration: const Duration(microseconds: 1), curve: Curves.ease);
  }
}
