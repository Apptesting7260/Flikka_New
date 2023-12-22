


// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cupid_match/GlobalVariable/GlobalVariable.dart';
// import 'package:cupid_match/controllers/SeekerMyProfileDetailsController/SeekerMyProfileController.dart';
// import 'package:cupid_match/controllers/controller/ViewSikerDetailsController/ViewSikerDetaolsController.dart';
// import 'package:cupid_match/data/response/status.dart';
// import 'package:cupid_match/match_maker/chat_screen.dart';
// import 'package:cupid_match/match_seeker/Chat_list_Screen.dart';
// import 'package:cupid_match/match_seeker/chat_screen.dart';
// import 'package:cupid_match/models/AllOcupationsModel/AllOcupationsModel.dart';
// import 'package:cupid_match/models/RequestModel/RequestModel.dart';
// import 'package:cupid_match/models/ViewMakerProfileDetailsModel/ViewMakerProfileDetailsModel.dart';
// import 'package:cupid_match/models/ViewProfileDetailsModel/ViewProfileDetailsModel.dart';
// import 'package:cupid_match/repository/Auth_Repository/Auth_Repository.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ViewRequestDetailsController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final ViewSikerProfileDetailsControllerinstance=Get.put(ViewSikerProfileDetailsController
// ());
// final SeekerMyProfileDetailsController seekerMyProfileController = Get.put(SeekerMyProfileDetailsController());
//   final _api = AuthRepository();


//   final rxRequestStatus = Status.LOADING.obs ;
//   final ViewProfileDetail =RequestDetailsModel().obs ;
//   RxString error = ''.obs;
  


//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   void setRxRequestStatus(Status value) => rxRequestStatus.value = value ;
//   void ViewProfileDetails(RequestDetailsModel value) => ViewProfileDetail.value = value ;
//   void setError(String value) => error.value = value ;


//   Future<dynamic> ViewRequestDetailsApiHit()async{
//         final SharedPreferences prefs = await SharedPreferences.getInstance();

//     Map data={
// "request_id":requestid.toString()
//     };
//    setRxRequestStatus(Status.LOADING);

//     _api.RequestDetailsApi(data).then((value)async {
//       setRxRequestStatus(Status.COMPLETED);
//       ViewProfileDetails(value);
//       // print(value);
//       makerchatuser=null;
//       Map <String, dynamic> roomdetails = {};
//       Map <String, dynamic> roomdetailsmaker = {};
//       Map <String, dynamic> roomdetailsanotherseeker = {};

//       print(_firestore.collection(value.data!.getseeker!.id.toString()).doc(value.data!.roomid.toString()).get().toString());


// Future<bool> doesDocumentExist(String collectionPath, String documentPath) async {
//   final documentReference = FirebaseFirestore.instance.collection("s"+value.data!.getseeker!.id.toString()).doc(value.data!.roomid.toString());
//   final snapshot = await documentReference.get();

//   return snapshot.exists;
// }

// // Example usage:
// final collectionPath = "s"+value.data!.getseeker!.id.toString();
// final documentPath = value.data!.roomid.toString();
// final exists = await doesDocumentExist(collectionPath, documentPath);
// var image=seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()== value.data!.getseeker!.id.toString()?value.data!.getanotherseeker!
// .imgPath.toString():value.data!.getseeker!.imgPath.toString();
//   var image2=seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()!= value.data!.getseeker!.id.toString()?value.data!.getanotherseeker!
// .imgPath.toString():value.data!.getseeker!.imgPath.toString();
// var seekerId=seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()== value.data!.getseeker!.id.toString()?value.data!.getanotherseeker!
// .id.toString():value.data!.getseeker!.id.toString();
//   var seekerId2=seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()!= value.data!.getseeker!.id.toString()?value.data!.getanotherseeker!
// .id.toString():value.data!.getseeker!.id.toString();
// if (exists) {
//    anotherchatuser= seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()== value.data!.getseeker!.id.toString()?value.data!.getanotherseeker!.id.toString():value.data!.getseeker!.id.toString();
//    roomid=value.data!.roomid.toString();
//   // The document exists.
//   // You can proceed with your logic here.
// } else {

