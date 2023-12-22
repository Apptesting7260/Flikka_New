// import 'package:flikka/Job%20Seeker/Authentication/sign_up.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }
//
// class _WelcomeScreenState extends State<WelcomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   actions: [
//       //     Padding(
//       //       padding:  EdgeInsets.symmetric(horizontal: Get.width*.04,vertical: Get.height*.02),
//       //       child: Text("Flikka",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28),),
//       //     ),
//       //   ],
//       // ),
//       body: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: Get.width*.06),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: Get.height*.06,),
//               Align(
//                 alignment: Alignment.topRight,
//                   child: Text("Flikka",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28),)),
//               SizedBox(height: Get.height*.1,),
//               Center(
//                 child: Image.asset("assets/images/welcome_icon.png",height: Get.height*.30,),
//               ),
//               SizedBox(height: Get.height*.05,),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: RichText(
//                   text: TextSpan(
//                     text: "Find Your\n",
//                     style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40),
//                     children: [
//                       TextSpan(
//                         text: "Dream Job\n",
//                         style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40,color: Colors.blueAccent),
//                       ),
//                       TextSpan(
//                         text: "Here!",
//                         style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40),
//                       ),
//                     ],
//                   ),
//                 )
//               ),
//               SizedBox(height: Get.height*.03,),
//               Align(
//                 alignment: Alignment.topLeft,
//                   child: Text("Explore all the most exciting job roles based on your interest and study major.",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),)),
//               SizedBox(height: Get.height*.03,),
//               Align(
//                   alignment: Alignment.topRight,
//                   child: InkWell(child: Image.asset("assets/images/icon_welcome_next.png",height: Get.height*.063,),
//                   onTap: () {
//                     Get.to(() =>Sign_Up());
//                   },
//                   )),
//               SizedBox(height: Get.height*.05,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
