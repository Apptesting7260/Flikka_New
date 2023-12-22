import 'package:flikka/Job%20Seeker/SeekerForum/add_new_forum.dart';
import 'package:flikka/controllers/SeekerForumController/ForumAddCommentController.dart';
import 'package:flikka/controllers/SeekerForumController/ForumCommentsController.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../data/response/status.dart';
import '../../models/SeekerForumDataModel/SeekerForumDataModel.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';
import '../../widgets/app_colors.dart';

class ForumOnlyCommentPage extends StatefulWidget {
  final ForumDatum? forumData ;
  final String? industryID ;
  const ForumOnlyCommentPage({super.key, this.forumData, this.industryID});

  @override
  State<ForumOnlyCommentPage> createState() => _ForumOnlyCommentPageState();
}

class _ForumOnlyCommentPageState extends State<ForumOnlyCommentPage> {
  TextEditingController commentController = TextEditingController();
  ForumAddCommentController addCommentController = Get.put(ForumAddCommentController()) ;
  ForumCommentsController commentsController = Get.put(ForumCommentsController()) ;

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
  void initState() {
  commentsController.forumCommentsListApi(widget.industryID,forumID: widget.forumData?.id.toString()) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (commentsController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),);
        case Status.ERROR:
          if (commentsController.error.value ==
              'No internet') {
            return Scaffold(
              body: InterNetExceptionWidget(
                onPress: () {
                  commentsController.forumCommentsListApi(widget.industryID,forumID:widget.forumData?.id.toString()) ;
                },
              ),);
          } else if (commentsController.error.value == 'Request Time out') {
            return Scaffold(body: RequestTimeoutWidget(onPress: () {
              commentsController.forumCommentsListApi(widget.industryID,forumID: widget.forumData?.id.toString()) ;
            }),);
          } else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              commentsController.forumCommentsListApi(widget.industryID,forumID: widget.forumData?.id.toString()) ;
            }),);
          }
        case Status.COMPLETED:
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: () {
                Get.back();
              }, icon: Image.asset("assets/images/icon_back_blue.png",)),
              title:  Text("Forum", style: Get.theme.textTheme.displayLarge),
              toolbarHeight: 70,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Column(
                children: [

                  // Row(
                  //   children: [
                  //     SizedBox(height: Get.height * .01,),
                  //     GestureDetector(
                  //         onTap: () {
                  //           Get.back();
                  //         },
                  //         child: Image.asset("assets/images/icon_back_blue.png",
                  //           height: Get.height * .055,)),
                  //     SizedBox(width: Get.width * .04,),
                  //     Text("Forum", style: Get.theme.textTheme.displayLarge),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Container(
                  //         padding: EdgeInsets.symmetric(horizontal: Get.width*.05,vertical: Get.height*.008),
                  //         decoration: BoxDecoration(
                  //           color: const Color(0xff373737),
                  //           borderRadius: BorderRadius.circular(33.0),
                  //         ),
                  //         child: Row(
                  //           children: [
                  //             Icon(Icons.search, color: Color(0xff56B8F6),size: 30,),
                  //             SizedBox(width: Get.width*.03),
                  //             Expanded(
                  //               child: TextFormField(
                  //                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF),fontSize: 19),
                  //                 onChanged: (query){
                  //                   // filterPositionNames(query);
                  //                 },
                  //                 decoration: InputDecoration(
                  //                   hintText: 'Search',
                  //                   hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),
                  //                   border: InputBorder.none,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: Get.width * 0.015,
                  //     ),
                  //     Container(
                  //         height: Get.height*0.06,
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             Get.to(()=>AddNewForum());
                  //           },
                  //             child: Image.asset('assets/images/icon_add_form.png',fit: BoxFit.cover,))),
                  //   ],
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff353535),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(widget.forumData?.seekerImg ?? "",),
                                  // 'https://images.pexels.com/photos/3764119/pexels-photo-3764119.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        SizedBox( width: Get.width *.5,
                                          child: Text(
                                            widget.forumData?.title ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(color: AppColors.white),
                                            softWrap: true,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.005,
                                        ),
                                        Text(
                                         widget.forumData?.seekerName ?? "No data",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: AppColors
                                              .ratingcommenttextcolor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.035,
                          ),
                          HtmlWidget( widget.forumData?.titleDescription ?? "No data",
                            textStyle: Theme
                                .of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                              color: AppColors.ratingcommenttextcolor,
                              letterSpacing: 0.01,
                            ),
                          ),
                          // SizedBox(
                          //   height: Get.height * 0.025,
                          // ),
                          // Row(
                          //   children: [
                          //     Row(
                          //       children: [
                          //         Image.asset("assets/images/icon_watch.png",
                          //           height: Get.height * .02,),
                          //         SizedBox(width: Get.width * .015,),
                          //         Text("10:20 PM",
                          //           style: Get.theme.textTheme.bodySmall!
                          //               .copyWith(color: Color(0xffAFAFAF),
                          //               fontSize: 10),),
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       width: Get.width * 0.035,
                          //     ),
                          //     Row(
                          //       children: [
                          //         Image.asset("assets/images/icon_calendar.png",
                          //           height: Get.height * .02,),
                          //         SizedBox(width: Get.width * .015,),
                          //         Text("20 Mar, 2023",
                          //           style: Get.theme.textTheme.bodySmall!
                          //               .copyWith(color: Color(0xffAFAFAF),
                          //               fontSize: 10),),
                          //       ],
                          //     ),
                          //
                          //   ],
                          // ),
                          SizedBox(
                            height: Get.height * 0.005,
                          ),
                          const Divider(thickness: 0.5, color: Color(0xffCFCFCF),),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
                          Text("${commentsController.commentsData.value.seekerComment?.length} Comment", style: Get.theme.textTheme.titleSmall!
                              .copyWith(color: AppColors.white),),
                          SizedBox(
                            height: Get.height * .01,
                          ),
      commentsController.commentsData.value.seekerComment == null || commentsController.commentsData.value.seekerComment?.length == 0 ?
                          const Text("No Comments") :
                          ListView.builder(
                            shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: commentsController.commentsData.value.seekerComment?.length,
                              itemBuilder: (context, index) {
                                var data = commentsController.commentsData.value.seekerComment?[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: Get.height * .01),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(data?.img ?? ""),
                                    ),
                                    title: RichText(text: TextSpan(
                                        text: data?.name ?? "", style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontSize: 13),
                                        // children: [
                                        //   TextSpan(text: (data?.comment) ?? "",
                                        //       style: Theme
                                        //           .of(context)
                                        //           .textTheme
                                        //           .labelLarge
                                        //           ?.copyWith(
                                        //           fontWeight: FontWeight.w400,
                                        //           color: Color(0xffCFCFCF)))
                                        // ]
                                    ),),
                                    subtitle: HtmlWidget(data?.comment ?? "" , textStyle: Theme.of(context).textTheme
                                        .labelLarge?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xffCFCFCF)),),
                                    // subtitle: Row(
                                    //   children: [
                                    //     Text("3 hrs ago", style: Theme
                                    //         .of(context)
                                    //         .textTheme
                                    //         .labelLarge
                                    //         ?.copyWith(
                                    //         fontWeight: FontWeight.w400,
                                    //         color: Color(0xffCFCFCF)),),
                                    //     SizedBox(width: Get.width * .04,),
                                    //     Text("Reply", style: Theme
                                    //         .of(context)
                                    //         .textTheme
                                    //         .labelLarge
                                    //         ?.copyWith(fontSize: 10,
                                    //         fontWeight: FontWeight.w700,
                                    //         color: Color(0xffFFFFFF)),)
                                    //   ],
                                    // ),
                                  ),
                                );
                                // return Padding(
                                //   padding: const EdgeInsets.only(bottom: 10.0),
                                //   child: Row(
                                //     children: [
                                //       CircleAvatar(
                                //         radius: 30,
                                //         backgroundImage: NetworkImage('https://images.pexels.com/photos/3764119/pexels-photo-3764119.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',),
                                //       ),
                                //       Column(
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.only(left: 10),
                                //             child: Column(
                                //               crossAxisAlignment: CrossAxisAlignment.start,
                                //               children: [
                                //                 Text(
                                //                   "Lorem Ipsum is simply",
                                //                   style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.white),softWrap: true,
                                //                 ),
                                //                 SizedBox(
                                //                   height: Get.height * 0.005,
                                //                 ),
                                //                 Text(
                                //                   "Jessica Parker",
                                //                   style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.ratingcommenttextcolor),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ],
                                //       )
                                //     ],
                                //   ),
                                // );
                              }),
                          SizedBox(
                            height: Get.height * .01,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: commentController,
                                  style: const TextStyle(color: AppColors.white),
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 18),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              35),
                                          borderSide: const BorderSide(
                                              color: Color(0xff454545))
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              35),
                                          borderSide: const BorderSide(
                                              color: Color(0xff454545))
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xff454545),
                                      hintStyle: Get.theme.textTheme.bodyMedium,
                                      hintText: 'Type...'
                                  ),
                                ),
                              ),
                              SizedBox(width: Get.width * .025,),
                              GestureDetector(
                                  onTap: () {
                                    if (commentController.text.isEmpty) {}
                                    else {
                                      CommonFunctions.showLoadingDialog(context, "Posting...") ;
                                      addCommentController.seekerAddComment(
                                          context, widget.forumData?.id.toString(),
                                          commentController.text , widget.industryID);
                                      commentController.clear() ;
                                    }
                                  },
                                  child: Image.asset(
                                    "assets/images/icon_Send_msg.png",
                                    height: Get.height * .055,))
                            ],
                          ),
                          SizedBox(
                            height: Get.height * .08,
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
      }
    }
    );
  }

}


