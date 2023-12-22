
import 'package:flikka/Job%20Recruiter/RecruiterTraking/applicant_traking.dart';
import 'package:flikka/Job%20Recruiter/AddJobPage/create_job_post.dart';
import 'package:flikka/Job%20Recruiter/RecruiterHome/find_candidate_home_page.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/recruiter_profile_tabbar.dart';
import 'package:flikka/Job%20Seeker/SeekerChatMessage/message_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../message/message_page.dart';
import 'bottom_navigation_bar_.dart';

class TabScreenEmployer extends StatefulWidget {
  int ?profileTabIndex;
  final int index;

   TabScreenEmployer({Key? key, required this.index , this.profileTabIndex}) : super(key: key);

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

  @override
  void initState() {
    // fetchApi();

    // TODO: implement initState
    bottomSelectedIndex = widget.index;
    pageController = PageController(initialPage: widget.index, keepPage: true);

    super.initState();
    // studentType = MySharedPreferences.localStorage?.getString(MySharedPreferences.studentType) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      body: SafeArea(
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
      bottomNavigationBar: BottomEmployer(
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
