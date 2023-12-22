import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../controllers/RecruiterInboxDataController/RecruiterInboxDataController.dart';
import '../../data/response/status.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../widgets/app_colors.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {


  @override
  void initState() {
    super.initState();
    ShowInboxDataControllerInstanse.showInboxDataApi() ;
  }

  ShowInboxDataController ShowInboxDataControllerInstanse =
      Get.put(ShowInboxDataController());

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
              return Padding(
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
                                            SizedBox(
                                              height: Get.height * .02,
                                            ),
                                            Text(
                                              "Experience when moving to a new job",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(0xffFFFFFF)),
                                            ),
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
                                    // Positioned(
                                    //   bottom: 0,
                                    //   left: 0,
                                    //   right: 0,
                                    //   child: Align(
                                    //     alignment:
                                    //         AlignmentDirectional.bottomCenter,
                                    //     child: Container(
                                    //       height: Get.height * .09,
                                    //       decoration: BoxDecoration(
                                    //         // color: Colors.grey[900],
                                    //         color: Color(0xff3F3F3F),
                                    //         borderRadius: BorderRadius.only(
                                    //             bottomLeft: Radius.circular(20),
                                    //             bottomRight:
                                    //                 Radius.circular(22)),
                                    //       ),
                                    //       child: Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.spaceBetween,
                                    //         children: [
                                    //           Row(
                                    //             children: [
                                    //               IconButton(
                                    //                   onPressed: () =>
                                    //                       toggleFavorite(),
                                    //                   icon: selectedFav == false
                                    //                       ? SvgPicture.asset(
                                    //                           'assets/images/likesvg.svg',
                                    //                           width: Get.width *
                                    //                               0.027,
                                    //                           height:
                                    //                               Get.height *
                                    //                                   0.027,
                                    //                           color:
                                    //                               buttonColor,
                                    //                         )
                                    //                       : Icon(
                                    //                           Icons
                                    //                               .favorite_rounded,
                                    //                           color:
                                    //                               AppColors.red,
                                    //                         )),
                                    //               Text("12",
                                    //                   style: Theme.of(context)
                                    //                       .textTheme
                                    //                       .bodySmall!
                                    //                       .copyWith(
                                    //                           color: AppColors
                                    //                               .white,
                                    //                           fontSize: 14)),
                                    //               SizedBox(
                                    //                 width: Get.width * 0.04,
                                    //               ),
                                    //
                                    //               //*************************
                                    //
                                    //               IconButton(
                                    //                 onPressed: () {
                                    //                   //showCommentDialog();
                                    //                 },
                                    //                 icon: SvgPicture.asset(
                                    //                     'assets/images/commentsvg.svg'),
                                    //               ),
                                    //               Text("10",
                                    //                   style: Theme.of(context)
                                    //                       .textTheme
                                    //                       .bodySmall!
                                    //                       .copyWith(
                                    //                           color: AppColors
                                    //                               .white,
                                    //                           fontSize: 14)),
                                    //             ],
                                    //           ),
                                    //           Padding(
                                    //             padding: EdgeInsets.only(
                                    //                 right: 14.0),
                                    //             child: Row(
                                    //               children: [
                                    //                 // Image.asset("assets/images/icon_person.png",height: Get.height*.035,),
                                    //                 IconButton(
                                    //                   onPressed: text.isEmpty &&
                                    //                           imagePaths
                                    //                               .isEmpty &&
                                    //                           uri.isEmpty
                                    //                       ? null
                                    //                       : () =>
                                    //                           _onShare(context),
                                    //                   icon: SvgPicture.asset(
                                    //                     'assets/images/sharesvg.svg',
                                    //                     height:
                                    //                         Get.height * .035,
                                    //                   ),
                                    //                 ),
                                    //                 Text("2",
                                    //                     style: Theme.of(context)
                                    //                         .textTheme
                                    //                         .bodySmall!
                                    //                         .copyWith(
                                    //                             color: AppColors
                                    //                                 .white,
                                    //                             fontSize: 18)),
                                    //               ],
                                    //             ),
                                    //           )
                                    //           // Padding(
                                    //           //   padding: const EdgeInsets.only(right: 14.0),
                                    //           //   child: Row(
                                    //           //     children: [
                                    //           //       Stack(
                                    //           //           children: [
                                    //           //             CircleAvatar(
                                    //           //               backgroundColor: Color(0xff56B8F6),
                                    //           //               radius: 17,
                                    //           //               child: Image.asset(
                                    //           //                 'assets/images/personicons.png',
                                    //           //               ),
                                    //           //               // Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.ratingcommenttextcolor,)
                                    //           //             ),
                                    //           //             SvgPicture.asset('assets/images/personsvg22.svg')
                                    //           //           ]
                                    //           //       ),
                                    //           //       IconButton(
                                    //           //         onPressed: text.isEmpty &&
                                    //           //             imagePaths.isEmpty &&
                                    //           //             uri.isEmpty
                                    //           //             ? null
                                    //           //             : () => _onShare(context),
                                    //           //         icon: SvgPicture.asset(
                                    //           //           'assets/images/sharesvg.svg',
                                    //           //         ),
                                    //           //       ),
                                    //           //       Text("2",
                                    //           //           style: Theme.of(context)
                                    //           //               .textTheme
                                    //           //               .bodySmall!
                                    //           //               .copyWith(
                                    //           //               color: AppColors.white, fontSize: 14)),
                                    //           //     ],
                                    //           //   ),
                                    //           // )
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
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
                  ));
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
