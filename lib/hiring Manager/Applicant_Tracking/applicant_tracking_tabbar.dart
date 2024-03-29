
import 'package:flikka/hiring%20Manager/Applicant_Tracking/OnboardingHiring.dart';
import 'package:flikka/hiring%20Manager/Applicant_Tracking/inbox_hiring.dart';
import 'package:flikka/hiring%20Manager/Applicant_Tracking/past_interviews.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/view_profile.dart';
import 'rejected_candidate_hiring.dart';
import 'talent_pool_hiring.dart';

class ApplicantTrackingHiringManager extends StatefulWidget {
  const ApplicantTrackingHiringManager({super.key});

  @override
  State<ApplicantTrackingHiringManager> createState() => _ApplicantTrackingHiringManagerState();
}

class _ApplicantTrackingHiringManagerState extends State<ApplicantTrackingHiringManager> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.black,
      body: DefaultTabController(
        length: 5,
        child: Scaffold(backgroundColor: AppColors.black,
          appBar: AppBar(
            toolbarHeight: 40,
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: Text(
              'Applicant Tracking',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                   Get.to(() => const ViewProfile()) ;
                  },
                  child: const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("assets/images/icon_about_ue_user.png"),
                  ),
                ),
              )
            ],
            bottom: TabBar(
              dividerColor: Colors.transparent,
              indicatorPadding: EdgeInsets.symmetric(horizontal: Get.width*.01),
              isScrollable: true,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0,color: AppColors.blueThemeColor),
              ),
              physics: const AlwaysScrollableScrollPhysics(),
              unselectedLabelColor: const Color(0xffCFCFCF),
              labelColor: AppColors.blueThemeColor,
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              tabs: const [
                Tab(text: "APPLICANT DATA"),
                Tab(text: "INTERVIEWS",),
                Tab(text: "INBOX",),
                Tab(text: "TALENT POOL",),
                Tab(text: "ONBOARDING",),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              RejectedCandidateHiring(),
              PastInterviews(),
              InboxHiring(),
              TalentPoolHiring(),
              OnboardingHiring()
            ],
          ),
        ),
      ),
    );
  }
}
