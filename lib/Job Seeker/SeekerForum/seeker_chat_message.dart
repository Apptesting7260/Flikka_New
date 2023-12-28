import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flikka/Job%20Recruiter/message/message_page.dart';
import 'package:flikka/chatseeker/ChatScreen.dart';
import 'package:flikka/chatseeker/CreateChat.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/ViewSeekerProfileController/ViewSeekerProfileControllerr.dart';
import '../SeekerBottomNavigationBar/tab_bar.dart';

class ForumMessagePage extends StatefulWidget {
  const ForumMessagePage({super.key});

  @override
  State<ForumMessagePage> createState() => _ForumMessagePageState();
}

class _ForumMessagePageState extends State<ForumMessagePage> {
  ViewSeekerProfileControllerr seekerProfileControllerr = Get.put( ViewSeekerProfileControllerr());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> getMessagesStream() {
    print("S-ID${seekerProfileControllerr.viewSeekerData.value.seekerInfo!.id.toString()}");

    return firestore
        .collection("S-ID${seekerProfileControllerr.viewSeekerData.value.seekerInfo?.id.toString()}")
        .orderBy('timestamp', descending: true)
        .snapshots();

  }
  String formatTimestamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    final DateFormat formatter = DateFormat('h:mm a');
    return formatter.format(dateTime);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizedBox(height: Get.height*.025,),
              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(28),
              //       color: Color(0xff373737)
              //   ),
              //   height: Get.height*0.08,
              //
              //   child:
              //   TextFormField(
              //     decoration: InputDecoration(
              //         contentPadding: EdgeInsets.only(top: 15),
              //         enabledBorder: InputBorder.none,
              //         focusedBorder: InputBorder.none,
              //         prefixIcon: Image.asset('assets/images/searchicon.png'),
              //         hintText: 'Search',
              //         hintStyle: TextStyle(
              //           color: Color(0xffCFCFCF),
              //         )
              //     ),
              //     //kkkkkkkkkkkkkkkkkkkkkkkkk2222222
              //
              //   ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width*.05,vertical: Get.height*.006),
                decoration: BoxDecoration(
                  color: Color(0xff373737),
                  borderRadius: BorderRadius.circular(33.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: AppColors.blueThemeColor,size: 30,),
                    SizedBox(width: Get.width*.03),
                    Expanded(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF),fontSize: 19),
                        onChanged: (query){
                          // filterPositionNames(query);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height*0.03,),
              //save prost first navi
              Expanded(
                  child: StreamBuilder(
                      stream: getMessagesStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.active) {
                          return snapshot.data!.docs.isEmpty == false
                              ?ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context,index){
                                var data = snapshot.data?.docs[index];
                                final timestamp = snapshot.data?.docs[index]['timestamp'] as Timestamp;
                                var roomid =
                                snapshot.data?.docs[index]['RoomID'];
                                return Padding(
                                  padding:  EdgeInsets.symmetric(vertical: Get.height*.01),
                                  child: GestureDetector(
                                    onTap: (){
                                      RecruiterId=data['RecruiterId'];
                                      chatname=data['RecruiterName'];
                                      Chatimage=data['RecruiterImage'];
                                      setState(() {
                                        chatname;
                                        RecruiterId;
                                        Chatimage;
                                      });
                                      print(RecruiterId);
                                      Get.to(ChatPage());

                                    },
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 26,
                                        backgroundImage:NetworkImage(data![ "RecruiterImage"]),

                                      ),
                                      title: Text(data!['RecruiterName'],style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white)),
                                      subtitle:  Text(data![ "lastmsg"],style:Get.theme.textTheme.bodySmall!.copyWith(color: Colors.blue)),
                                      trailing: Column(
                                        children: [
                                          SizedBox(height: Get.height*0.015,),
                                          Text(   formatTimestamp(timestamp),style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 10,color: Color(0xffCFCFCF))),

                                          SizedBox(height: Get.height*0.005,),
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
                              }):Container();
                        }else{
                          return Container( child: Center(child: Text("No Chat List Available",style: TextStyle(color: Colors.black),)),);
                        }}))
            ],
          ),
        )
    );
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

}