//       if (value.data!.matchWith.toString() != "null"&&value.data!.roomid.toString()!="null") {
//         roomdetails = {
//           "seeker_name1": value.data!.getseeker!.name.toString(),
//           "seeker_name2": value.data!.getanotherseeker!.name.toString(),
// "Requestid":value.data!.id.toString(),
//           "seeker_id1": value.data!.getseeker!.id.toString(),
//             "roomid": value.data!.roomid!.toString(),

//           "seeker_id2": value.data!.getanotherseeker!.id.toString(),
//            'timestamp': FieldValue.serverTimestamp(),
//       "lastmsg": "",
//       "status":"online",
//       "onScreen":"false",
//       "makerOnScreen": "false",
//      if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")     "maker_id": value.data!.getmaker!.id.toString(),
//       if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")    "maker_name": value.data!.getmaker!.name.toString(),
// if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")   "maker_image": value.data!.getmaker!.imgPath.toString(),
        

//           "seeker_inage1": image,
//           "seeker_inage2": image2,
//        if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")  "roomname":  value.data!.getseeker!.id.toString()==seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()?

//               value.data!.getanotherseeker!.name.toString()+" & "+ value.data!.getmaker!.name.toString():value.data!.getseeker!.name.toString()+" & "+ value.data!.getmaker!.name.toString(),
//               if(value.data!.makerId.toString()=="null")"roomname": value.data!.getseeker!.id.toString()==seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()?

//               value.data!.getanotherseeker!.name.toString():value.data!.getseeker!.name.toString()
//         };
//          roomdetailsanotherseeker = {
//           "seeker_name1": value.data!.getseeker!.name.toString(),
//           "seeker_name2": value.data!.getanotherseeker!.name.toString(),
// "Requestid":value.data!.id.toString(),
//    "roomid": value.data!.roomid!.toString(),
//           "seeker_id1": value.data!.getseeker!.id.toString(),
//  "lastmsg": "",
//  'timestamp': FieldValue.serverTimestamp(),
//    "status":"online",
//       "onScreen":"false",
//       "makerOnScreen": "false",
//           "seeker_id2": value.data!.getanotherseeker!.id.toString(),
//     if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")    "maker_id": value.data!.getmaker!.id.toString(),
//       if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")   "maker_name": value.data!.getmaker!.name.toString(),
//       if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")   "maker_image": value.data!.getmaker!.imgPath.toString(),
      

//           "seeker_inage1": image2,
//           "seeker_inage2": image,
  

//        if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")  "roomname":  value.data!.getseeker!.id.toString()!=seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()?

//               value.data!.getanotherseeker!.name.toString()+" & "+ value.data!.getmaker!.name.toString():value.data!.getseeker!.name.toString()+" & "+ value.data!.getmaker!.name.toString(),
//               if(value.data!.getmaker.toString()=="null")"roomname": value.data!.getseeker!.id.toString()!=seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()?

//               value.data!.getanotherseeker!.name.toString():value.data!.getseeker!.name.toString()
//         };

//     if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3"){
     
//       roomdetailsmaker = {
//           "seeker_name1": value.data!.getseeker!.name.toString(),
//           "seeker_name2": value.data!.getanotherseeker!.name.toString(),
//  "lastmsg": "",
//  'timestamp': FieldValue.serverTimestamp(),
//           "seeker_id1": value.data!.getseeker!.id.toString(),
// "Requestid":value.data!.id.toString(),
//           "seeker_id2": value.data!.getanotherseeker!.id.toString(),
//    "maker_id": value.data!.getmaker!.id.toString(),
//       "maker_name": value.data!.getmaker!.name.toString(),
//     "maker_image": value.data!.getmaker!.imgPath.toString(),
//        "roomid": value.data!.roomid!.toString(),
//    "status":"online",
//       "$seekerId":"false",
//        "$seekerId2":"false",
//           "seeker_inage1": image,
//           "seeker_inage2": image2,
//       "roomname":

//               value.data!.getanotherseeker!.name.toString()+" & "+value.data!.getseeker!.name.toString(),
     

           
//         };
//       if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")  await _firestore.collection("m"+value.data!.makerId.toString(),).doc(value.data!.roomid.toString()).set(roomdetailsmaker);
//   if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3") makerchatuser= value.data!.makerId.toString();

//      } 

     

