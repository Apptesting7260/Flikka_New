import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flikka/chatseeker/ChatScreen.dart';
import 'package:flikka/controllers/GetJobsListingController/GetJobsListingController.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Job Seeker/SeekerHome/find_job_home_page.dart';

String? RecruiterId;
String ?SeekerID;
class Ctreatechat{

  ViewSeekerProfileController seekerProfileController = Get.put( ViewSeekerProfileController());
final FirebaseFirestore firestore = FirebaseFirestore.instance;

  GetJobsListingController getJobsListingController = GetJobsListingController() ;

CreateChat()async{
 Map <String, dynamic> roomdetails = {};
      Map <String, dynamic> roomdetailsmaker = {};
      SharedPreferences sp = await SharedPreferences.getInstance() ;
if (kDebugMode) {
  print( RecruiterId);
  print( Recruitername);
  print( Recruiterimg);
}

     
/////////// check seeker collection is available or not ////////
Future<bool> doesCollectionExistSeeker() async {
  final collectionReference = FirebaseFirestore.instance.collection("S-ID"+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString());
  final snapshot = await collectionReference.get();

  return snapshot.docs.isNotEmpty;
}

//////// check Recruter collection is Available or not /////// 
Future<bool> doesCollectionExistRecruiter() async {
  final collectionReference = FirebaseFirestore.instance.collection("R-ID" + RecruiterId.toString());
  final snapshot = await collectionReference.get();

  return snapshot.docs.isNotEmpty;
}

// /check room id is available or  not ///////
Future<bool> doesDocumentExistSeekerRoomID(String documentPath) async {
  final documentReference = FirebaseFirestore.instance.collection("S-ID"+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),).doc(documentPath);
  final snapshot = await documentReference.get();

  return snapshot.exists;
}



// /check room id is available or  not ///////
Future<bool> doesDocumentExistRecruterRoomID(String documentPath) async {
  final documentReference = FirebaseFirestore.instance.collection("R-ID" + RecruiterId.toString()).doc(documentPath);
  final snapshot = await documentReference.get();

  return snapshot.exists;
}
bool isCollectionExistRecruter = await doesCollectionExistRecruiter();
bool isCollectionExistSeeker = await doesCollectionExistSeeker();


print("userid${seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString()}");


      // print(_firestore.collection(value.data!.getseeker!.id.toString()).doc(value.data!.roomid.toString()).get().toString());


// Future<bool> doesDocumentExistSeeker(String collectionPath, String documentPath) async {
//   final documentReference = FirebaseFirestore.instance.collection("S-ID"+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString()).doc("GRP"+RecruiterId.toString()+ sp.getString("seekerID")!);
//   final snapshot = await documentReference.get();

//   return snapshot.exists;
// }

// Future<bool> doesDocumentExistSeekerRoomId(String collectionPath, String documentPath) async {
//   final documentReference = FirebaseFirestore.instance.collection("S-ID"+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString()).doc("GRP"+RecruiterId.toString()+ sp.getString("seekerID")!);
//   final snapshot = await documentReference.get();

//   return snapshot.exists;
// }
// Future<bool> doesDocumentExistRecruter(String collectionPath, String documentPath) async {
//   final documentReference = FirebaseFirestore.instance.collection("R-ID"+RecruiterId.toString()).doc("GRP"+RecruiterId.toString()+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString());
//   final snapshot = await documentReference.get();

//   return snapshot.exists;
// }




// final SeekercollectionPath = "S-ID"+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString();
// final SeekerdocumentPath ="GRP"+RecruiterId.toString()+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString();
// final Seekerexists = await doesDocumentExistSeeker(SeekercollectionPath, SeekerdocumentPath);


// final RecruitercollectionPath = "R-ID"+RecruiterId.toString();
// final RecruiterdocumentPath ="GRP"+RecruiterId.toString()+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString();
// final Recruiterexists = await doesDocumentExistSeeker(RecruitercollectionPath, RecruiterdocumentPath);

if (isCollectionExistSeeker) {
    bool isDocumentExistRoomid = await doesDocumentExistSeekerRoomID("GRP" + RecruiterId.toString() + seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString());
    if(isDocumentExistRoomid){
  Get.to(ChatPage());

    }else{
    roomdetails = {
          "SeekerName":seekerProfileController.viewSeekerData.value.seekerInfo!.fullname.toString(),
          "SeekerId": seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),
          "RoomID": "GRP"+RecruiterId.toString()+sp.getString("seekerID")!,
          'timestamp': FieldValue.serverTimestamp(),
          "lastmsg": "",
          "SeekeronScreen":"false",
        "RecruiterOnScreen": "false",
        "RecruiterId": RecruiterId.toString(),
        "RecruiterName": Recruitername.toString(),
        "RecruiterImage": Recruiterimg.toString(),
        "SeekerImage":seekerProfileController.viewSeekerData.value.seekerInfo!.profileImg.toString(),
       };
         await firestore.collection("S-ID"+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),).doc("GRP"+RecruiterId.toString()+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),).set(roomdetails);
  Get.to(ChatPage());


     }
  // bool isDocumentExist = await doesDocumentExistRecruiter("GRP" + RecruiterId.toString() + seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString());
