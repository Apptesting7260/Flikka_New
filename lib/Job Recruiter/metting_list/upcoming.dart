import 'package:flikka/Job%20Seeker/SeekerChatMessage/videocalling_live_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/app_colors.dart';
import '../../widgets/my_button.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
backgroundColor: Color(0xff000),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height*.028),
                    child: Container(
                      height: Get.height*.45,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Color(0xff353535)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width*.06),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Get.height*.014,),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              minVerticalPadding: 12,
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundImage: AssetImage("assets/images/icon_jesika.png",),
                              ),
                              title: Text("Jessica Parker",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Color(0xffFFFFFF)),),
                              subtitle:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Software engineer ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w600)
                                  ),
                                  SizedBox(height: Get.height*.003,),
                                  Text("California, USA",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                                ],
                              ),
                              trailing: Image.asset("assets/images/Edit.png",height: Get.height*.030,),
                            ),
                            SizedBox(height: Get.height*.015,),
                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                            SizedBox(height: Get.height*.03,),
                            Row(
                              children: [
                                Image.asset("assets/images/icon_calendar.png",height: Get.height*.026,color: Color(0xff56B8F6),),
                                SizedBox(width: Get.width*.02,),
                                Text("12, January 2022",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffFFFFFF)),),
                              ],
                            ),
                            SizedBox(height: Get.height*.02,),
                            Row(
                              children: [
                                Image.asset("assets/images/icon_watch.png",height: Get.height*.026,color: Color(0xff56B8F6),),
                                SizedBox(width: Get.width*.02,),
                                Text("11: 30 PM",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                              ],
                            ),
                            SizedBox(height: Get.height*.044,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyButton(
                                  height: Get.height*.068,
                                  width: Get.width*.38,
                                  title: "START", onTap1: () {
Get.to(()=>VideoCallingLivePage());
                                },),
                                SizedBox(
                                  height: Get.height*.068,
                                  width: Get.width * 0.38,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                      padding: EdgeInsets.all(0), // Set padding to 0 to allow gradient to cover the entire button
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                        "CANCEL",
                                        style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.black,fontWeight: FontWeight.bold)
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },),
              SizedBox(height: Get.height*.1,),
            ],
          ),
        ),
      ),
    ));
  }
}