//         await _firestore.collection("s"+value.data!.getseeker!.id.toString(),).doc(value.data!.roomid.toString()).set(roomdetails);
//        await _firestore.collection("s"+value.data!.getanotherseeker!.id.toString(),).doc(value.data!.roomid.toString()).set(roomdetailsanotherseeker);

//        anotherchatuser= seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()== value.data!.getseeker!.id.toString()?value.data!.getanotherseeker!.id.toString():value.data!.getseeker!.id.toString();
//       }



 

//   // The document does not exist.
//   // Handle the case where the document does not exist.
// }

       

//        // print("hit request api 5678900bbuhc 8u0u00-09-9-9-09-9-9-09-9jkcniuicjzijnnzijxn");
// // print(ViewSikerProfileDetailsControllerinstance.ViewProfileDetail.value.profileDetails![0].id.toString());

//        //  await _firestore.collection("seeker").doc(ViewSikerProfileDetailsControllerinstance.ViewProfileDetail.value.profileDetails![0].id.toString()).collection("Request").doc(value.data!.id.toString()).set({
//        //   "getseeker":value.data!.getseeker!.id.toString(),
//        //   "getmaker":value.data!.getmaker==null?"": value.data!.getmaker!.id.toString(),
//        //   "getanotherseeker":value.data!.getanotherseeker!.id.toString(),
//        //   "requestid":value.data!.id.toString()
//        //  });
//        // await _firestore.collection("RoomId's").doc(value.data!.roomid.toString()).set({});S

// //  if(value.data!.roomid==null) {


// //  }else{
// //   print("");

// //   }
// print("chatttttttttt");

//        print("fjksdfn");
//      }
//     ).onError((error, stackTrace){
//       setError(error.toString());
//       print("${error.toString()}===============+++=");
//       setRxRequestStatus(Status.ERROR);

//     });

//     seekercreatechat(){
  
// }
//   }



//   // Stream<QuerySnapshot> getMessagesStream() {
//   //   return firestore
//   //       .collection(widget.collectionName)
//   //       .orderBy('timestamp', descending: true)
//   //       .snapshots();
//   // }
//   //    var data = snapshot.data?.docs[index];
  
// }





// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cupid_match/GlobalVariable/GlobalVariable.dart';
// import 'package:cupid_match/controllers/SeekerMyProfileDetailsController/SeekerMyProfileController.dart';
// import 'package:cupid_match/controllers/controller/ViewSikerDetailsController/ViewSikerDetaolsController.dart';
// import 'package:cupid_match/data/response/status.dart';
// import 'package:cupid_match/match_maker/chat_screen.dart';
// import 'package:cupid_match/match_seeker/Chat_list_Screen.dart';
// import 'package:cupid_match/match_seeker/chat_screen.dart';
// import 'package:cupid_match/models/AllOcupationsModel/AllOcupationsModel.dart';
// import 'package:cupid_match/models/RequestModel/RequestModel.dart';
// import 'package:cupid_match/models/ViewMakerProfileDetailsModel/ViewMakerProfileDetailsModel.dart';
// import 'package:cupid_match/models/ViewProfileDetailsModel/ViewProfileDetailsModel.dart';
// import 'package:cupid_match/repository/Auth_Repository/Auth_Repository.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ViewRequestDetailsController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final ViewSikerProfileDetailsControllerinstance=Get.put(ViewSikerProfileDetailsController
// ());
// final SeekerMyProfileDetailsController seekerMyProfileController = Get.put(SeekerMyProfileDetailsController());
//   final _api = AuthRepository();


//   final rxRequestStatus = Status.LOADING.obs ;
//   final ViewProfileDetail =RequestDetailsModel().obs ;
//   RxString error = ''.obs;
  


//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   void setRxRequestStatus(Status value) => rxRequestStatus.value = value ;
//   void ViewProfileDetails(RequestDetailsModel value) => ViewProfileDetail.value = value ;
//   void setError(String value) => error.value = value ;


//   Future<dynamic> ViewRequestDetailsApiHit()async{
//         final SharedPreferences prefs = await SharedPreferences.getInstance();

//     Map data={
// "request_id":requestid.toString()
//     };
//    setRxRequestStatus(Status.LOADING);

