import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CandidateProfile extends StatefulWidget {
  const CandidateProfile({Key? key}) : super(key: key);


  @override
  State<CandidateProfile> createState() => _CandidateProfileState();
}

class _CandidateProfileState extends State<CandidateProfile> {

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
    return Scaffold(
      // appBar: AppBar(
      //
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 18.0),
      //     child: InkWell(
      //         onTap: (){
      //           Get.back();
      //         },
      //         child: SvgPicture.asset('assets/images/backiconsvg.svg')),
      //   ),
      //   elevation: 0,
      //   backgroundColor: Color(0xff56B8F6 ),
      //   title:
      //   Text("Jessica Parker",style: Get.theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w700)),
      //
      // ),
      body:
      Stack(
        children:[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF56B8F6),
                  Color(0xFF4D6FED),
                ],
                begin: Alignment.topCenter, // Start from the top center
                end: Alignment.bottomCenter, // End at the bottom center
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Row(
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
                  ),
                  SizedBox(height: Get.height*0.055,),
                  Column(
                    children: [
                      Stack(
                          children: [
                            CircleAvatar(
                              radius:40,
                              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1581668181500-08c6a6e006f7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80'),
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
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFF56B8F6),
                                                Color(0xFF4D6FED),
                                              ],
                                              begin: Alignment
                                                  .topCenter, // Start from the top center
                                              end: Alignment
                                                  .bottomCenter, // End at the bottom center
                                            ),
                                          ),
                                          child: CircleAvatar(
                                              radius: 22,
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
                  Text("Jessica Parker, 23",style: Get.theme.textTheme.displayLarge),
                  Text("California, USA",style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white)),
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
                  SizedBox(
                    height: Get.height*0.082,
                    width: Get.width*0.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white
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
          DraggableScrollableSheet(
            initialChildSize: 0.5, // half screen
            minChildSize: 0.5, // half screen
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
                          //height: Get.height,
                          //width: Get.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Jessica Parker, 23",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          softWrap: true,
                                        ),
                                        Text(
                                          "California, USA",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                              color: AppColors
                                                  .ratingcommenttextcolor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            value: 0.8,
                                            strokeWidth: 6,

                                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff56B8F6)),
                                            backgroundColor: AppColors.ratingcommentfillcolor, // Background color
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "80%",
                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                    color: AppColors.white,fontWeight: FontWeight.w700
                                                ),
                                              ),
                                              Text(
                                                "Profile",
                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                    color: AppColors.white,
                                                    fontSize: 8,fontWeight: FontWeight.w400
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height*0.04,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(

                                          child: SvgPicture.asset('assets/images/aboutsvg.svg')),
                                      SizedBox(width: Get.width*0.02,),
                                      Text('About me',style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white),),
                                    ],
                                  ),
                                  InkWell(
                                      onTap:(){
                                        aboutsection();
                                      },
                                      child: Image.asset('assets/images/editicon2.png'))
                                ],
                              ),
                              SizedBox(height: Get.height*0.02,),
                              Divider(
                                thickness: 0.2,color: AppColors.white,
                              ),
                              Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                    color: AppColors
                                        .ratingcommenttextcolor),
                              ),

                              //********************* for work ex ***************************
                              SizedBox(height: Get.height*0.04,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(

                                          child: SvgPicture.asset('assets/images/experisvg.svg')),
                                      SizedBox(width: Get.width*0.02,),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Text('Work experience',style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white),),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          isWork = !isWork;
                                        });
                                      },
                                      child: Image.asset('assets/images/addicononjobre.png'))
                                ],
                              ),
                              SizedBox(height: Get.height*0.02,),
                              Divider(
                                thickness: 0.2,color: AppColors.white,
                              ),
                              if(isWork==true)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Manager',style: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),
                                        InkWell(
                                            onTap:(){
                                              workexperience();
                                            },
                                            child: Image.asset('assets/images/editicon2.png'))

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
                                        child: Text('Education',style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white),),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          isEducation = !isEducation;
                                        });
                                      },
                                      child: Image.asset('assets/images/addicononjobre.png'))
                                ],
                              ),
                              SizedBox(height: Get.height*0.02,),
                              Divider(
                                thickness: 0.2,color: AppColors.white,
                              ),
                              if(isEducation==true)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Information Technology',style: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),
                                        InkWell(
                                            onTap:(){
                                              education();
                                            },
                                            child: Image.asset('assets/images/editicon2.png'))

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
                                  InkWell(
                                      onTap:(){
                                        skill();
                                      },
                                      child: Image.asset('assets/images/editicon2.png'))
                                ],
                              ),
                              SizedBox(height: Get.height*0.02,),
                              Divider(
                                thickness: 0.2,color: AppColors.white,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width*0.35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.blackdown,
                                    ),
                                    padding: EdgeInsets.all(15),

                                    child: Center(
                                      child:
                                      Text('communication',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),),
                                    ),
                                  ),
                                  SizedBox(width: Get.width*0.04,),
                                  Container(
                                    width: Get.width*0.35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.blackdown,
                                    ),
                                    padding: EdgeInsets.all(15),

                                    child: Center(
                                      child:
                                      Text('negotiation',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height*0.04,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width*0.45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.blackdown,
                                    ),
                                    padding: EdgeInsets.all(15),

                                    child: Center(
                                      child:
                                      Text('public speaking',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),),
                                    ),
                                  ),
                                  SizedBox(width: Get.width*0.04,),
                                  Container(
                                    width: Get.width*0.35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.blackdown,
                                    ),
                                    padding: EdgeInsets.all(15),

                                    child: Center(
                                      child:
                                      Text('analysis thinking',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w400),),
                                    ),
                                  ),
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
                                        Text('Language',style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white),),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                      onTap:(){
                                        language();
                                      },
                                      child: Image.asset('assets/images/editicon2.png'))
                                ],
                              ),
                              SizedBox(height: Get.height*0.02,),
                              Divider(
                                thickness: 0.2,color: AppColors.white,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width*0.25,
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
                                  SizedBox(width: Get.width*0.04,),
                                  Container(
                                    width: Get.width*0.25,
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
                                  SizedBox(width: Get.width*0.03,),
                                  Container(
                                    width: Get.width*0.25,
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
                              SizedBox(height: Get.height*0.03,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width*0.25,
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
                                  SizedBox(width: Get.width*0.025,),
                                  Container(
                                    width: Get.width*0.25,
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
                                          child: SvgPicture.asset('assets/images/Educationsvg.svg')),
                                      SizedBox(width: Get.width*0.02,),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6.0),
                                        child: Text('appreciation',style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white),),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                      onTap:(){
                                        setState(() {
                                          isAppreciation =!isAppreciation;
                                        });
                                      },
                                      child: Image.asset('assets/images/addicononjobre.png'))
                                ],
                              ),
                              SizedBox(height: Get.height*0.02,),
                              Divider(
                                thickness: 0.2,color: AppColors.white,
                              ),
                              if(isAppreciation==true)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Wireless Symposium (RWS)',style: Get.theme.textTheme.bodyMedium!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),),
                                        InkWell(
                                            onTap:(){
                                              appreciation();
                                            },
                                            child: Image.asset('assets/images/editicon2.png'))

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

                              //********************* for resumesvg ***************************
                              SizedBox(height: Get.height*0.04,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                          child: SvgPicture.asset('assets/images/resumesvg.svg')),
                                      SizedBox(width: Get.width*0.02,),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6.0),
                                        child: Text('Resume',style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white),),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                      onTap:(){
                                        setState(() {
                                          isResume =!isResume;
                                        });
                                      },
                                      child: Image.asset('assets/images/addicononjobre.png'))
                                ],
                              ),
                              SizedBox(height: Get.height*0.02,),
                              Divider(
                                thickness: 0.2,color: AppColors.white,
                              ),
                              if(isResume == true)
                                ListTile(
                                  leading: SvgPicture.asset('assets/images/PDF.svg'),
                                  title: Text('Jamet kudasi - CV - UI/UX Designer',style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.w500),),
                                  subtitle: Text(
                                    "867 Kb .14 Feb 2022 at 11:30 am",style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                      color: AppColors
                                          .ratingcommenttextcolor,fontWeight: FontWeight.w400),
                                  ),
                                  trailing: SvgPicture.asset('assets/images/deletsvg.svg'),
                                  //SvgPicture.asset('assets/images/deletsvg.svg'),
                                )

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
    );
  }

}


