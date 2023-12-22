import 'package:flikka/Job%20Recruiter/RecruiterTraking/inbox.dart';
import 'package:flikka/Job%20Recruiter/RecruiterTraking/talent_pool.dart';
import 'package:flikka/controllers/ApplicantTrackingController/ApplicantTrackingController.dart';
import 'package:flikka/controllers/RecruiterJobTitleController/RecruiterJobTitleController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../bottom_bar/tab_bar.dart';
import 'all_candidate.dart';
import 'upcoming_interviews.dart';

class ApplicantTracking extends StatefulWidget {
  const ApplicantTracking({super.key});

  @override
  State<ApplicantTracking> createState() => _ApplicantTrackingState();
}

class _ApplicantTrackingState extends State<ApplicantTracking> {

  // //////refresh//////
  // RefreshController _refreshController = RefreshController(initialRefresh: false);
  //
  // void _onRefresh() async{
  //   await trackingDataController.applicantTrackingApi("jobTitle" ,"status");
  //   _refreshController.refreshCompleted();
  // }
  //
  // void _onLoading() async{
  //   await trackingDataController.applicantTrackingApi("jobTitle", "status");
  //   if(mounted)
  //     setState(() {
  //
  //     });
  //   _refreshController.loadComplete();
  // }
  // /////refresh/////

  RecruiterJobTitleController jobTitleController = Get.put(RecruiterJobTitleController());
  ApplicantTrackingDataController trackingDataController = Get.put(ApplicantTrackingDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: AppColors.black,
          appBar: AppBar(
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xff000),
            title: Text(
              'Applicant Tracking',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: GestureDetector(
                  onTap: () {
                    Get.offAll(() => TabScreenEmployer(index: 0,)) ;
                  },
                  child: Image.asset(
                    "assets/images/icon_back_blue.png",
                    height: Get.height * .02,
                  )),
            ),
            bottom: TabBar(
              indicatorPadding:
                  EdgeInsets.symmetric(horizontal: Get.width * .04),
              isScrollable: true,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: AppColors.blueThemeColor),
              ),
              physics: const AlwaysScrollableScrollPhysics(),
              unselectedLabelColor: AppColors.graySilverColor,
              labelColor: AppColors.blueThemeColor,
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              tabs: const [
                Tab(text: "APPLICANT DATA"),
                Tab(text: "INTERVIEWS"),
                Tab(text: "INBOX",),
                Tab(text: "TALENT POOL",),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              AllCandidate(),
              UpcomingInterviews(),
              Inbox(),
              TalentPool(),
            ],
          ),
        ),
      ),
    );
  }
}
