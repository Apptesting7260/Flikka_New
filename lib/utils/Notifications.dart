import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Notifications {

  // sendNotification(String body) async {
  //
  //   print("notification data ");
  //   var gettingDeviceTokenSnapshot = await _firestore.collection("s${anotherCollecatinName.toString()}").doc('Device Token').get();
  //   var gettingDeviceToken = gettingDeviceTokenSnapshot.data();
  //   print(gettingDeviceToken!['device token']);
  //
  //   // if(onScreen=="false"&&gettingDeviceToken!=null){
  //   //   var notificationContent = {
  //   //     'to': gettingDeviceToken['device token'],
  //   //
  //   //     'notification': {
  //   //       'title': '${chatname}',
  //   //       'body': '${body}',
  //   //       "image": "${chatimage1}"
  //   //     },
  //   //     'data':{
  //   //
  //   //       'what': 'chat',
  //   //
  //   //     }
  //   //   };
  //   //   await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //   //       body: jsonEncode(notificationContent),
  //   //       headers: {
  //   //         'Content-Type': 'application/json; charset=UTF-8',
  //   //         'Authorization':
  //   //         'key=AAAAmlxyhHk:APA91bGH2iSIQb2WDZngInSeh41OJak5ovkzbFiftngdh1A8WU6Xf2b2SAB2RgdLFEphSLnPoPUipOjvLBPAbZuFE3HycjzkH8DTDQ7_0zSgdeuE8b08b1loiq9c9_GH5_5xRXHrK6hq'
  //   //       }).then((value) {
  //   //     if (kDebugMode) {
  //   //       print("================================send notification    =======${value.body.toString()}===============================");
  //   //     }
  //   //   }).onError((error, stackTrace) {
  //   //     if (kDebugMode) {
  //   //       print(error);
  //   //     }
  //   //   });
  //   //
  //   // }
  //   var gettingDeviceTokenSnapshot2 = await _firestore.collection("m${Makeridchat}").doc('Device Token').get();
  //   var gettingDeviceToken2 = gettingDeviceTokenSnapshot2.data();
  //   print("========================device token=====${gettingDeviceToken2!['device token']}======================================================================");
  //   // print("Maker Fcm Token    ${Makeridchat}");
  //     var notificationContent = {
  //       'to': gettingDeviceToken2['device token'],
  //
  //       'notification': {
  //         'title': '{chatname}',
  //         'body': '{body}',
  //         "image": "{chatimage1}"
  //       },
  //       'data':{
  //         'what': 'chat',
  //       }
  //     };
  //     await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //         body: jsonEncode(notificationContent),
  //         headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'Authorization':
  //           'key=AAAAmlxyhHk:APA91bGH2iSIQb2WDZngInSeh41OJak5ovkzbFiftngdh1A8WU6Xf2b2SAB2RgdLFEphSLnPoPUipOjvLBPAbZuFE3HycjzkH8DTDQ7_0zSgdeuE8b08b1loiq9c9_GH5_5xRXHrK6hq'
  //         }).then((value) {
  //       if (kDebugMode) {
  //         print("================================maker send notification    =======${value.body.toString()}===============================");
  //       }
  //     }).onError((error, stackTrace) {
  //       if (kDebugMode) {
  //         print(error);
  //       }
  //     });
  //
  //   }



}