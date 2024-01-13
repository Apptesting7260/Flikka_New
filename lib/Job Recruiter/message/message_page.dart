// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flikka/ChatRecruter/ChatScreenRecruter.dart';
// import 'package:flikka/ChatRecruter/CreateFuction.dart';
// import 'package:flikka/Job%20Recruiter/bottom_bar/tab_bar.dart';
// import 'package:flikka/Job%20Seeker/SeekerChatMessage/video_calling_and_chatting_page.dart';
// import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
// import 'package:flikka/widgets/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// String ?chatname;
// String ?Chatimage;
// class RecruiterMessagePage extends StatefulWidget {
//   const RecruiterMessagePage({super.key});

//   @override
//   State<RecruiterMessagePage> createState() => _RecruiterMessagePageState();
// }

// class _RecruiterMessagePageState extends State<RecruiterMessagePage> {
//   ViewRecruiterProfileGetController viewRecruiterProfileController = Get.put(ViewRecruiterProfileGetController());
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//     Stream<QuerySnapshot> getMessagesStream() {
//       print("R-ID${viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()}");
//     return firestore
//         .collection("R-ID${viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()}")
//         .orderBy('timestamp', descending: true)
//         .snapshots();



//   }

//   String formatTimestamp(Timestamp timestamp) {
//     final DateTime dateTime = timestamp.toDate();
//     final DateFormat formatter = DateFormat('h:mm a');
//     return formatter.format(dateTime);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 70,
//           title: Text("Message",style: Get.theme.textTheme.displayLarge),
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 15.0),
//             child: InkWell(
//                 onTap: (){
//                   Get.back() ;
//                   Get.offAll(TabScreenEmployer(index: 0));
//                 },
//                 child: Image.asset('assets/images/icon_back_blue.png')),
//           ),
//           elevation: 0,

//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18.0),
//           child: Column(
//             children: [

//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: Get.width*.05,vertical: Get.height*.006),
//                 decoration: BoxDecoration(
//                   color: Color(0xff373737),
//                   borderRadius: BorderRadius.circular(33.0),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.search, color: AppColors.blueThemeColor,size: 30,),
//                     SizedBox(width: Get.width*.03),
//                     Expanded(
//                       child: TextFormField(
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF),fontSize: 19),
//                         onChanged: (query){
//                           // filterPositionNames(query);
//                         },
//                         decoration: InputDecoration(
//                           hintText: 'Search',
//                           hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: Get.height*0.03,),
//               //save prost first navi
//                        Expanded(
//                 child: StreamBuilder(
//             stream: getMessagesStream(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.active) {

//                 return snapshot.data!.docs.isEmpty == false
//                     ?ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context,index){
//                   var roomid=snapshot.data?.docs[index]['RoomID'];
//                       var data = snapshot.data?.docs[index];
//                          final timestamp = snapshot.data?.docs[index]['timestamp'] as Timestamp;

//                       return Padding(
//                         padding:  EdgeInsets.symmetric(vertical: Get.height*.01),
//                         child: GestureDetector(
//                           onTap: (){
//                                 SeekerIDchat=data['SeekerId'];
//                                 chatname=data['SeekerName'];
//                                 Chatimage=data['SeekerImage'];
//                                 setState(() {
//                                   SeekerIDchat;
//                                   chatname;
//                                   Chatimage;
//                                 });
//                                 Get.to(ChatScreenRecruter());

//                           },
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               radius: 26,
//                               backgroundImage:NetworkImage(data![ "SeekerImage"]),

//                             ),
//                             title: Text(data!['SeekerName'],style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white)),
//                             subtitle:  Text(data![ "lastmsg"],style:Get.theme.textTheme.bodySmall!.copyWith(color: Colors.blue)),
//                             trailing: Column(
//                               children: [
//                                 SizedBox(height: Get.height*0.015,),

//                               Text(   formatTimestamp(timestamp),style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 10,color: Color(0xffCFCFCF))),
//                              Text(MessengeRead(roomid))
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }):Container();
//   }else{
// return Container( child: Center(child: Text("No Chat List Available",style: TextStyle(color: Colors.black),)),);
//             }}))
//             ],
//           ),
//         )
//     );
//   }
//       MessengeRead(String roomid){
//         var totalcount;
//           firestore.collection("Rooms").doc(roomid).collection("massages").get().then((value) {
//                value.docs.forEach((element) {

// firestore.collection("Rooms").doc(roomid).collection("massages").doc(element.id).get().then((value) {

//   int count=0;
//   if( value['isRead']==false){
//   totalcount=  count++;
//       print(totalcount);
//   }



// });


//                });

//           });
//    return totalcount.toString();
//       }
// }

import 'package:flikka/ChatRecruter/ChatScreenRecruter.dart';
import 'package:flikka/ChatRecruter/CreateFuction.dart';
import 'package:flikka/Job%20Recruiter/bottom_bar/tab_bar.dart';
import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



