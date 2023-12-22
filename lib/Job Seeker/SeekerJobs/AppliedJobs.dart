import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/controllers/SeekerAppliedJobsController/SeekerAppliedJobsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';
import '../../widgets/app_colors.dart';
import '../marketing_page.dart';

class SeekerAppliedJobs extends StatefulWidget {

  const SeekerAppliedJobs({super.key});

  @override
  State<SeekerAppliedJobs> createState() => _SeekerAppliedJobsState();
}

class _SeekerAppliedJobsState extends State<SeekerAppliedJobs> {

  SeekerAppliedJobsController jobsController = Get.put(SeekerAppliedJobsController()) ;

  //////refresh//////
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await jobsController.getJobsApi();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await jobsController.getJobsApi();
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  /////refresh/////

  @override
  void initState() {
    jobsController.getJobsApi() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (jobsController
          .rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()),
          );
        case Status.ERROR:
          if (jobsController.error.value == 'No internet') {
            return Scaffold(body: InterNetExceptionWidget(
              onPress: () {
                jobsController.getJobsApi() ;
              },
            ),);
          } else if (jobsController.error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {
              jobsController.getJobsApi() ;
            }),);
          }  else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              jobsController.getJobsApi() ;
            }),);
          }
        case Status.COMPLETED:
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 75,
              leading: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset('assets/images/icon_back_blue.png')),
              ),
              elevation: 0,
              title: Text("My Jobs", style: Get.theme.textTheme.displayLarge),
            ),
            body: SmartRefresher(
              controller: _refreshController,
              onLoading: _onLoading,
              onRefresh: _onRefresh,
              child:   DefaultTabController(
                  length: 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   const TabBar(
                     isScrollable: true,
                     labelColor: AppColors.blueThemeColor,
                     unselectedLabelColor: Color(0xffCFCFCF),
                     indicatorColor: AppColors.blueThemeColor,
                     indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                       tabs: [
                         Tab(child: Text("APPLIED JOBS"),),
                         Tab(child: Text("REQUEST RECEIVED"),),
                       ],
                   ),
                    SizedBox(
                      height: Get.height *.8 ,
                      child: TabBarView(children: [
                        jobsController.appliedJobs.isEmpty ?
                            const Center(child: Text("No Applied Jobs"),) :
                            ListView.builder(
                              itemCount: jobsController.appliedJobs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var data = jobsController.appliedJobs?[index] ;
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => MarketingIntern(jobData: jobsController.appliedJobs?[index], appliedJobScreen: true,)) ;
                                      },
                                      child: ListTile(
                                        leading: CachedNetworkImage(
                                          imageUrl: "${data?.featureImg}",
                                          imageBuilder: (context, imageProvider) => Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover
                                              )
                                            ),
                                          ),
                                          placeholder: (context, url) => const CircularProgressIndicator(),
                                        ),
                                        title:   Text(data?.jobTitle ?? '',
                                            style: Get.theme.textTheme.labelMedium!
                                                .copyWith(color: AppColors.white)),

                                        subtitle: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(data?.jobPositions ?? '',
                                                style: Get.theme.textTheme.bodySmall!
                                                    .copyWith(color: Color(0xffCFCFCF))),
                                            Text("${data?.recruiterDetails?.companyName}",
                                                style: Get.theme.textTheme.bodySmall!
                                                    .copyWith(color: Color(0xffCFCFCF))),
                                            Text("${data?.recruiterDetails?.companyLocation}",overflow: TextOverflow.ellipsis,
                                                style: Get.theme.textTheme.bodySmall!
                                                    .copyWith(color: Color(0xffCFCFCF))),
                                            Text("${data?.applicantStatus.toString().toUpperCase()}",overflow: TextOverflow.ellipsis,
                                                style: Get.theme.textTheme.bodySmall!
                                                    .copyWith(color: data?.applicantStatus.toString().toUpperCase() == "ACCEPTED" ?
                                                    Colors.green : data?.applicantStatus.toString().toUpperCase() == "REJECTED" ?
                                                    Colors.red : Colors.yellowAccent)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      height: 40,
                                      color: Color(0xff414141),
                                      thickness: 1,
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                  ],
                                );
                              },) ,
                        jobsController.requestedJobs.isEmpty ?
                        const Center(child: Text("No Requested Jobs"),) :
                            ListView.builder(
                              itemCount: jobsController.requestedJobs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                debugPrint("this is the length ========= ${jobsController.requestedJobs.length}") ;
                                var data = jobsController.requestedJobs[index] ;
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => MarketingIntern(jobData: jobsController.requestedJobs[index], appliedJobScreen: false,requestedJob: true,)) ;
                                      },
                                      child: ListTile(
                                        leading: CachedNetworkImage(
                                          imageUrl: "${data?.featureImg}",
                                          imageBuilder: (context, imageProvider) => Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover
                                              )
                                            ),
                                          ),
                                          placeholder: (context, url) => const CircularProgressIndicator(),
                                        ),
                                        title:   Text(data?.jobTitle ?? '',
                                            style: Get.theme.textTheme.labelMedium!
                                                .copyWith(color: AppColors.white)),

                                        subtitle: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(data?.jobPositions ?? '',
                                                style: Get.theme.textTheme.bodySmall!
                                                    .copyWith(color: Color(0xffCFCFCF))),
                                            Text("${data?.recruiterDetails?.companyName}",
                                                style: Get.theme.textTheme.bodySmall!
                                                    .copyWith(color: Color(0xffCFCFCF))),
                                            Text("${data?.recruiterDetails?.companyLocation}",overflow: TextOverflow.ellipsis,
                                                style: Get.theme.textTheme.bodySmall!
                                                    .copyWith(color: Color(0xffCFCFCF))),
                                            Text("${data?.applicantStatus.toString().toUpperCase()}",overflow: TextOverflow.ellipsis,
                                                style: Get.theme.textTheme.bodySmall!
                                                    .copyWith(color: data?.applicantStatus.toString().toUpperCase() == "ACCEPTED" ?
                                Colors.green : data?.applicantStatus.toString().toUpperCase() == "REJECTED" ?
                                Colors.red : Colors.yellowAccent)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      height: 40,
                                      color: Color(0xff414141),
                                      thickness: 1,
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                  ],
                                );
                              },) ,
                      ]),
                    )
                  ],
                ),
              ),
              ),
            ),
          );
      }
    }
    );
  }

}
