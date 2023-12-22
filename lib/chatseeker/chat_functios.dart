import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flikka/chatseeker/CreateChat.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../Job Seeker/SeekerHome/find_job_home_page.dart';
import '../controllers/ViewSeekerProfileController/ViewSeekerProfileControllerr.dart';

class MsgFunction{
  // ViewSeekerProfileController seekerProfileController = Get.put( ViewSeekerProfileController());
  ViewSeekerProfileControllerr seekerProfileControllerr = Get.put( ViewSeekerProfileControllerr());
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;


///////////////CHATROOM FUNCTIONS///////////////////////
selfchatroom(){

  
}

////////////////MESSAGESING FUNCTIONS////////////////////////////

SendMsgToRecruiter(String msg,String myidchat,String roomid, Map<String, dynamic> messages)async{
  ViewSeekerProfileController seekerProfileController = ViewSeekerProfileController();
      SharedPreferences sp = await SharedPreferences.getInstance() ;

  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
seekerProfileController.viewSeekerProfileApi();
   

   print("${seekerProfileControllerr.viewSeekerData.value.seekerInfo!.id.toString()}---------userid");
 Map <String, dynamic> roomdetails = {};
     roomdetails={
      
               "SeekerName":seekerProfileControllerr.viewSeekerData.value.seekerInfo!.fullname.toString(),
          "SeekerId":seekerProfileControllerr.viewSeekerData.value.seekerInfo!.id.toString(),
          "RoomID": "GPR"+RecruiterId.toString()+sp.getString("seekerID")!,
          'timestamp': FieldValue.serverTimestamp(),
          "lastmsg": "",
          "SeekeronScreen":"false",
        "RecruiterOnScreen": "false",
        "RecruiterId": RecruiterId.toString(),
        "RecruiterName": Recruitername.toString(),
        "RecruiterImage": Recruiterimg.toString(),
        "SeekerImage":seekerProfileControllerr.viewSeekerData.value.seekerInfo!.profileImg.toString(),
            
    };

    print(roomdetails);
  await _firestore
            .collection('Rooms')
            .doc(roomid).set(roomdetails);
     await _firestore
            .collection('Rooms')
            .doc(roomid)
            .collection("massages")
            .add(messages);
            print("mysendersusscess");
              DocumentReference roomRef1 = _firestore.collection("Rooms").doc(roomid);
  DocumentReference roomRef2 = _firestore.collection("R-ID"+RecruiterId.toString()).doc(roomid);
  DocumentReference roomRef3 = _firestore.collection("S-ID"+seekerProfileControllerr.viewSeekerData.value.seekerInfo!.id.toString(),).doc(roomid);

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
      var gettingDeviceTokenSnapshot = await _firestore.collection("R-ID${RecruiterId.toString()}").doc('DeviceToken').get();
                                        var gettingDeviceToken = gettingDeviceTokenSnapshot.data();
                                          print(gettingDeviceToken!['device token']);
      
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
  
  
 

// }