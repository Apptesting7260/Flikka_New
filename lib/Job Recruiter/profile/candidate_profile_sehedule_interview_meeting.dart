import 'package:flikka/Job%20Recruiter/Schedule_meeting_calendar/meeting_calendar.dart';
import 'package:flikka/Job%20Recruiter/metting_list/metting_list_tabbar.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class CandidateProfileseheduleMetting extends StatefulWidget {
  const CandidateProfileseheduleMetting({Key? key}) : super(key: key);


  @override
  State<CandidateProfileseheduleMetting> createState() => _CandidateProfileseheduleMettingState();
}

class _CandidateProfileseheduleMettingState extends State<CandidateProfileseheduleMetting> {

  String uri = '';
  //********************* for aboutsectionedition *************
  TextEditingController aboutsectionController = TextEditingController();
  void aboutsection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add more",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: aboutsectionController,
            decoration: InputDecoration(
              hintText: 'Write your summary profile',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //********************* for workexperience *************
  TextEditingController workexperienceController = TextEditingController();
  void workexperience() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add experience",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: workexperienceController,
            decoration: InputDecoration(
              hintText: 'your experience',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //********************* for education *************
  TextEditingController educationController = TextEditingController();
  void education() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add education",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: educationController,
            decoration: InputDecoration(
              hintText: 'Write your education',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //********************* for skill *************
  TextEditingController skillController = TextEditingController();
  void skill() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add skill",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: skillController,
            decoration: InputDecoration(
              hintText: 'Write your skill',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //********************* for language *************
  TextEditingController languageController = TextEditingController();
  void language() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add language",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: languageController,
            decoration: InputDecoration(
              hintText: 'Write your language',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //********************* for appreciation *************
  TextEditingController appreciationController = TextEditingController();
  void appreciation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add appreciation",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: appreciationController,
            decoration: InputDecoration(
              hintText: 'Write your appreciation',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  bool isWork = false;
  bool isEducation = false;
  bool isAppreciation = false;
  bool isResume = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        Stack(
            children:[
              Container(
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Color(0xff2386C7), Color(0xff4D6FED)
                  //   ],
                  //   begin: Alignment.topCenter, // Start from the top center
                  //   end: Alignment.bottomCenter, // End at the bottom center
                  // ),
                  color: AppColors.blueThemeColor
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                              onTap: (){
                                Get.back();
                              },
                              child: SvgPicture.asset('assets/images/backiconsvg.svg')),
                          SizedBox(width: Get.width*0.035,),
                          Text("Jessica Parker",style: Get.theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w700)),

                        ],
                      ),
                      SizedBox(height: Get.height*0.0395,),
                      Column(
                        children: [
                          Stack(
                              children: [
                                CircleAvatar(
                                  radius:48,
                                  backgroundImage: AssetImage("assets/images/_iconuser_profile.png"),
                                  //backgroundImage: NetworkImage('https://images.unsplash.com/photo-1581668181500-08c6a6e006f7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80'),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color: AppColors.white, width: 2)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                // gradient: LinearGradient(
                                                //   colors: [
                                                //     Color(0xFF56B8F6),
                                                //     Color(0xFF4D6FED),
                                                //   ],
                                                //   begin: Alignment
                                                //       .topCenter, // Start from the top center
                                                //   end: Alignment
                                                //       .bottomCenter, // End at the bottom center
                                                // ),
                                                color: AppColors.blueThemeColor
                                              ),
                                              child: CircleAvatar(
                                                  radius: 17,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('50%',
                                                            style: Get.theme.textTheme.bodySmall!
                                                                .copyWith(color: AppColors.white)),
                                                        Text('match',
                                                            style: Get.theme.textTheme.bodySmall!
                                                                .copyWith(
                                                                color: AppColors.white,
                                                                fontSize: 7)),
                                                      ],
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.transparent)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]
                          )
                        ],
                      ),
                      SizedBox(height: Get.height*.045,),
                      Text("Jessica Parker",style: Get.theme.textTheme.displayLarge),
                      Text(
                          "Software engineer ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall?.copyWith(color: Color(0xffFFFFFF),fontWeight: FontWeight.w600)
                      ),
                      SizedBox(height: Get.height*.003,),
                      // SizedBox(height: Get.height*0.01,),
                      Text("California, USA",style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white)),
                      SizedBox(height: Get.height*.03,),
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.white
                              ),
                              child: Row(
                                children: [
                                  IconButton(onPressed: (){},icon: Image.asset('assets/images/messagepng.png')),

                                ],
                              )
                          ),
                          SizedBox(width: Get.width*0.045,),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.white
                              ),
                              child: Row(
                                children: [
                                  IconButton(onPressed: (){},icon: Image.asset('assets/images/call.png',scale: 0.7,)),

                                ],
                              )
                          ),
                          SizedBox(width: Get.width*0.045,),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.white
                              ),
                              child: Row(
                                children: [
                                  IconButton(onPressed: (){},icon: Image.asset('assets/images/videocall.png',scale: 0.7)),

                                ],
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height*.03,),
                      SizedBox(
                        height: Get.height*0.078,
                        width: Get.width*0.75,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)
                          )
                          ),
                          onPressed: (){}, child: Text(
                          'AVAILABLE IMMEDIATELY',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,),
                        ),),
                      )
                    ],
                  ),
                ),
              ),
              //************** scrollable functionality *******************
              DraggableScrollableSheet(
                initialChildSize: 0.35, // half screen
                minChildSize: 0.35, // half screen
                maxChildSize: 1, // full screen
                builder: (BuildContext context, ScrollController scrollController) {
                  return
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35),
                        ),

                      ),
                      child: ListView(
                        controller: scrollController,
                        children: [
                          Container(
                              padding:EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                  color: AppColors.black,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                              ),

                              child: Column(
                                children: [
                                  //********************* for jessica  ***************************
                                      SizedBox(height: Get.height*.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                          child: SvgPicture.asset('assets/images/aboutsvg.svg')),
                                      SizedBox(width: Get.width*0.02,),
                                      Text(
                                        "About Jessica Parker",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                        softWrap: true,
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: Get.height*0.015,),
                                  Divider(
                                    thickness: 0.2,color: AppColors.white,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: [

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: Get.height*0.02,),
                                  Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                        color: Color(0xffCFCFCF)),
                                  ),

                                  //********************* for work ex ***************************
                                  SizedBox(height: Get.height*0.04,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(

                                          child: Image.asset('assets/images/icon work experience.png',color: AppColors.blueThemeColor,height: Get.height*.03,)),
                                      SizedBox(width: Get.width*0.02,),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Text('Work experience',style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.height*0.02,),
                                  Divider(
                                    thickness: 0.2,color: AppColors.white,
                                  ),
                                  SizedBox(height: Get.height*0.02,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Manager',style: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),


                                        ],
                                      ),
                                      SizedBox(height: Get.height*0.01,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Amazon Inc",style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color: AppColors
                                                  .ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "Jan 2015 - Feb 2022 5 Years",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                color: AppColors
                                                    .ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),


                                  //********************* for Education ***************************
                                  SizedBox(height: Get.height*0.04,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                              child: SvgPicture.asset('assets/images/Educationsvg.svg')),
                                          SizedBox(width: Get.width*0.02,),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 6.0),
                                            child: Text('Education',style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: Get.height*0.02,),
                                  Divider(
                                    thickness: 0.2,color: AppColors.white,
                                  ),
                                  SizedBox(height: Get.height*0.02,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Information Technology',style: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),

                                        ],
                                      ),
                                      SizedBox(height: Get.height*0.01,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "University of Oxford",style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color: AppColors
                                                  .ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "Jan 2015 - Feb 2022 5 Years",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                color: AppColors
                                                    .ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),


                                  //********************* for Skill ***************************
                                  SizedBox(height: Get.height*0.04,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                              child: SvgPicture.asset('assets/images/skillsvg.svg')),
                                          SizedBox(width: Get.width*0.02,),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child:
                                            Text('Skill',style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white),),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: Get.height*0.02,),
                                  Divider(
                                    thickness: 0.2,color: AppColors.white,
                                  ),
                                  SizedBox(height: Get.height*0.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppColors.blackdown,
                                        ),
                                        padding: EdgeInsets.all(15),

                                        child: Center(
                                          child:
                                          Text('Leadership',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),),
                                        ),
                                      ),
                                      SizedBox(width: Get.width*0.015,),
                                      Container(

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppColors.blackdown,
                                        ),
                                        padding: EdgeInsets.all(15),

                                        child: Center(
                                          child:
                                          Text('Teamwork',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),),
                                        ),
                                      ),
                                      SizedBox(width: Get.width*0.015,),
                                      Container(

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppColors.blackdown,
                                        ),
                                        padding: EdgeInsets.all(15),

                                        child: Center(
                                          child:
                                          Text('Visioner',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.height*0.015,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppColors.blackdown,
                                        ),
                                        padding: EdgeInsets.all(15),

                                        child: Center(
                                          child:
                                          Text('Target oriented',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),),
                                        ),
                                      ),
                                      SizedBox(width: Get.width*0.015,),
                                      Container(
                                        width: Get.width*0.35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppColors.blackdown,
                                        ),
                                        padding: EdgeInsets.all(15),

                                        child: Center(
                                          child:
                                          Text('Consistent',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),),
                                        ),
                                      ),
                                      SizedBox(width: Get.width*0.01),
                                      Text("+5 more..",style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),)
                                    ],
                                  ),

                                  //********************* for Language ***************************
                                  SizedBox(height: Get.height*0.04,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                              child: SvgPicture.asset('assets/images/languagesvg.svg')),
                                          SizedBox(width: Get.width*0.02,),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2.0),
                                            child:
                                            Text('Language',style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: Get.height*0.02,),
                                  Divider(
                                    thickness: 0.2,color: AppColors.white,
                                  ),
                                  SizedBox(height: Get.height*0.02,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppColors.blackdown,
                                        ),
                                        padding: EdgeInsets.all(15),

                                        child: Center(
                                          child:
                                          Text('English',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),),
                                        ),
                                      ),
                                      SizedBox(width: Get.width*0.015,),
                                      Container(

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppColors.blackdown,
                                        ),
                                        padding: EdgeInsets.all(15),

                                        child: Center(
                                          child:
                                          Text('German',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),),
                                        ),
                                      ),
                                      SizedBox(width: Get.width*0.015,),
                                      Container(

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppColors.blackdown,
                                        ),
                                        padding: EdgeInsets.all(15),

                                        child: Center(
                                          child:
                                          Text('Spanish',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.height*0.015,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppColors.blackdown,
                                        ),
                                        padding: EdgeInsets.all(15),

                                        child: Center(
                                          child:
                                          Text('Mandarin',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),),
                                        ),
                                      ),
                                      SizedBox(width: Get.width*0.015,),
                                      Container(

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppColors.blackdown,
                                        ),
                                        padding: EdgeInsets.all(15),

                                        child: Center(
                                          child:
                                          Text('Italy',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //********************* for appreciation ***************************
                                  SizedBox(height: Get.height*0.04,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                              child: SvgPicture.asset('assets/images/language.svg')),
                                          SizedBox(width: Get.width*0.02,),
                                          Text('Appreciation',style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),
                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: Get.height*0.02,),
                                  Divider(
                                    thickness: 0.2,color: AppColors.white,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Wireless Symposium (RWS)',style: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),

                                        ],
                                      ),
                                      SizedBox(height: Get.height*0.01,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Young Scientist",style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                              color: AppColors
                                                  .ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "2014",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                color: AppColors
                                                    .ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: Get.height*0.05,),
                                  MyButton(title: 'SCHEDULE MEETING',

                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                        color: AppColors
                                            .ratingcommenttextcolor,fontWeight: FontWeight.w700, ),
                                    onTap1: () {
                                      Get.to(()=>CalendarScreen());
                                    },
                                    // onTap1: () async {
                                    //   DateTime? dateTime = await showOmniDateTimePicker(
                                    //
                                    //
                                    //
                                    //     context: context,
                                    //     initialDate: DateTime.now(),
                                    //     firstDate:
                                    //     DateTime(1600).subtract(const Duration(days: 3652)),
                                    //     lastDate: DateTime.now().add(
                                    //       const Duration(days: 3652),
                                    //     ),
                                    //     // type: ,''
                                    //     is24HourMode: false,
                                    //     isShowSeconds: false,
                                    //     minutesInterval: 1,
                                    //     secondsInterval: 1,
                                    //     isForce2Digits: true,
                                    //     borderRadius: const BorderRadius.all(Radius.circular(16)),
                                    //     constraints: const BoxConstraints(
                                    //       maxWidth: 350,
                                    //       maxHeight: 650,
                                    //     ),
                                    //     transitionBuilder: (context, anim1, anim2, child) {
                                    //       return FadeTransition(
                                    //
                                    //         opacity: anim1.drive(
                                    //           Tween(
                                    //             begin: 0,
                                    //             end: 1,
                                    //           ),
                                    //         ),
                                    //         child: child,
                                    //       );
                                    //     },
                                    //     transitionDuration: const Duration(milliseconds: 200),
                                    //     barrierDismissible: true,
                                    //     selectableDayPredicate: (dateTime) {
                                    //
                                    //       // Disable 25th Feb 2023
                                    //       if (dateTime == DateTime(2023, 2, 25)) {
                                    //         return false;
                                    //       } else {
                                    //         return true;
                                    //       }
                                    //     },
                                    //   );
                                    //
                                    //   print("dateTime: $dateTime");
                                    //
                                    //  Get.to(()=>MettingListTabbar());
                                    //
                                    // },
                                  ),
                                  SizedBox(height: Get.height*.01,),
                                ],
                              )
                          ),

                        ],
                      ),
                    );
                },
              ),
            ]
        ),
      ),
    );
  }

}