String? chatname;
String? Chatimage;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Recruiter Message Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecruiterMessagePage(),
    );
  }
}

class RecruiterMessagePage extends StatefulWidget {
  const RecruiterMessagePage({Key? key}) : super(key: key);

  @override
  State<RecruiterMessagePage> createState() => _RecruiterMessagePageState();
}

class _RecruiterMessagePageState extends State<RecruiterMessagePage> {
  ViewRecruiterProfileGetController viewRecruiterProfileController =
  Get.put(ViewRecruiterProfileGetController());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMessagesStream() {
    print(
        "R-ID${viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()}");
    return firestore
        .collection(
        "R-ID${viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()}")
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  String formatTimestamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    final DateFormat formatter = DateFormat('h:mm a');
    return formatter.format(dateTime);
  }

  Future<String> MessengeRead(String roomid) async {
    int totalcount = 0;

    QuerySnapshot<Map<String, dynamic>> messages = await firestore
        .collection("Rooms")
        .doc(roomid)
        .collection("massages")
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> message in messages.docs) {
      bool isRead = message['isRead'] ?? false;
      if (!isRead) {
        totalcount++;
      }
    }

    return totalcount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        toolbarHeight: 70,
        centerTitle: true,
        title: Text("Your chats", style: Get.theme!.textTheme!.displayLarge?.copyWith(color: AppColors.black)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: InkWell(
              onTap: () {
                Get.back();
                Get.offAll(TabScreenEmployer(index: 0));
              },
              child: Image.asset('assets/images/icon_back_blue.png')),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: Get.width*  .05, vertical: Get.height * .006),
            //   decoration: BoxDecoration(
            //     color: Color(0xff373737),
            //     borderRadius: BorderRadius.circular(33.0),
            //   ),
            //   child: Row(
            //     children: [
            //       Icon(Icons.search,
            //           color: AppColors.blueThemeColor, size: 30),
            //       SizedBox(width: Get.width * .03),
            //       Expanded(
            //         child: TextFormField(
            //           style: Theme.of(context)
            //               .textTheme
            //               .bodyLarge
            //               ?.copyWith(color: Color(0xffCFCFCF), fontSize: 19),
            //           onChanged: (query) {
            //             // filterPositionNames(query);
            //           },
            //           decoration: InputDecoration(
            //             hintText: 'Search',
            //             hintStyle: Theme.of(context)
            //                 .textTheme
            //                 .bodyLarge
            //                 ?.copyWith(color: Color(0xffCFCFCF)),
            //             border: InputBorder.none,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            TextFormField(
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.black,fontSize: 15),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search,color: AppColors.blueThemeColor,size: 30,),
                filled: true,
                fillColor: AppColors.homeGrey,
                hintText: 'Search',
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: BorderSide.none,
                ),

              ),
            ),
            SizedBox(height: Get.height * 0.03),
            Expanded(
              child: StreamBuilder(
                stream: getMessagesStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    return snapshot.data!.docs.isEmpty == false
                        ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var roomid =
                        snapshot.data?.docs[index]['RoomID'];
                        var data = snapshot.data?.docs[index];
                        final timestamp =
                        snapshot.data?.docs[index]['timestamp'] as Timestamp;

                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Get.height * .01),
                          child: GestureDetector(
                            onTap: () async {
                              SeekerIDchat = data['SeekerId'];
                              chatname = data['SeekerName'];
                              Chatimage = data['SeekerImage'];
                              setState(() {
                                SeekerIDchat;
                                chatname;
                                Chatimage;
                              });
                              Get.to(ChatScreenRecruter());
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 26,
                                backgroundImage: NetworkImage(
                                    data!["SeekerImage"]),
                              ),
                              title: Text(data!['SeekerName'],
                                  style: Get.theme!.textTheme!.titleSmall!
                                      .copyWith(
                                      color: AppColors.black)),
                              subtitle: Text(data!["lastmsg"],
                                  style: Get.theme!.textTheme!.bodySmall!
                                      .copyWith(color: Colors.blue)),
                              trailing: Column(
                                children: [
                                  SizedBox(height: Get.height * 0.015,),
                                  Text(
                                    formatTimestamp(timestamp),
                                    style: Get.theme!.textTheme!.bodySmall!
                                        .copyWith(
                                        fontSize: 10,
                                        color: AppColors.silverColor),
                                  ),
                                  FutureBuilder<String>(
                                    future: MessengeRead(roomid),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text("");
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            "Error: ${snapshot.error}");
                                      } else {
                                        return snapshot.data!="0"? CircleAvatar(
                                            radius: 8,
                                            child: Center(child: Text(snapshot.data ?? "",style: TextStyle(color: Colors.white,fontSize: 8),))):SizedBox();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                        : Container();
                  } else {
                    return Container(
                      child: Center(
                        child: Text(
                          "No Chat List Available",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