//     _api.RequestDetailsApi(data).then((value)async {
//       setRxRequestStatus(Status.COMPLETED);
//       ViewProfileDetails(value);
//       // print(value);
//       makerchatuser=null;
//       Map <String, dynamic> roomdetails = {};
//       Map <String, dynamic> roomdetailsmaker = {};
//       Map <String, dynamic> roomdetailsanotherseeker = {};

//       print(_firestore.collection(value.data!.getseeker!.id.toString()).doc(value.data!.roomid.toString()).get().toString());


// Future<bool> doesDocumentExist(String collectionPath, String documentPath) async {
//   final documentReference = FirebaseFirestore.instance.collection("s"+value.data!.getseeker!.id.toString()).doc(value.data!.roomid.toString());
//   final snapshot = await documentReference.get();

//   return snapshot.exists;
// }

// // Example usage:
// final collectionPath = "s"+value.data!.getseeker!.id.toString();
// final documentPath = value.data!.roomid.toString();
// final exists = await doesDocumentExist(collectionPath, documentPath);
// var image=seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()== value.data!.getseeker!.id.toString()?value.data!.getanotherseeker!
// .imgPath.toString():value.data!.getseeker!.imgPath.toString();
//   var image2=seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()!= value.data!.getseeker!.id.toString()?value.data!.getanotherseeker!
// .imgPath.toString():value.data!.getseeker!.imgPath.toString();
// var seekerId=seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()== value.data!.getseeker!.id.toString()?value.data!.getanotherseeker!
// .id.toString():value.data!.getseeker!.id.toString();
//   var seekerId2=seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()!= value.data!.getseeker!.id.toString()?value.data!.getanotherseeker!
// .id.toString():value.data!.getseeker!.id.toString();
// if (exists) {
//    anotherchatuser= seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()== value.data!.getseeker!.id.toString()?value.data!.getanotherseeker!.id.toString():value.data!.getseeker!.id.toString();
//    roomid=value.data!.roomid.toString();
//   // The document exists.
//   // You can proceed with your logic here.
// } else {

//       if (value.data!.matchWith.toString() != "null"&&value.data!.roomid.toString()!="null") {
//         roomdetails = {
//           "seeker_name1": value.data!.getseeker!.name.toString(),
//           "seeker_name2": value.data!.getanotherseeker!.name.toString(),
// "Requestid":value.data!.id.toString(),
//           "seeker_id1": value.data!.getseeker!.id.toString(),
//             "roomid": value.data!.roomid!.toString(),

//           "seeker_id2": value.data!.getanotherseeker!.id.toString(),
//            'timestamp': FieldValue.serverTimestamp(),
//       "lastmsg": "",
//       "status":"online",
//       "onScreen":"false",
//       "makerOnScreen": "false",
//      if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")     "maker_id": value.data!.getmaker!.id.toString(),
//       if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")    "maker_name": value.data!.getmaker!.name.toString(),
// if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")   "maker_image": value.data!.getmaker!.imgPath.toString(),
        

//           "seeker_inage1": image,
//           "seeker_inage2": image2,
//        if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")  "roomname":  value.data!.getseeker!.id.toString()==seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()?

//               value.data!.getanotherseeker!.name.toString()+" & "+ value.data!.getmaker!.name.toString():value.data!.getseeker!.name.toString()+" & "+ value.data!.getmaker!.name.toString(),
//               if(value.data!.makerId.toString()=="null")"roomname": value.data!.getseeker!.id.toString()==seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()?

//               value.data!.getanotherseeker!.name.toString():value.data!.getseeker!.name.toString()
//         };
//          roomdetailsanotherseeker = {
//           "seeker_name1": value.data!.getseeker!.name.toString(),
//           "seeker_name2": value.data!.getanotherseeker!.name.toString(),
// "Requestid":value.data!.id.toString(),
//    "roomid": value.data!.roomid!.toString(),
//           "seeker_id1": value.data!.getseeker!.id.toString(),
//  "lastmsg": "",
//  'timestamp': FieldValue.serverTimestamp(),
//    "status":"online",
//       "onScreen":"false",
//       "makerOnScreen": "false",
//           "seeker_id2": value.data!.getanotherseeker!.id.toString(),
//     if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")    "maker_id": value.data!.getmaker!.id.toString(),
//       if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")   "maker_name": value.data!.getmaker!.name.toString(),
//       if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")   "maker_image": value.data!.getmaker!.imgPath.toString(),
      

