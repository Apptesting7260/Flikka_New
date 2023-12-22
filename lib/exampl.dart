// import 'package:flikka/widgets/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class Notification1 extends StatefulWidget {
//   const Notification1({super.key});
//
//   @override
//   State<Notification1> createState() => _Notification1PageState();
// }
//
// class _Notification1PageState extends State<Notification1> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 25.0),
//           child: InkWell(
//               onTap: (){
//                 Get.back();
//               },
//               child: Image.asset('assets/images/backicon.png')),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.black,
//         title: Text("Notification1", style: Get.theme.textTheme.displayLarge),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: Get.height*0.01,),
//               Container(
//                 height: Get.height*0.125,
//                 width: Get.width,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: AppColors.blackdown,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         children: [
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                   radius: 26,
//                                   backgroundImage: AssetImage('assets/images/companylogo.png')
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(left: 8),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Example Company Inc. 2023",style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white,fontSize: 12)),
//                                     SizedBox(height: Get.height*0.01,),
//                                     Text("View Your Profile",style:Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF))),
//
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                       Align(
//                           alignment: AlignmentDirectional.topEnd,
//                           child: Image.asset('assets/images/Options.png'))
//                     ],
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
