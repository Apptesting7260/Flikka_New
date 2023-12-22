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

class SeekerRequestedJobs extends StatefulWidget {
  const SeekerRequestedJobs({super.key});

  @override
  State<SeekerRequestedJobs> createState() => _SeekerRequestedJobsState();
}

class _SeekerRequestedJobsState extends State<SeekerRequestedJobs> {

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
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: Get.width * .04, vertical: Get.height * .02),
                child: jobsController.jobsList.value.job?.length == 0 || jobsController.jobsList.value.job == null ?
                Center(child: Text("You have not Applied to any jobs", style: Get.theme.textTheme.labelMedium!
                    .copyWith(color: AppColors.white))) :
                Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: jobsController.jobsList.value.job?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = jobsController.jobsList.value.job?[index] ;
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
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
                                // leading:  CircleAvatar(
                                //     radius: 26,
                                //     backgroundImage: NetworkImage("${data?.featureImg}")
                                // ),
                                title: Text(data?.jobPositions ?? '',
                                    style: Get.theme.textTheme.labelMedium!
                                        .copyWith(color: AppColors.white)),
                                subtitle: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${data?.recruiterDetails?.companyName}",
                                        style: Get.theme.textTheme.bodySmall!
                                            .copyWith(color: Color(0xffCFCFCF))),
                                    Text("${data?.recruiterDetails?.companyLocation}",
                                        style: Get.theme.textTheme.bodySmall!
                                            .copyWith(color: Color(0xffCFCFCF))),
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
                      },)
                  ],
                ),
              ),
            ),
          );
      }
    }
    );
  }

}
