
import 'package:flikka/hiring%20Manager/Applicant_Tracking/inbox_hiring.dart';
import 'package:flikka/hiring%20Manager/Applicant_Tracking/past_interviews.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(backgroundColor: Colors.black,
          appBar: AppBar(
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff000),
            title: Text(
              'Applicant Tracking',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            leading: Padding(
              padding:  EdgeInsets.only(left: 15.0),
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.02,)),
            ),
            bottom: TabBar(
              indicatorPadding: EdgeInsets.symmetric(horizontal: Get.width*.04),
              //labelPadding: EdgeInsets.only(right: 50),
              isScrollable: true,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0,color: Color(0xff56B8F6)),
                //insets: EdgeInsets.symmetric(horizontal: width*.14),
              ),
              physics: AlwaysScrollableScrollPhysics(),
              unselectedLabelColor: Color(0xffCFCFCF),
              labelColor: Color(0xff56B8F6),
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              tabs: const [
                Tab(text: "APPLICANT DATA"),
                Tab(text: "INTERVIEWS",),
                Tab(text: "INBOX",),
                Tab(text: "TALENT POOL",),
              ],
            ),
          ),

          body: TabBarView(
            children: [
              RejectedCandidateHiring(),
              PastInterviews(),
              InboxHiring(),
              TalentPoolHiring(),
            ],
          ),
        ),
      ),
    );
  }
}
