import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import '../../controllers/RecruiterInboxDataController/RecruiterInboxDataController.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';

class InboxHiring extends StatefulWidget {
  const InboxHiring({super.key});

  @override
  State<InboxHiring> createState() => _InboxHiringState();
}

class _InboxHiringState extends State<InboxHiring> {

  @override
  void initState() {
    super.initState();
    if(ShowInboxDataControllerInstanse.viewInboxData.value.recruiterInboxData == null ||
        ShowInboxDataControllerInstanse.viewInboxData.value.recruiterInboxData?.length == 0
    ){
      ShowInboxDataControllerInstanse.showInboxDataApi() ;
    }

  }

  ShowInboxDataController ShowInboxDataControllerInstanse = Get.put(ShowInboxDataController());

  //////refresh//////
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await ShowInboxDataControllerInstanse.showInboxDataApi() ;
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await ShowInboxDataControllerInstanse.showInboxDataApi() ;
    if(mounted)
      _refreshController.loadComplete();
  }

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
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Container(
                                  // height: Get.height * .30,
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      color: Color(0xff353535),
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Stack(
                                    children: [
                                      Padding(
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
                                                  errorWidget: (context, url, error) => const SizedBox(
                                                    height: 40, child: Placeholder(),),
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
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: Get.height * .02,
                                              ),
                                              HtmlWidget(data?.description ?? "No about",textStyle: Theme.of(context).textTheme
                                                  .bodyLarge?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xffCFCFCF)),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
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
