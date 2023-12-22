import 'package:flikka/widgets/google_map_widget.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PushNotification extends StatefulWidget {
  const PushNotification({super.key});

  @override
  State<PushNotification> createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: Image.asset('assets/images/backicon.png'),
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text("Push Notification",style: Get.theme.textTheme.displayLarge),

        ),
        body:
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(5),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xff353535),
              borderRadius: BorderRadius.circular(25)
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "New Job Match",
                            style:  Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),
                          ),
                          Text(
                            "Marketing manager ",
                            style: Get.theme.textTheme.bodyMedium!.copyWith(color: Color(0xffCFCFCF)),
                          ),
                        ],
                      ),
                      IconButton(constraints:BoxConstraints(),onPressed: (){}, icon: Image.asset('assets/images/notificationdrawericon.png',scale: 2.8,))
                    ],
                  ),

                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
                    style:Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),textAlign: TextAlign.justify,),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
