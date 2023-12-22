import 'package:flikka/Job%20Seeker/SeekerChatMessage/message_page.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../SeekerChatMessage/video_calling_and_chatting_page.dart';


class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool settingTap = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset('assets/images/icon_back_blue.png')),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text("Notifications", style: Get.theme.textTheme.displayLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xff353535),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/firstlogomarketing.png',
                                  scale: 0.9,
                                ),
                                SizedBox(
                                  width: Get.width * 0.029,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Marketing Intern",
                                      style: Get.theme.textTheme.headlineMedium!
                                          .copyWith(color: AppColors.white),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.005,
                                    ),
                                    Text(
                                      "Example Company Pvt. Ltd",
                                      style: Get.theme.textTheme!.bodySmall!
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20.0),
                                      ),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[800],
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                  Radius.circular(20))),
                                          height: Get.height * 0.39,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: Get.height * 0.045,
                                                      ),
                                                      Align(
                                                          alignment: AlignmentDirectional.topCenter,
                                                          child: Image.asset('assets/images/underline.png')),
                                                      SizedBox(
                                                        height: Get.height * 0.045,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset('assets/images/icon_delete.png'),
                                                          SizedBox(
                                                            width: Get.width * 0.045,
                                                          ),
                                                          Text(
                                                              "Delete",
                                                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white))
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * 0.035,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset('assets/images/Notificationsicon.png'),
                                                          SizedBox(
                                                            width: Get.width * 0.045,
                                                          ),
                                                          Text(
                                                              "Turn off notifications",
                                                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.025,
                                                ),

                                                InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                      settingTap = !settingTap;
                                                    });
                                                    if(settingTap == true){
                                                      print(settingTap);
                                                      SizedBox(
                                                        height: Get.height * 0.08,
                                                        //width: Get.width * 0.8,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                                            padding: const EdgeInsets.all(0), // Set padding to 0 to allow gradient to cover the entire button
                                                          ),
                                                          onPressed: () {},
                                                          child:
                                                          Ink(
                                                            decoration: BoxDecoration(
                                                              gradient: const LinearGradient(
                                                                colors: [
                                                                  Color(0xFF4D6FED),//
                                                                  Color(0xFF56B8F6),
                                                                ],
                                                                begin: Alignment.bottomCenter, // Start point of gradient
                                                                end: Alignment.topCenter, // End point of gradient
                                                              ),
                                                              borderRadius: BorderRadius.circular(30),
                                                            ),
                                                            child: Container(
                                                              alignment: AlignmentDirectional.centerStart,
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 14.0),
                                                                child:
                                                                Row(
                                                                  children: [
                                                                    Stack(
                                                                        children:[
                                                                          Positioned(
                                                                              top:7,
                                                                              left: 7,
                                                                              child: Image.asset('assets/images/settingicon2.png',color: AppColors.white,)),
                                                                          Image.asset('assets/images/settingicon1.png',color: AppColors.white,)
                                                                        ]
                                                                    ),
                                                                    SizedBox(
                                                                      width: Get.width * 0.045,
                                                                    ),
                                                                    Text(
                                                                        "Setting",
                                                                        style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white)
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    else{
                                                      null;
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Stack(
                                                          children:[
                                                            Positioned(
                                                                top:7,
                                                                left: 7,
                                                                child: Image.asset('assets/images/settingicon2.png',color: AppColors.white,)),
                                                            Image.asset('assets/images/settingicon1.png',color: AppColors.white,)
                                                          ]
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.045,
                                                      ),
                                                      Text(
                                                          "Setting",
                                                          style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white)
                                                      ),
                                                    ],
                                                  ),
                                                ),





                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: Image.asset('assets/images/Options.png'))
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Text(
                          "Congratulations, Example Company Pvt. Ltd. in accepted your Marketing Intern job application.",
                          style: Get.theme.textTheme!.bodySmall!
                              .copyWith(color: AppColors.white),
                        ),
                        SizedBox(
                          height: Get.height * 0.055,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyButton(
                              height: Get.height * 0.062,
                              width: Get.width * 0.35,
                              title: "LET'S CHAT", onTap1: () {
                              Get.to(() =>VideoAudioCallingPage(onSubmit: (String ) {  },));
                            },),
                            SizedBox(
                              height: Get.height * 0.062,
                              width: Get.width * 0.35,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  padding: const EdgeInsets.all(0), // Set padding to 0 to allow gradient to cover the entire button
                                ),
                                onPressed: () {},
                                child: Text(
                                    "VIEW DETAILS",
                                    style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.bold)
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.035,
                        ),
                        Divider() ,
                        SizedBox(
                          height: Get.height * 0.035,
                        ),
                      ],
                    );
                  })

          ),
        ),
      ),
    );
  }
}
