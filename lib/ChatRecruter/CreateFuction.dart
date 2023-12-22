import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flikka/ChatRecruter/ChatScreenRecruter.dart';
import 'package:flikka/Job%20Seeker/Authentication/user/user_profile.dart';
import 'package:flikka/Job%20Seeker/SeekerChatMessage/message_page.dart';
import 'package:flikka/Job%20Seeker/SeekerChatMessage/video_calling_and_chatting_page.dart';
import 'package:flikka/Job%20Seeker/SeekerHome/home_swiper_find_job_widget.dart';
import 'package:flikka/chatseeker/ChatScreen.dart';
import 'package:flikka/chatseeker/CreateChat.dart';
import 'package:flikka/controllers/GetJobsListingController/GetJobsListingController.dart';
import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

String ?SeekerIDchat;
String ?Seekerimgchat;
String ?SeekerName;
class Createchatrecruter{

   ViewRecruiterProfileGetController viewRecruiterProfileController = Get.put(ViewRecruiterProfileGetController());

final FirebaseFirestore firestore = FirebaseFirestore.instance;

  GetJobsListingController getJobsListingController = GetJobsListingController() ;

CreateChat()async{
  print(viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString());
 Map <String, dynamic> roomdetails = {};
      Map <String, dynamic> roomdetailsmaker = {};
      SharedPreferences sp = await SharedPreferences.getInstance() ;

     
/////////// check seeker collection is available or not ////////
Future<bool> doesCollectionExistSeeker() async {
  final collectionReference = FirebaseFirestore.instance.collection("S-ID"+SeekerIDchat.toString());
  final snapshot = await collectionReference.get();

  return snapshot.docs.isNotEmpty;
}

//////// check Recruter collection is Available or not /////// 
Future<bool> doesCollectionExistRecruiter() async {
  final collectionReference = FirebaseFirestore.instance.collection("R-ID" + viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString());
  final snapshot = await collectionReference.get();

  return snapshot.docs.isNotEmpty;
}

// /check room id is available or  not ///////
Future<bool> doesDocumentExistSeekerRoomID(String documentPath) async {
  final documentReference = FirebaseFirestore.instance.collection("S-ID"+SeekerIDchat.toString(),).doc(documentPath);
  final snapshot = await documentReference.get();

  return snapshot.exists;
}



// /check room id is available or  not ///////
Future<bool> doesDocumentExistRecruterRoomID(String documentPath) async {
  final documentReference = FirebaseFirestore.instance.collection("R-ID" +viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()).doc(documentPath);
  final snapshot = await documentReference.get();

  return snapshot.exists;
}
bool isCollectionExistRecruter = await doesCollectionExistRecruiter();
bool isCollectionExistSeeker = await doesCollectionExistSeeker();


print("userid$SeekerIDchat");









      // print(_firestore.collection(value.data!.getseeker!.id.toString()).doc(value.data!.roomid.toString()).get().toString());


// Future<bool> doesDocumentExistSeeker(String collectionPath, String documentPath) async {
//   final documentReference = FirebaseFirestore.instance.collection("S-ID"+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString()).doc("GPR"+RecruiterId.toString()+ sp.getString("seekerID")!);
//   final snapshot = await documentReference.get();

//   return snapshot.exists;
// }

// Future<bool> doesDocumentExistSeekerRoomId(String collectionPath, String documentPath) async {
//   final documentReference = FirebaseFirestore.instance.collection("S-ID"+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString()).doc("GPR"+RecruiterId.toString()+ sp.getString("seekerID")!);
//   final snapshot = await documentReference.get();

//   return snapshot.exists;
// }
// Future<bool> doesDocumentExistRecruter(String collectionPath, String documentPath) async {
//   final documentReference = FirebaseFirestore.instance.collection("R-ID"+RecruiterId.toString()).doc("GPR"+RecruiterId.toString()+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString());
//   final snapshot = await documentReference.get();

//   return snapshot.exists;
// }




// final SeekercollectionPath = "S-ID"+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString();
// final SeekerdocumentPath ="GPR"+RecruiterId.toString()+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString();
// final Seekerexists = await doesDocumentExistSeeker(SeekercollectionPath, SeekerdocumentPath);


// final RecruitercollectionPath = "R-ID"+RecruiterId.toString();
// final RecruiterdocumentPath ="GPR"+RecruiterId.toString()+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString();
// final Recruiterexists = await doesDocumentExistSeeker(RecruitercollectionPath, RecruiterdocumentPath);

if (isCollectionExistSeeker) {
    bool isDocumentExistRoomid = await doesDocumentExistSeekerRoomID("GPR" + viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()+SeekerIDchat.toString());
    if(isDocumentExistRoomid){
  Get.to(ChatScreenRecruter());

    }else{
    roomdetails = {
          "SeekerName":SeekerName.toString(),
          "SeekerId": SeekerIDchat.toString(),
          "RoomID": "GPR"+viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()+SeekerIDchat.toString(),
          'timestamp': FieldValue.serverTimestamp(),
          "lastmsg": "",
          "SeekeronScreen":"false",
        "RecruiterOnScreen": "false",
        "RecruiterId": viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString(),
        "RecruiterName": viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.companyName.toString(),
        "RecruiterImage":viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.profileImg.toString(),
        "SeekerImage":Seekerimgchat.toString()
       };
         await firestore.collection("S-ID"+SeekerIDchat.toString(),).doc("GPR"+viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()+SeekerIDchat.toString(),).set(roomdetails);
  Get.to(ChatScreenRecruter());


     }
  // bool isDocumentExist = await doesDocumentExistRecruiter("GPR" + RecruiterId.toString() + seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString());
// print("$isDocumentExist========available");

// if(isDocumentExist==false){
//   roomdetails = {
//           "SeekerName":SeekerName.toString(),
//           "SeekerId": SeekerIDchat.toString(),
//           "RoomID": "GPR"+viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()+SeekerIDchat.toString(),
//           'timestamp': FieldValue.serverTimestamp(),
//           "lastmsg": "",
//           "SeekeronScreen":"false",
//         "RecruiterOnScreen": "false",
//         "RecruiterId": RecruiterId.toString(),
//         "RecruiterName": Recruitername.toString(),
//         "RecruiterImage": Recruiterimg.toString(),
//         "SeekerImage":Seekerimgchat.toString()
//        };
//          await firestore.collection("S-ID"+SeekerIDchat.toString(),).doc("GPR"+RecruiterId.toString()+SeekerIDchat.toString(),).set(roomdetails);
 
// }
  print("seeker is is already available");
  // Seeker document exists
} else {
    roomdetails = {
          "SeekerName":SeekerName.toString(),
          "SeekerId": SeekerIDchat.toString(),
          "RoomID": "GPR"+viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()+SeekerIDchat.toString(),
          'timestamp': FieldValue.serverTimestamp(),
          "lastmsg": "",
          "SeekeronScreen":"false",
        "RecruiterOnScreen": "false",
        "RecruiterId": viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString(),
        "RecruiterName": viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.companyName.toString(),
        "RecruiterImage": viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.profileImg.toString(),
        "SeekerImage":Seekerimgchat.toString()
       };
         await firestore.collection("S-ID"+SeekerIDchat.toString(),).doc("GPR"+viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()+SeekerIDchat.toString()).set(roomdetails);
 
   Get.to(ChatScreenRecruter());

  // Seeker document does not exist
}

if (isCollectionExistRecruter) {
    bool isDocumentExistRoomid = await doesDocumentExistSeekerRoomID("GPR" + RecruiterId.toString() + SeekerIDchat.toString());
if(isDocumentExistRoomid){
Get.to(ChatScreenRecruter());
}else{
  roomdetails = {
          "SeekerName":SeekerName.toString(),
          "SeekerId": SeekerIDchat.toString(),
          "RoomID": "GPR"+viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()+SeekerIDchat.toString(),
          'timestamp': FieldValue.serverTimestamp(),
          "lastmsg": "",
          "SeekeronScreen":"false",
        "RecruiterOnScreen": "false",
        "RecruiterId": viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString(),
        "RecruiterName": viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.companyName.toString(),
        "RecruiterImage": viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.profileImg.toString(),
        "SeekerImage":Seekerimgchat.toString()
       };
       await firestore.collection("R-ID"+viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString(),).doc("GPR"+viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()+SeekerIDchat.toString(),).set(roomdetails);
  Get.to(ChatScreenRecruter());

}
  // Recruiter document exists
} else {
   roomdetails = {
          "SeekerName":SeekerName.toString(),
          "SeekerId": SeekerIDchat.toString(),
          "RoomID": "GPR"+viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()+SeekerIDchat.toString(),
          'timestamp': FieldValue.serverTimestamp(),
          "lastmsg": "",
          "SeekeronScreen":"false",
        "RecruiterOnScreen": "false",
        "RecruiterId":viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString(),
        "RecruiterName": viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.companyName.toString(),
        "RecruiterImage": viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.profileImg.toString(),
        "SeekerImage":Seekerimgchat.toString()
       };
       await firestore.collection("R-ID"+viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString(),).doc("GPR"+viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails!.recruiterId.toString()+SeekerIDchat.toString(),).set(roomdetails);
  Get.to(ChatScreenRecruter());
       
  // Seeker document does not exist
}

  // Recruiter document does not exist
}

}