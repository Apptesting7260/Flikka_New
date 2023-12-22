import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TakenPoolCandidatePfl extends StatefulWidget {
  const TakenPoolCandidatePfl({Key? key}) : super(key: key);


  @override
  State<TakenPoolCandidatePfl> createState() => _TakenPoolCandidatePflState();
}

class _TakenPoolCandidatePflState extends State<TakenPoolCandidatePfl> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        Stack(
            children:[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff2386C7), Color(0xff4D6FED)
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
                      SizedBox(height: Get.height*0.015,),
                      Text("Jessica Parker, 23",style: Get.theme.textTheme.displayLarge),
                      SizedBox(height: Get.height*0.005,),
                      Text("California, USA",style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white)),
                      SizedBox(height: Get.height*0.015,),
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
                      SizedBox(height: Get.height*0.035,),
                      SizedBox(
                        height: Get.height*0.072,
                        width: Get.width*0.69,
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
                initialChildSize: 0.5, // half screen
                minChildSize: 0.4, // half screen
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

                                          child: SvgPicture.asset('assets/images/experisvg.svg')),
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
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: Get.height*0.065,
                                            child: MyButton(onTap1: () {}, title: 'ACCEPT'),
                                          ),
                                        ),
                                        SizedBox(width: 20), // Adding spacing between buttons
                                        Expanded(
                                          child: SizedBox(
                                            height: Get.height*0.065,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: AppColors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(60.0),
                                                  )
                                              ),
                                              onPressed: () {},
                                              child: Text('REJECT',style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700,color: AppColors.black),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: Get.height*0.025,),
                                  SizedBox(
                                    height: Get.height*0.065,
                                    width: Get.width,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            side: BorderSide(color: Colors.white),
                                            backgroundColor: AppColors.black,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50)
                                            )
                                        ),
                                        onPressed: (){},
                                        child: Text("TAKEN POOL",style: Get.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),)),
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
      ),
    );
  }

}


