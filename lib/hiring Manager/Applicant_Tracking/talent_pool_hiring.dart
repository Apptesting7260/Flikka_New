
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TalentPoolHiring extends StatefulWidget {
  const TalentPoolHiring({super.key});

  @override
  State<TalentPoolHiring> createState() => _TalentPoolHiringState();
}

class _TalentPoolHiringState extends State<TalentPoolHiring> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.height*.02,),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height*.027),
                      child: Container(
                        height: Get.height*.29,
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
                              SizedBox(height: Get.height*.013,),
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
                                    SizedBox(height: Get.height*.003,),
                                    Text(
                                        "Software engineer ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w600)
                                    ),
                                    SizedBox(height: Get.height*.003,),
                                    Text("California, USA",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                                    SizedBox(height: Get.height*.003,),
                                    Text(
                                        "TALENT POOL",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall?.copyWith(color: Color(0xffFFFFFF),fontWeight: FontWeight.w700)
                                    ),
                                  ],
                                ),
                                trailing: Icon(Icons.more_vert,color: Color(0xffCFCFCF),size: 26,),
                                //trailing: Image.asset("assets/images/Edit.png",height: Get.height*.028,),
                              ),
                              SizedBox(height: Get.height*.02,),
                              Center(
                                child: MyButton(title: "VIEW PROFILE", onTap1: () {

                                },),
                              )
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
      ),
    );
  }
}
