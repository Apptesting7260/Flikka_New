import 'package:flikka/Job%20Recruiter/bottom_bar/tab_bar.dart';
import 'package:flikka/Job%20Seeker/SeekerChatMessage/video_calling_and_chatting_page.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecruiterMessagePage extends StatefulWidget {
  const RecruiterMessagePage({super.key});

  @override
  State<RecruiterMessagePage> createState() => _RecruiterMessagePageState();
}

class _RecruiterMessagePageState extends State<RecruiterMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Text("Message",style: Get.theme.textTheme.displayLarge),
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: InkWell(
                onTap: (){
                  Get.back() ;
                  Get.offAll(TabScreenEmployer(index: 0));
                },
                child: Image.asset('assets/images/icon_back_blue.png')),
          ),
          elevation: 0,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 8.0),
          //     child: Row(
          //       children: [
          //         IconButton(constraints:BoxConstraints(),padding:EdgeInsets.zero,onPressed: (){}, icon: Image.asset('assets/images/editicon.png'),),
          //         IconButton(constraints:BoxConstraints(),padding:EdgeInsets.zero,onPressed: (){}, icon: Image.asset('assets/images/Options.png'),)
          //       ],
          //     ),
          //   )
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(28),
              //       color: Color(0xff373737)
              //   ),
              //   height: Get.height*0.08,
              //
              //   child:
              //   TextFormField(
              //     decoration: InputDecoration(
              //         contentPadding: EdgeInsets.only(top: 15),
              //         enabledBorder: InputBorder.none,
              //         focusedBorder: InputBorder.none,
              //         prefixIcon: Image.asset('assets/images/searchicon.png'),
              //         hintText: 'Search',
              //         hintStyle: TextStyle(
              //           color: Color(0xffCFCFCF),
              //         )
              //     ),
              //     //kkkkkkkkkkkkkkkkkkkkkkkkk2222222
              //
              //   ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width*.05,vertical: Get.height*.006),
                decoration: BoxDecoration(
                  color: Color(0xff373737),
                  borderRadius: BorderRadius.circular(33.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: AppColors.blueThemeColor,size: 30,),
                    SizedBox(width: Get.width*.03),
                    Expanded(
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF),fontSize: 19),
                        onChanged: (query){
                          // filterPositionNames(query);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height*0.03,),
              //save prost first navi
              Expanded(
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context,index){
                      return Padding(
                        padding:  EdgeInsets.symmetric(vertical: Get.height*.01),
                        child: GestureDetector(
                          onTap: (){
                            Get.to(VideoAudioCallingPage(onSubmit: (String ) {  },));
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 26,
                              backgroundImage:AssetImage('assets/images/icon_message_profile.png'),

                            ),
                            title: Text("Andy Robertson",style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white)),
                            subtitle:  Text("Oh yes, please send your CV/Res...",style:Get.theme.textTheme.bodySmall!.copyWith(color: Colors.blue)),
                            trailing: Column(
                              children: [
                                SizedBox(height: Get.height*0.015,),
                                Text("5m ago",style: Get.theme.textTheme.titleSmall!.copyWith(color: Color(0xffCFCFCF))),
                                SizedBox(height: Get.height*0.005,),
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.blue,
                                  child: Text("2",style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white,fontSize: 10)),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        )
    );
  }
}