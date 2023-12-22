import 'package:flikka/Job%20Seeker/SeekerForum/add_new_forum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_colors.dart';
import 'forum_only_comment_page.dart';


class ForumWithViews extends StatefulWidget {
  const ForumWithViews({super.key});

  @override
  State<ForumWithViews> createState() => _ForumWithViewsState();
}

class _ForumWithViewsState extends State<ForumWithViews> {
  TextEditingController commentController = TextEditingController();
  String text = '';
  String subject = '';
  String uri = '';
  List<String> imageNames = [];
  List<String> imagePaths = [];
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add a Comment",style: Theme.of(context).textTheme.displayLarge,),
          content: TextField(
            style: TextStyle(
                color: AppColors.white,fontSize: 23
            ),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: commentController,
            decoration: InputDecoration(
              hintText: 'Write a comment...',
              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white,fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white,fontSize: 16),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Submit",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white,fontSize: 16),),
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   leading: Padding(
        //     padding: const EdgeInsets.only(left: 15.0),
        //     child: Image.asset('assets/images/backicon.png'),
        //   ),
        //   elevation: 0,
        //   backgroundColor: Colors.black,
        //   title: Text("Forum",style: Get.theme.textTheme.displayLarge),
        // ),
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
          child: Column(
            children: [
              SizedBox(height: Get.height*.02,),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                      child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.055,)),
                  SizedBox(width: Get.width*.04,),
                  Text("Forum",style: Get.theme.textTheme.displayLarge),
                ],
              ),
              SizedBox(height: Get.height*.04,),
              Row(
                children: [
                  Expanded(
                    child:   Container(
                      padding: EdgeInsets.symmetric(horizontal: Get.width*.05,vertical: Get.height*.008),
                      decoration: BoxDecoration(
                        color: Color(0xff373737),
                        borderRadius: BorderRadius.circular(33.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Color(0xff56B8F6),size: 30,),
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
                  ),
                  SizedBox(
                    width: Get.width * 0.015,
                  ),
                  Container(
                      height: Get.height*0.06,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(()=>AddNewForum());
                        },
                          child: Image.asset('assets/images/icon_add_form.png',fit: BoxFit.cover,))),
                ],
              ),
              SizedBox(
                height: Get.height * 0.035,
              ),
              //************* list *((((((((((((((((((((((((((((((((

              Expanded(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context,index){
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height*.02),
                    child: Stack(
                        children:[
                          GestureDetector(
                            onTap: () {
                              Get.to(()=> const ForumOnlyCommentPage());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff353535),
                                borderRadius:BorderRadius.circular(22),
                              ),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 7.0,top: 15),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage('https://images.pexels.com/photos/3764119/pexels-photo-3764119.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.035,
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Lorem Ipsum is simply",
                                                  style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.white),softWrap: true,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.005,
                                                ),
                                                Text(
                                                  "Jessica Parker",
                                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.ratingcommenttextcolor),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.03,
                                                ),

                                                Container(
                                                  width: Get.width*0.60,
                                                  child: Text(

                                                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
                                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                                    textAlign: TextAlign.justify,
                                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                        color: AppColors.ratingcommenttextcolor,letterSpacing: 0.01
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: Get.height * 0.15,
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
                                color: Color(0xff3F3F3F),
                              ),
                              height: 70,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/viewicon.png',scale: 0.7,),
                                      SizedBox(
                                        width: Get.width * 0.015,
                                      ),
                                      Text("24 Views",style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white),),
                                      SizedBox(
                                        width: Get.width * 0.075,
                                      ),
                                      InkWell(
                                          onTap:(){
                                            showCommentDialog();
                                          },
                                          child: Image.asset('assets/images/commenticons.png')),
                                      SizedBox(
                                        width: Get.width * 0.015,
                                      ),
                                      Text("56 Comments",style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                  );
                }),
              )

            ],
          ),
        ),
      ),
    );
  }

}
