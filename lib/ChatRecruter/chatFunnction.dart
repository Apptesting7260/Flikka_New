import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flikka/ChatRecruter/CreateFuction.dart';
import 'package:flikka/Job%20Seeker/SeekerHome/home_swiper_find_job_widget.dart';
import 'package:flikka/chatseeker/CreateChat.dart';
import 'package:flikka/controllers/SeekerUpdateVideoController/SeekerUpdateVideoController.dart';
import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/viewSeekerProfilecontrollerr.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MsgFunctionRecruter{
  // ViewSeekerProfileController seekerProfileController = Get.put( ViewSeekerProfileController());
   ViewRecruiterProfileGetController viewRecruiterProfileController = Get.put(ViewRecruiterProfileGetController());




///////////////CHATROOM FUNCTIONS///////////////////////
selfchatroom(){

  
}

////////////////MESSAGESING FUNCTIONS////////////////////////////

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
          "RoomID": "GPR"+viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.id.toString()+SeekerIDchat.toString(),
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
            .collection('Rooms')
            .doc(roomid).set(roomdetails);
     await _firestore
            .collection('Rooms')
            .doc(roomid)
            .collection("massages")
            .add(messages);
            print("mysendersusscess");
              DocumentReference roomRef1 = _firestore.collection("Rooms").doc(roomid);
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


}