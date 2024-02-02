import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controllers/ApplicantTrackingController/ApplicantTrackingController.dart';
import '../../controllers/CreateUpdateRecruiterProfileController/CreateUpdateRecruiterProfileController.dart';
import '../../controllers/NotificationSeenController/NotificationSeenController.dart';
import '../../controllers/RecruiterInboxDataController/RecruiterInboxDataController.dart';
import '../../controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import '../../controllers/ViewSeekerProfileController/ViewSeekerProfileControllerr.dart';
import '../../data/response/status.dart';
import '../../hiring Manager/schedule_interview.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {

  ApplicantTrackingDataController trackingDataController = Get.put(ApplicantTrackingDataController());
  SeekerNotificationSeenController seenController = Get.put(SeekerNotificationSeenController()) ;
  CreateUpdateRecruiterProfileController CreateUpdateRecruiterProfileControllerInstanse = Get.put(CreateUpdateRecruiterProfileController());
  ViewRecruiterProfileGetController viewRecruiterProfileController = Get.put(ViewRecruiterProfileGetController());

  @override
  void initState() {
    super.initState();
    if(ShowInboxDataControllerInstanse.viewInboxData.value.recruiterInboxData == null ||
        ShowInboxDataControllerInstanse.viewInboxData.value.recruiterInboxData?.length == 0
    ){
      ShowInboxDataControllerInstanse.showInboxDataApi() ;
    }
    seenController.notificationSeenRecruiter(context, viewRecruiterProfileController.viewRecruiterProfile.value.email) ;
  }

  ShowInboxDataController ShowInboxDataControllerInstanse = Get.put(ShowInboxDataController());

  //////refresh//////
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await ShowInboxDataControllerInstanse.showInboxDataApi() ;
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await ShowInboxDataControllerInstanse.showInboxDataApi() ;
    if(mounted)
      // setState(() {
      //
      // });
    _refreshController.loadComplete();
  }
  /////refresh/////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Obx(() {
          switch (ShowInboxDataControllerInstanse.rxRequestStatus.value) {
            case Status.LOADING:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );

            case Status.ERROR:
              if (ShowInboxDataControllerInstanse.error.value ==
                  'No internet') {
                return InterNetExceptionWidget(
                  onPress: () {
                    ShowInboxDataControllerInstanse.showInboxDataApi() ;
                  },
                );
              } else {
                return GeneralExceptionWidget(onPress: () {
                  ShowInboxDataControllerInstanse.showInboxDataApi() ;
                });
              }
            case Status.COMPLETED:
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * .04),
                    child: ShowInboxDataControllerInstanse.viewInboxData.value.recruiterInboxData?.length == 0 ||
                          ShowInboxDataControllerInstanse.viewInboxData.value.recruiterInboxData == null ?
                    Center(child: const Text("No profiles have been selected for inbox.",textAlign: TextAlign.center,)) :
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: Get.height*.03),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: ShowInboxDataControllerInstanse.viewInboxData.value.recruiterInboxData?.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var data = ShowInboxDataControllerInstanse.viewInboxData.value.recruiterInboxData?[index] ;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: GestureDetector(
                                          onTap: () {
                                            Get.to( () => ScheduleInterview(seekerID:"${data?.seekerId}" , requestID: "",talentPool: true, scheduleInterview: false,)) ;
                                          },
                                  child: Container(
                                   padding:  const EdgeInsets.symmetric(vertical: 20),
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff353535),
                                        borderRadius: BorderRadius.circular(24)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              minVerticalPadding: 11,
                                              leading: CachedNetworkImage(
                                                  imageUrl: "${data?.seekerProfile?.profileImg}",
                                              imageBuilder: (context, imageProvider) => Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  )
                                                ),
                                              ),
                                                placeholder: (context, url) => const CircularProgressIndicator(color: Colors.white,),
                                              ),
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${data?.seekerProfile?.fullname ?? "No data"}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge
                                                        ?.copyWith(
                                                            color: const Color(
                                                                0xffFFFFFF)),
                                                  ),
                                                  // Text(
                                                  //     "Software engineer ",
                                                  //     style: Theme.of(context)
                                                  //         .textTheme
                                                  //         .bodySmall
                                                  //         ?.copyWith(
                                                  //             color: const Color(
                                                  //                 0xffCFCFCF),
                                                  //             fontWeight:
                                                  //                 FontWeight
                                                  //                     .w600)),
                                                  // SizedBox(
                                                  //   height: Get.height * .003,
                                                  // ),
                                                ],
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Text(
                                                    "${data?.seekerProfile?.location ?? "No location"}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Color(0xffCFCFCF),
                                                            fontSize: 10),
                                                  ),
                                                  // Container(
                                                  //   margin: const EdgeInsets.only(
                                                  //       right: 6, left: 6),
                                                  //   height: 18,
                                                  //   width: 1,
                                                  //   color: const Color(0xffFFFFFF)
                                                  //       .withOpacity(0.3),
                                                  // ),
                                                  // SizedBox(
                                                  //   height: Get.height * .001,
                                                  // ),
                                                  // Image.asset(
                                                  //   "assets/images/icon_watch.png",
                                                  //   height: Get.height * .018,
                                                  // ),
                                                  // SizedBox(
                                                  //   width: Get.width * .025,
                                                  // ),
                                                  // Text(
                                                  //   "45 minuts ago",
                                                  //   style: Theme.of(context)
                                                  //       .textTheme
                                                  //       .labelLarge
                                                  //       ?.copyWith(
                                                  //           fontWeight:
                                                  //               FontWeight.w400,
                                                  //           fontSize: 8,
                                                  //           color: const Color(
                                                  //               0xffCFCFCF)),
                                                  // )
                                                ],
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: Get.height * .01,
                                            // ),
                                            // Text(
                                            //   "Experience when moving to a new job",
                                            //   style: Theme.of(context)
                                            //       .textTheme
                                            //       .labelLarge
                                            //       ?.copyWith(
                                            //           fontWeight:
                                            //               FontWeight.w700,
                                            //           color: Color(0xffFFFFFF)),
                                            // ),
                                            SizedBox(
                                              height: Get.height * .02,
                                            ),
                                            HtmlWidget(data?.description ?? "No about",textStyle: Theme.of(context).textTheme
                                                .bodyLarge?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xffCFCFCF)),),
                                            // RichText(
                                            //     text: TextSpan(
                                            //         text:
                                            //             "Culture shock when moving to a new job is normal. This is not something wrong and I personally experienced it, when I experienced this when I changed jobs in 2 days...",
                                            //         style: Theme.of(context)
                                            //             .textTheme
                                            //             .labelLarge
                                            //             ?.copyWith(
                                            //                 fontWeight:
                                            //                     FontWeight.w400,
                                            //                 color: Color(
                                            //                     0xffCFCFCF)),
                                            //         children: [
                                            //       // TextSpan(
                                            //       //     text: "Read more",
                                            //       //     style: Theme.of(context)
                                            //       //         .textTheme
                                            //       //         .labelLarge
                                            //       //         ?.copyWith(
                                            //       //             fontWeight:
                                            //       //                 FontWeight
                                            //       //                     .w400,
                                            //       //             color: Color(
                                            //       //                 0xff56B8F6)))
                                            //     ]))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: Get.height * .07,
                          ),
                        ],
                      ),
                    )),
              );
          }
        }));
  }

  // void _onShare(BuildContext context) async {
  //   final box = context.findRenderObject() as RenderBox?;
  //   if (uri.isNotEmpty) {
  //     await Share.shareUri(Uri.parse(uri));
  //   } else if (imagePaths.isNotEmpty) {
  //     final files = <XFile>[];
  //     for (var i = 0; i < imagePaths.length; i++) {
  //       files.add(XFile(imagePaths[i], name: imageNames[i]));
  //     }
  //     await Share.shareXFiles(files,
  //         text: text,
  //         subject: subject,
  //         sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  //   } else {
  //     await Share.share(text,
  //         subject: subject,
  //         sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  //   }
  // }
}
