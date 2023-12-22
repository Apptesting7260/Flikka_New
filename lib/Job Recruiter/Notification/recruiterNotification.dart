// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flikka/widgets/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/SeekerNotificationDataViewController/SeekerNotificationViewDataController.dart';
// import '../../data/response/status.dart';
// import '../../res/components/general_expection.dart';
// import '../../res/components/internet_exception_widget.dart';
//
// class SeekerNotification extends StatefulWidget {
//   const SeekerNotification({super.key});
//
//   @override
//   State<SeekerNotification> createState() => _Notification1PageState();
// }
//
// class _Notification1PageState extends State<SeekerNotification> {
//
//   SeekerViewNotificationController SeekerViewNotificationControllerInstanse = Get.put(SeekerViewNotificationController()) ;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     SeekerViewNotificationControllerInstanse.viewSeekerNotificationApi() ;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       switch (SeekerViewNotificationControllerInstanse.rxRequestStatus.value) {
//         case Status.LOADING:
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//
//         case Status.ERROR:
//           if (SeekerViewNotificationControllerInstanse.error.value ==
//               'No internet') {
//             return InterNetExceptionWidget(
//               onPress: () {
//                 SeekerViewNotificationControllerInstanse.viewSeekerNotificationApi() ;
//               },
//             );
//           } else {
//             return GeneralExceptionWidget(onPress: () {
//               SeekerViewNotificationControllerInstanse.viewSeekerNotificationApi() ;
//             });
//           }
//         case Status.COMPLETED:
//           return Scaffold(
//             appBar: AppBar(
//               toolbarHeight: 45,
//               leading: InkWell(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Image.asset('assets/images/icon_back_blue.png')),
//               elevation: 0,
//               title: Text(
//                   "Notification", style: Get.theme.textTheme.displayLarge),
//             ),
//             body: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: Get.width*.025,vertical: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: Get.height * 0.01,),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: SeekerViewNotificationControllerInstanse
//                         .viewSeekerNotificationData.value.seekerNotification
//                         ?.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: AppColors.blackdown,
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               ListTile(
//                                 // visualDensity: VisualDensity(horizontal: -4),
//                                 leading: CachedNetworkImage(
//                                   imageUrl: SeekerViewNotificationControllerInstanse
//                                       .viewSeekerNotificationData.value
//                                       .seekerNotification?[index]
//                                       .jobFeatureImg ?? "",
//                                   imageBuilder: (context, imageProvider) => Container(
//                                     height: 70,
//                                     width: 70,
//                                     decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         image: DecorationImage(image: imageProvider,fit: BoxFit.cover)
//                                     ),
//                                   ),
//                                   placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
//                                 ),
//                                 title: Text(SeekerViewNotificationControllerInstanse.viewSeekerNotificationData.value.seekerNotification?[index].companyName ?? "",
//                                     overflow: TextOverflow.ellipsis),
//                                 subtitle: Text( SeekerViewNotificationControllerInstanse
//                                     .viewSeekerNotificationData.value
//                                     .seekerNotification?[index].description ?? ""),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//
//                   ),
//                   SizedBox(height: Get.height * 0.01,),
//                 ],
//               ),
//             ),
//           );
//       }
//     }
//     );
//   }
// }