// print("$isDocumentExist========available");

// if(isDocumentExist==false){
//   roomdetails = {
//           "SeekerName":seekerProfileController.viewSeekerData.value.seekerInfo!.fullname.toString(),
//           "SeekerId": seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),
//           "RoomID": "GRP"+RecruiterId.toString()+sp.getString("seekerID")!,
//           'timestamp': FieldValue.serverTimestamp(),
//           "lastmsg": "",
//           "SeekeronScreen":"false",
//         "RecruiterOnScreen": "false",
//         "RecruiterId": RecruiterId.toString(),
//         "RecruiterName": Recruitername.toString(),
//         "RecruiterImage": Recruiterimg.toString(),
//         "SeekerImage":seekerProfileController.viewSeekerData.value.seekerInfo!.profileImg.toString(),
//        };
//          await firestore.collection("S-ID"+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),).doc("GRP"+RecruiterId.toString()+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),).set(roomdetails);
 
// }
  if (kDebugMode) {
    print("seeker is is already available");
  }
  // Seeker document exists
} else {
    roomdetails = {
        "SeekerName":seekerProfileController.viewSeekerData.value.seekerInfo!.fullname.toString(),
        "SeekerId": seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),
        "RoomID": "GRP"+RecruiterId.toString()+sp.getString("seekerID")!,
        'timestamp': FieldValue.serverTimestamp(),
        "lastmsg": "",
        "SeekeronScreen":"false",
        "RecruiterOnScreen": "false",
        "RecruiterId": RecruiterId.toString(),
        "RecruiterName": Recruitername.toString(),
        "RecruiterImage": Recruiterimg.toString(),
        "SeekerImage":seekerProfileController.viewSeekerData.value.seekerInfo!.profileImg.toString(),
       };
         await firestore.collection("S-ID"+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),).doc("GRP"+RecruiterId.toString()+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),).set(roomdetails);
 
   Get.to(ChatPage());

  // Seeker document does not exist
}

if (isCollectionExistRecruter) {
    bool isDocumentExistRoomid = await doesDocumentExistSeekerRoomID("GRP" + RecruiterId.toString() + seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString());
if(isDocumentExistRoomid){
Get.to(ChatPage());
}else{
  roomdetails = {
        "SeekerName":seekerProfileController.viewSeekerData.value.seekerInfo!.fullname.toString(),
        "SeekerId": seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),
        "RoomID": "GRP"+RecruiterId.toString()+sp.getString("seekerID")!,
        'timestamp': FieldValue.serverTimestamp(),
        "lastmsg": "",
        "SeekeronScreen":"false",
        "RecruiterOnScreen": "false",
        "RecruiterId": RecruiterId.toString(),
        "RecruiterName": Recruitername.toString(),
        "RecruiterImage": Recruiterimg.toString(),
        "SeekerImage":seekerProfileController.viewSeekerData.value.seekerInfo!.profileImg.toString(),
       };
       await firestore.collection("R-ID"+RecruiterId.toString(),).doc("GRP"+RecruiterId.toString()+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),).set(roomdetails);
  Get.to(ChatPage());

}
  // Recruiter document exists
} else {
   roomdetails = {
          "SeekerName":seekerProfileController.viewSeekerData.value.seekerInfo!.fullname.toString(),
          "SeekerId": seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),
          "RoomID": "GRP"+RecruiterId.toString()+sp.getString("seekerID")!,
          'timestamp': FieldValue.serverTimestamp(),
          "lastmsg": "",
          "SeekeronScreen":"false",
        "RecruiterOnScreen": "false",
        "RecruiterId": RecruiterId.toString(),
        "RecruiterName": Recruitername.toString(),
        "RecruiterImage": Recruiterimg.toString(),
        "SeekerImage":seekerProfileController.viewSeekerData.value.seekerInfo!.profileImg.toString(),
       };
       await firestore.collection("R-ID"+RecruiterId.toString(),).doc("GRP"+RecruiterId.toString()+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),).set(roomdetails);
  Get.to(ChatPage());
       
  // Seeker document does not exist
}

  // Recruiter document does not exist
}

}