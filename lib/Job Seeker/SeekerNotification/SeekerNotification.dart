import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Seeker/SeekerJobs/AppliedJobs.dart';
import 'package:flikka/Job%20Seeker/SeekerNotification/viewJobFromNotification.dart';
import 'package:flikka/controllers/NotificationSeenController/NotificationSeenController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controllers/SeekerNotificationDataViewController/SeekerNotificationViewDataController.dart';
import '../../controllers/ViewSeekerProfileController/ViewSeekerProfileControllerr.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../SeekerBottomNavigationBar/tab_bar.dart';
import '../SeekerJobs/progress_tracker.dart';
import 'notification_progress_tracker.dart';

class SeekerNotification extends StatefulWidget {
  const SeekerNotification({super.key});

  @override
  State<SeekerNotification> createState() => _Notification1PageState();
}

class _Notification1PageState extends State<SeekerNotification> {

  //////refresh//////
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await SeekerViewNotificationControllerInstanse.viewSeekerNotificationApi() ;
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await SeekerViewNotificationControllerInstanse.viewSeekerNotificationApi() ;
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  /////refresh/////

  ViewSeekerProfileControllerr seekerProfileControllerr = Get.put( ViewSeekerProfileControllerr());
  SeekerViewNotificationController SeekerViewNotificationControllerInstanse = Get.put(SeekerViewNotificationController()) ;
  SeekerNotificationSeenController seenController = Get.put(SeekerNotificationSeenController()) ;

  @override
  void initState() {
    // seenController.notificationSeen(context, seekerProfileControllerr.viewSeekerData.value.seekerInfo?.email) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime createdAt = DateTime.now();
    return Obx(() {
      switch (SeekerViewNotificationControllerInstanse.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (SeekerViewNotificationControllerInstanse.error.value == 'No internet') {
            return Scaffold(
              body: InterNetExceptionWidget(
                onPress: () {
                  SeekerViewNotificationControllerInstanse.viewSeekerNotificationApi() ;
                },
              ),
            );
          } else {
            return Scaffold(
              body: GeneralExceptionWidget(onPress: () {
                SeekerViewNotificationControllerInstanse.viewSeekerNotificationApi() ;
              }),
            );
          }
        case Status.COMPLETED:
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 75,
              leading: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: GestureDetector(
                    onTap: () {
                      seenController.notificationSeen(context, seekerProfileControllerr.viewSeekerData.value.seekerInfo?.email) ;
                      // Get.to(() => const TabScreen(index: 0)) ;
                      Get.back() ;
                      Get.back() ;
                    },
                    child: Image.asset('assets/images/icon_back_blue.png')),
              ),
              elevation: 0,
              title: Text("Notification", style: Get.theme.textTheme.displayLarge),
            ),
            body: PopScope(
              canPop: true,
             onPopInvoked: (didPop) {
                if(didPop) {
                  seenController.notificationSeen(context, seekerProfileControllerr.viewSeekerData.value.seekerInfo?.email) ;
                }
             },
              child: SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: SeekerViewNotificationControllerInstanse
                    .viewSeekerNotificationData.value.seekerNotification?.length == null ||
                    SeekerViewNotificationControllerInstanse
                        .viewSeekerNotificationData.value.seekerNotification?.length == 0
                    ? Center(
                  child: Text(
                    "No Notifications",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                )
                    : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.03,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height * 0.01,),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?.length,
                        itemBuilder: (BuildContext context, int index) {
                          createdAt = DateTime.parse(SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?[index].createdAt ?? "") ;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: ListTile(
                              onTap: () {
                                stepCount=SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?[index].progressStep;
                                setState(() {
                                  stepCount;
                                  print("This is stepCount ${stepCount}") ;
                                  print("This is ID ${SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?[index].id}");
                                  print("This is seeker ID ${SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?[index].seekerId}");
                                  print("This is recruiter ID ${SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?[index].recruiterId}");
                                  print("This is job ID ${SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?[index].jobId}");
                                  print("This is company Name ${SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?[index].companyName}");
                                });
                              Get.to(() => NotificationProgressTracker(companyName: "${SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?[index].companyName}",
                              jobId: "${SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?[index].jobId}",
                                seekerId: "${SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?[index].seekerId}",
                                index: index,
                              )) ;

                                // Get.to(() => ViewNotificationJob(
                                //   companyName: "${SeekerViewNotificationControllerInstanse
                                //       .viewSeekerNotificationData.value.seekerNotification?[index].companyName}",
                                //   jobId: "${SeekerViewNotificationControllerInstanse
                                //       .viewSeekerNotificationData.value.seekerNotification?[index].jobId}",
                                //   seekerId: "${SeekerViewNotificationControllerInstanse
                                //       .viewSeekerNotificationData.value.seekerNotification?[index].seekerId}",
                                // ));
                              },
                              tileColor: SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.
                              seekerNotification?[index].seen == 1 ? AppColors.textFieldFilledColor : AppColors.homeGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                              leading: SizedBox(
                                width: Get.width * .2,
                                child: CachedNetworkImage(
                                  imageUrl: SeekerViewNotificationControllerInstanse
                                      .viewSeekerNotificationData.value.seekerNotification?[index].jobFeatureImg ?? "",
                                  imageBuilder: (context, imageProvider) => Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?[index].companyName ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: SeekerViewNotificationControllerInstanse
                                    .viewSeekerNotificationData.value.seekerNotification?[index].seen == 1 ? AppColors.white : AppColors.black ,
                                  fontSize: SeekerViewNotificationControllerInstanse
                                      .viewSeekerNotificationData.value.seekerNotification?[index].seen == 1 ? 15 : 18,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    SeekerViewNotificationControllerInstanse
                                        .viewSeekerNotificationData.value.seekerNotification?[index].description ?? "",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?[index].seen == 1 ? AppColors.white : AppColors.black ,),
                                  ),
                                  Text(DateFormat('MMMM dd yyyy, hh:mm a').format(createdAt),style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?[index].seen ==1 ? AppColors.white : AppColors.black),)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: Get.height * 0.01,),
                    ],
                  ),
                ),
              ),
            )

          );
      }
    }
    );
  }
}
