import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bottom_bar/tab_bar.dart';
import 'add_a_job_page_area.dart';


class CreateJobPost extends StatefulWidget {
  const CreateJobPost({super.key});

  @override
  State<CreateJobPost> createState() => _CreateJobPostState();
}

class _CreateJobPostState extends State<CreateJobPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GestureDetector(
              onTap: () {
                Get.offAll(() => TabScreenEmployer(index: 0,)) ;
              },
              child: Image.asset(
                "assets/images/icon_back_blue.png",
                height: Get.height * .02,
              )),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
             SizedBox(height: Get.height*.23,),
            Center(child: Image.asset("assets/images/icon_create_job_post.png",height: Get.height*.2,)),
            SizedBox(height: Get.height*.05,),
            Text("Create a job post",style: Theme.of(context).textTheme.labelMedium,),
            SizedBox(height: Get.height*.02,),
            Center(
              child: SizedBox(
                width: Get.width*.8,
                  child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",textAlign: TextAlign.center,style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w400),)),
            ),
            SizedBox(height: Get.height*.05,),
            Center(
              child: MyButton(
                width: Get.width*.75,
                title: "CREATE JOB", onTap1: () {
                    Get.to(()=>const AddAJobPage());
              },),
            )
          ],
        ),
      ),
    );
  }
}
