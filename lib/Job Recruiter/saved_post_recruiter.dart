import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/app_colors.dart';
import '../Job Seeker/SeekerHome/home_swiper_find_job_widget.dart';

class SavedPostRecuiter extends StatefulWidget {
  const SavedPostRecuiter({super.key});

  @override
  State<SavedPostRecuiter> createState() => _SavedPostRecuiterState();
}

class _SavedPostRecuiterState extends State<SavedPostRecuiter> {

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Define custom dialog dimensions
        final double dialogWidth = 100.0;
        final double dialogHeight = 100.0;

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(18),bottomLeft: Radius.circular(18),bottomRight: Radius.circular(18))),
          // title: Text('Dialog Title'),
          content: Container(
            width: dialogWidth,
            height: dialogHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Unsaved',style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffFFFFFF)),),
                Divider(
                  height: 30,
                  color: Color(0xffFFFFFF),
                  thickness: 0.3,
                  indent : 0,
                  endIndent : 16,
                ),
                Text('Delete',style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffFFFFFF)),),
              ],
            ),
          ),
        );
      },
    );
  }

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
  bool selectedFav = false;
  Color buttonColor = AppColors.ratingcommenttextcolor;

  void toggleFavorite() {
    setState(() {
      selectedFav = !selectedFav;
      buttonColor = selectedFav ? AppColors.red : AppColors.ratingcommenttextcolor;
    });
  }

  TextEditingController commentController = TextEditingController();
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
              child: Image.asset('assets/images/icon_back_blue.png',height: Get.height*.04,)),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text("Saved Post",style: Get.theme.textTheme.displayLarge),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15,top: 20),
            child: Text("Delete All",style: Get.theme.textTheme.bodyLarge!.copyWith(color: Colors.blue)),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context,index){
            return
              Column(
                children: [

                  // Padding(
                  //   padding:  EdgeInsets.symmetric(horizontal: Get.width*.05),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           GestureDetector(
                  //               onTap: () {
                  //                 Get.back();
                  //               },
                  //               child: Image.asset('assets/images/icon_back_blue.png',height: Get.height*.055,)),
                  //           SizedBox(width: Get.width*.04,),
                  //           Text("Saved Post",style: Get.theme.textTheme.displayLarge),
                  //         ],
                  //       ),
                  //       Text("Delete All",style: Get.theme.textTheme.bodyLarge!.copyWith(color: Colors.blue)),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: Get.height*.03,),
                  Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*.05),
                      child:
                      Container(
                        decoration: BoxDecoration(
                            // color: AppColors.blackdown,
                          color: Color(0xff353535),
                            borderRadius: BorderRadius.circular(34)
                        ),
                        height: Get.height,
                        width: Get.width,
                        child: Stack(
                          children: [
                            //*************** for swiper image **************
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26)
                              ),
                              width: Get.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/_iconuser_profile.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            //*************** for 50% match **************
                            Positioned(
                              right: 20,
                              top: 10,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: AppColors.white, width: 2)),
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
                                              radius: 30,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text('50%',
                                                        style: Get.theme.textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                            color:
                                                            AppColors.white)),
                                                    Text('match',
                                                        style: Get.theme.textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                            color:
                                                            AppColors.white,
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
                            //*************** for bookmarks **************
                            Positioned(
                              left: 12,
                              top: 15,
                              child:Stack(
                                children: [
                                  Image.asset("assets/images/icon_Save_post.png",height: Get.height*.043,),
                                ],
                              ),
                            ),
                            //*************** for marketing intern text  **************
                            Positioned(
                              //height: Get.height / 2.5-Get.height*0.12 ,
                              bottom: Get.height*0.05,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: Get.height*.45,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // color: AppColors.blackdown,
                                  color: Color(0xff353535),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(22),topRight: Radius.circular(22)),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: Get.height*.02,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Jessica Parker",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          softWrap: true,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _showDialog(context);
                                          },
                                            child: Icon(Icons.more_vert,color: Color(0xffCFCFCF),size: 26,))
                                      ],
                                    ),
                                    Text("Marketing Intern",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500,color: Color(0xffCFCFCF)),),
                                   // SizedBox(height: Get.height*.002,),
                                    // Text(
                                    //   "Software engineer ",
                                    //   style: Theme.of(context)
                                    //       .textTheme
                                    //       .bodySmall?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w600)
                                    // ),
                                    SizedBox(height: Get.height*.002,),
                                    Text(
                                      "California, USA",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                          color: AppColors
                                              .ratingcommenttextcolor),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.03,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset("assets/images/icon work experience.png",height: Get.height*.03,),
                                        SizedBox(width: Get.width*.03,),
                                        Text("Work experience",style: Theme.of(context).textTheme.titleSmall,),

                                      ],
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: Get.width*.09),
                                      child: Text("4 Years",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Color(0xffCFCFCF)),),
                                    ),
                                    SizedBox(height: Get.height*.03,),
                                    Row(
                                      children: [
                                        Image.asset("assets/images/icon education.png",height: Get.height*.04,),
                                        SizedBox(width: Get.width*.03,),
                                        Text("Education",style: Theme.of(context).textTheme.titleSmall,),
                                      ],
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: Get.width*.09),
                                      child: Text("University of Oxford",style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w400),),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: Get.width*.09),
                                      child: Text("Sep 2010 - Aug 2013 . 5 Years",style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w400),),
                                    ),
                                    SizedBox(height: Get.height*.03,),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Align(
                                alignment: AlignmentDirectional.bottomCenter,
                                child: Container(
                                  height: Get.height*.09,
                                  decoration: BoxDecoration(
                                    // color: Colors.grey[900],
                                    color: Color(0xff3F3F3F),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(22)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () => toggleFavorite(),
                                              icon: selectedFav == false
                                                  ? SvgPicture.asset(
                                                'assets/images/likesvg.svg',width: Get.width*0.027,height: Get.height*0.027,
                                                color: buttonColor,
                                              )
                                                  : Icon(
                                                Icons.favorite_rounded,
                                                color: AppColors.red,
                                              )),
                                          Text("12",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                  color: AppColors.white, fontSize: 14)),
                                          SizedBox(
                                            width: Get.width * 0.04,
                                          ),

                                          //*************************

                                          IconButton(
                                            onPressed: () {
                                              showCommentDialog();
                                            },
                                            icon: SvgPicture.asset('assets/images/commentsvg.svg'),
                                          ),
                                          Text("10",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                  color: AppColors.white, fontSize: 14)),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 14.0),
                                        child: Row(
                                          children: [
                                            Image.asset("assets/images/icon_person.png",height: Get.height*.035,),
                                        IconButton(
                                          onPressed: text.isEmpty &&
                                              imagePaths.isEmpty &&
                                              uri.isEmpty
                                              ? null
                                              : () => _onShare(context),
                                          icon: SvgPicture.asset(
                                            'assets/images/sharesvg.svg',height: Get.height*.035,
                                          ),
                                        ),
                                        Text("2",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                color: AppColors.white, fontSize: 18)),
                                          ],
                                        ),
                                      )
                                      // Padding(
                                      //   padding: const EdgeInsets.only(right: 14.0),
                                      //   child: Row(
                                      //     children: [
                                      //       Stack(
                                      //           children: [
                                      //             CircleAvatar(
                                      //               backgroundColor: Color(0xff56B8F6),
                                      //               radius: 17,
                                      //               child: Image.asset(
                                      //                 'assets/images/personicons.png',
                                      //               ),
                                      //               // Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.ratingcommenttextcolor,)
                                      //             ),
                                      //             SvgPicture.asset('assets/images/personsvg22.svg')
                                      //           ]
                                      //       ),
                                      //       IconButton(
                                      //         onPressed: text.isEmpty &&
                                      //             imagePaths.isEmpty &&
                                      //             uri.isEmpty
                                      //             ? null
                                      //             : () => _onShare(context),
                                      //         icon: SvgPicture.asset(
                                      //           'assets/images/sharesvg.svg',
                                      //         ),
                                      //       ),
                                      //       Text("2",
                                      //           style: Theme.of(context)
                                      //               .textTheme
                                      //               .bodySmall!
                                      //               .copyWith(
                                      //               color: AppColors.white, fontSize: 14)),
                                      //     ],
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                ],
              );

          }),
    );
  }
  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    if (uri.isNotEmpty) {
      await Share.shareUri(Uri.parse(uri));
    } else if (imagePaths.isNotEmpty) {
      final files = <XFile>[];
      for (var i = 0; i < imagePaths.length; i++) {
        files.add(XFile(imagePaths[i], name: imageNames[i]));
      }
      await Share.shareXFiles(files,
          text: text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }
}
