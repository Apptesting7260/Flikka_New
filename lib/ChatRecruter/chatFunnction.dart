import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flikka/ChatRecruter/CreateFuction.dart';
import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flikka/main.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


class MsgFunctionRecruter{
  // ViewSeekerProfileController seekerProfileController = Get.put( ViewSeekerProfileController());
   ViewRecruiterProfileGetController viewRecruiterProfileController = Get.put(ViewRecruiterProfileGetController());




///////////////CHATROOM FUNCTIONS///////////////////////
selfchatroom(){

  
}

////////////////MESSAGESING FUNCTIONS////////////////////////////
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

SendMsgToRecruiter(String msg,String myidchat,String roomid, Map<String, dynamic> messages)async{
  ViewSeekerProfileController seekerProfileController = ViewSeekerProfileController();
      SharedPreferences sp = await SharedPreferences.getInstance() ;

  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
seekerProfileController.viewSeekerProfileApi();
   

   print("${viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.id.toString()}---------userid");
 Map <String, dynamic> roomdetails = {};
     roomdetails={
      
               "SeekerName":Seekerimgchat,
          "SeekerId":SeekerIDchat.toString(),
          "RoomID": "GRP"+viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.id.toString()+SeekerIDchat.toString(),
          'timestamp': FieldValue.serverTimestamp(),
          "lastmsg": "",
          "SeekeronScreen":"false",
        "RecruiterOnScreen": "false",
        "RecruiterId": viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString(),
        "RecruiterName": viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.companyName.toString(),
        "RecruiterImage": viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.profileImg.toString(),
        "SeekerImage":Seekerimgchat.toString()
            
    };

    print(roomdetails);
  await _firestore
            .collection('RoomID')
            .doc(roomid).set(roomdetails);
     await _firestore
            .collection('RoomID')
            .doc(roomid)
            .collection("massages")
            .add(messages);
            print("mysendersusscess");
              DocumentReference roomRef1 = _firestore.collection("RoomID").doc(roomid);
  DocumentReference roomRef2 = _firestore.collection("R-ID"+viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()).doc(roomid);
  DocumentReference roomRef3 = _firestore.collection("S-ID"+SeekerIDchat.toString()).doc(roomid);

           await roomRef1.update({
      'timestamp': FieldValue.serverTimestamp(),
      "lastmsg": msg,

      // Add other room metadata if needed
    });

       await roomRef2.update({
      'timestamp': FieldValue.serverTimestamp(),
      "lastmsg": msg,

      // Add other room metadata if needed
    });
      await roomRef3.update({
      'timestamp': FieldValue.serverTimestamp(),
      "lastmsg": msg,

      // Add other room metadata if needed
    });

}

 sendNotification(String body,String chatname) async {

  print("notification data ");
      var gettingDeviceTokenSnapshot = await _firestore.collection("S-ID${SeekerIDchat.toString()}").doc('DeviceToken').get();
                                        var gettingDeviceToken = gettingDeviceTokenSnapshot.data();
                                        fcmToken=gettingDeviceToken!['device token'];
                                         print(fcmToken);
      
        // if(onScreen=="false"&&gettingDeviceToken!=null){                               
    var notificationContent = {
      'to': gettingDeviceToken['device token'],
      'notification': {
        'title': '${chatname}',
        'body': body,
        // "image": "${chatimage}"
      },
      'data':{
        
        'what': 'chat',
       
      }
    };
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(notificationContent),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAAMWCvfmE:APA91bFkvTB6eQyJ6q9pkFACLeK8Wc7Ma_M9p6x7yq4gYKvO1nZcfYjy7h85ZN8eCu7ihwiZlCpUE5f6OtfxfL1lgK5NuE0pzrx9OoRdF8SRNOLWkdvLXq8RhEVHQvTDViiAyWJGE0TY'
        }).then((value) {
      if (kDebugMode) {
        print("================================send notification    =======${value.body.toString()}===============================");
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });

        }

}