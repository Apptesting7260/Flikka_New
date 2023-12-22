
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flikka/Job%20Seeker/splash_screen.dart';
import 'package:flikka/widgets/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

var fcmToken ;
 void  main()  {
   //   WidgetsFlutterBinding.ensureInitialized();
   // await Firebase.initializeApp();
   //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
   //   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
   //   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
   //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
   //     print('Got a message whilst in the foreground!');
   //     print('Message data: ${message.data}');
   //
   //     if (message.notification != null) {
   //       print('Message also contained a notification: ${message.notification}');
   //     }
   //   });
   //   fcmToken = await FirebaseMessaging.instance.getToken();
   //   print('FCM Token: $fcmToken');
   //   FirebaseMessaging messaging = FirebaseMessaging.instance;
   //
   //   NotificationSettings settings = await messaging.requestPermission(
   //     alert: true,
   //     announcement: true,
   //     badge: true,
   //     carPlay: false,
   //     criticalAlert: false,
   //     provisional: false,
   //     sound: true,
   //   );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
//////////////////////////////////////////////
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flikka',
      theme: MyTheme.dark,
      home: const SplashScreen()
    );
  }
}

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//
//   // print(notificationBell.value);
//   // notificationBell.value = true;
//   // print(notificationBell.value);
//   print("Handling a background message");
//   print('hello');
//   print('new');
// }