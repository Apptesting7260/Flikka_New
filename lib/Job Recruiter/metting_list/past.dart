import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class Past extends StatefulWidget {
  const Past({super.key});

  @override
  State<Past> createState() => _PastState();
}

class _PastState extends State<Past> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xff000),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height*.022,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height*.03),
                child: Container(
                  height: Get.height*.35,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Color(0xff353535),
                      borderRadius: BorderRadius.circular(22)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
                    child: Column(
                      children: [
                        SizedBox(height: Get.height*.013,),
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding:  EdgeInsets.only(right: Get.width*.05),
                              //child: Icon(Icons.more_vert,color: Color(0xffCFCFCF),size: 25,),
                            )),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          minVerticalPadding: 15,
                          leading: CircleAvatar(
                            radius: 27,
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
                          trailing: Icon(Icons.more_vert,color: Color(0xffCFCFCF),size: 27,),
                        ),
                        SizedBox(height: Get.height*.024,),
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                        SizedBox(height: Get.height*.04,),
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
