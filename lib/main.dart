import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flikka/Job%20Seeker/help%20section/help.dart';
import 'package:flikka/Job%20Seeker/splash_screen.dart';
import 'package:flikka/widgets/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

import 'Job Seeker/JobAlert/job_alert_listing.dart';
import 'controllers/SeekerNotificationDataViewController/SeekerNotificationViewDataController.dart';
import 'hiring Manager/Applicant_Tracking/applicant_tracking_tabbar.dart';

String? fcmToken;
void main() async {
  // await  GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
   await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  String? initialMessage;

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings();

  @override
  void initState() {
    firebaseNotification();

    super.initState();
  }
  getFcmToken() {
    print("sdfsdfdsfdsfdsafdsfdsf");
    firebaseMessaging.getToken().then((String? token) async {
      if (token == null) {
      } else {
        fcmToken = token;

        print("token=======$fcmToken");
      }
    }).catchError((error) {
      print(error.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flikka',
        themeMode: ThemeMode.dark,
        theme: MyTheme.dark,
        home:   const SplashScreen()
    );
  }

  firebaseNotification() async {
    firebaseMessaging.requestPermission(alert: true);
    firebaseMessaging.isAutoInitEnabled;
    var android =
    const AndroidInitializationSettings('@drawable/launch_background');
    var ios = const DarwinInitializationSettings();
    var platform = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    firebaseMessaging.requestPermission(
        sound: true, alert: true, badge: true, provisional: true);
    // initLocalNotification();

    getFcmToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? appleNotification = message.notification?.apple;

      print('message notification body=====${message.notification?.body}');
      if (notification != null && android != null) {
        showNotification(message.notification);
        print('android not null notification==${message.notification}');
        FirebaseMessaging.instance.getInitialMessage().then((message) {

          SeekerViewNotificationController SeekerViewNotificationControllerInstanse = Get.put(SeekerViewNotificationController()) ;
          SeekerViewNotificationControllerInstanse.viewSeekerNotificationApi();

          if (message != null) {
            print("abc525");
          } else {
            print("abc");
          }
        });
      } else if (notification != null && appleNotification != null) {
        showNotification(message.notification);
      } else {}
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        // Get.offAll(NotificationScreen());
      }
    });

    firebaseMessaging.getToken().then((String? token) async {
      if (token == null) {
      } else {
        // MySharedPreferences.localStorage
        //     ?.setString(MySharedPreferences.deviceId, token);
        // print("token===$token");
      }
    }).catchError((error) {
      print(error.toString());
    });
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      print('FlutterFire Messaging Example: Getting APNs token...');
      String? token = await FirebaseMessaging.instance.getAPNSToken();
      print('FlutterFire Messaging Example: Got APNs token: $token');
    }
  }

  // Future initLocalNotification() async {
  //   if (Platform.isIOS) {
  //     // set iOS Local notification.
  //     var initializationSettingsAndroid =
  //     const AndroidInitializationSettings('ic_launcher');
  //     var initializationSettingsIOS = DarwinInitializationSettings(
  //       requestAlertPermission: false,
  //       requestBadgePermission: false,
  //       requestSoundPermission: false,
  //       onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
  //     );
  //
  //     final InitializationSettings initializationSettings =
  //     InitializationSettings(
  //         android: initializationSettingsAndroid,
  //         iOS: initializationSettingsDarwin);
  //     flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //         onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  //   } else {
  //     // set Android Local notification.
  //     var initializationSettingsAndroid =
  //     const AndroidInitializationSettings('@drawable/launch_background');
  //     var initializationSettingsIOS = DarwinInitializationSettings(
  //         onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
  //     var initializationSettings = InitializationSettings(
  //         android: initializationSettingsAndroid,
  //         iOS: initializationSettingsIOS);
  //
  //     await flutterLocalNotificationsPlugin.initialize(
  //       initializationSettings,
  //       onDidReceiveBackgroundNotificationResponse: (details) {
  //         _selectNotification(details.payload);
  //       },
  //     );
  //   }
  // }

  Future showNotification(RemoteNotification? notification) async {
    var android = const AndroidNotificationDetails(
      'CHANNLEID',
      "CHANNLENAME",
      channelDescription: "channelDescription",
      importance: Importance.max,
      fullScreenIntent: true,
      priority: Priority.high,
      visibility: NotificationVisibility.public,
    );
    var iOS = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(DateTime.now().second,
        notification?.title, notification?.body, platform);
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message==$message");
  }

  Future _onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    print("receive==$payload,== $body");
    // Get.offAll(NotificationScreen());
  }

  Future _selectNotification(String? payload) async {
    // return    Get.offAll(NotificationScreen());
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    // Get.offAll(NotificationScreen());
  }
}