//           "seeker_inage1": image2,
//           "seeker_inage2": image,
  

//        if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")  "roomname":  value.data!.getseeker!.id.toString()!=seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()?

//               value.data!.getanotherseeker!.name.toString()+" & "+ value.data!.getmaker!.name.toString():value.data!.getseeker!.name.toString()+" & "+ value.data!.getmaker!.name.toString(),
//               if(value.data!.getmaker.toString()=="null")"roomname": value.data!.getseeker!.id.toString()!=seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()?

//               value.data!.getanotherseeker!.name.toString():value.data!.getseeker!.name.toString()
//         };

//     if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3"){
     
//       roomdetailsmaker = {
//           "seeker_name1": value.data!.getseeker!.name.toString(),
//           "seeker_name2": value.data!.getanotherseeker!.name.toString(),
//  "lastmsg": "",
//  'timestamp': FieldValue.serverTimestamp(),
//           "seeker_id1": value.data!.getseeker!.id.toString(),
// "Requestid":value.data!.id.toString(),
//           "seeker_id2": value.data!.getanotherseeker!.id.toString(),
//    "maker_id": value.data!.getmaker!.id.toString(),
//       "maker_name": value.data!.getmaker!.name.toString(),
//     "maker_image": value.data!.getmaker!.imgPath.toString(),
//        "roomid": value.data!.roomid!.toString(),
//    "status":"online",
//       "$seekerId":"false",
//        "$seekerId2":"false",
//           "seeker_inage1": image,
//           "seeker_inage2": image2,
//       "roomname":

//               value.data!.getanotherseeker!.name.toString()+" & "+value.data!.getseeker!.name.toString(),
     

           
//         };
//       if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3")  await _firestore.collection("m"+value.data!.makerId.toString(),).doc(value.data!.roomid.toString()).set(roomdetailsmaker);
//   if(value.data!.matchType.toString()=="0"||value.data!.matchType.toString()=="2"||value.data!.matchType.toString()=="3") makerchatuser= value.data!.makerId.toString();

//      } 

     

//         await _firestore.collection("s"+value.data!.getseeker!.id.toString(),).doc(value.data!.roomid.toString()).set(roomdetails);
//        await _firestore.collection("s"+value.data!.getanotherseeker!.id.toString(),).doc(value.data!.roomid.toString()).set(roomdetailsanotherseeker);

//        anotherchatuser= seekerMyProfileController.SeekerMyProfileDetail.value.ProfileDetail!.id.toString()== value.data!.getseeker!.id.toString()?value.data!.getanotherseeker!.id.toString():value.data!.getseeker!.id.toString();
//       }



 

//   // The document does not exist.
//   // Handle the case where the document does not exist.
// }

       

//        // print("hit request api 5678900bbuhc 8u0u00-09-9-9-09-9-9-09-9jkcniuicjzijnnzijxn");
// // print(ViewSikerProfileDetailsControllerinstance.ViewProfileDetail.value.profileDetails![0].id.toString());

//        //  await _firestore.collection("seeker").doc(ViewSikerProfileDetailsControllerinstance.ViewProfileDetail.value.profileDetails![0].id.toString()).collection("Request").doc(value.data!.id.toString()).set({
//        //   "getseeker":value.data!.getseeker!.id.toString(),
//        //   "getmaker":value.data!.getmaker==null?"": value.data!.getmaker!.id.toString(),
//        //   "getanotherseeker":value.data!.getanotherseeker!.id.toString(),
//        //   "requestid":value.data!.id.toString()
//        //  });
//        // await _firestore.collection("RoomId's").doc(value.data!.roomid.toString()).set({});S

// //  if(value.data!.roomid==null) {


// //  }else{
// //   print("");

// //   }
// print("chatttttttttt");

//        print("fjksdfn");
//      }
//     ).onError((error, stackTrace){
//       setError(error.toString());
//       print("${error.toString()}===============+++=");
//       setRxRequestStatus(Status.ERROR);

//     });

//     seekercreatechat(){
  
// }
//   }



//   // Stream<QuerySnapshot> getMessagesStream() {
//   //   return firestore
//   //       .collection(widget.collectionName)
//   //       .orderBy('timestamp', descending: true)
//   //       .snapshots();
//   // }
//   //    var data = snapshot.data?.docs[index];
  
// }


