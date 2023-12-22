import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VideoAudioCallingPage extends StatefulWidget {
  final Function(String) onSubmit;
  const VideoAudioCallingPage({super.key, required this.onSubmit});

  @override
  State<VideoAudioCallingPage> createState() => _VideoAudioCallingPageState();
}

class _VideoAudioCallingPageState extends State<VideoAudioCallingPage> {

  //**********************************************
  final TextEditingController _commentController = TextEditingController();

  void _submitComment() {
    if (_commentController.text.isNotEmpty) {
      widget.onSubmit(_commentController.text);
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:  AppBar(
       backgroundColor: Colors.transparent, // set the background color as transparent if needed
       elevation: 0, // set elevation to 0 to remove the shadow

       title: Row(
         children: [
           IconButton(
             onPressed: () {
               Get.back();
             },
             icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
           ),
           Image.asset(
             'assets/images/firstlogomarketing.png',
             scale: 1,
           ),
           SizedBox(
             width: Get.width * 0.018,
           ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 "Example Comp...",
                 style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),
               ),
               SizedBox(
                 height: Get.height * 0.005,
               ),
               Row(
                 children: [
                   Image.asset('assets/images/liveimage.png'),
                   Text(
                     "Online",
                     style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white),
                   ),
                 ],
               ),
             ],
           ),
         ],
       ),

       actions: [
         Padding(
           padding: const EdgeInsets.only(right: 8.0),
           child: Row(
             children: [
               CircleAvatar(
                 backgroundColor: Colors.white,
                 radius: 15,
                 child: IconButton(
                   padding: EdgeInsets.only(top: 1),
                   onPressed: () {},
                   icon: Image.asset('assets/images/call.png'),
                 ),
               ),
               SizedBox(
                 width: Get.width * 0.018,
               ),
               // CircleAvatar(
               //   backgroundColor: Colors.white,
               //   radius: 15,
               //   child: IconButton(
               //       padding: EdgeInsets.only(top: 1),
               //       onPressed: (){
               //         // Get.to(() =>VideoCallingLivePage());
               //       }, icon: Image.asset('assets/images/videocall.png')),
               // ),
               SizedBox(
                 width: Get.width * 0.018,
               ),
               Padding(
                 padding: const EdgeInsets.only(right: 8.0),
                 child: Image.asset('assets/images/Options.png', color: AppColors.white),
               )
             ],
           ),
         ),
       ],
     ),

      body: SafeArea(
        child:
        Column(
          children: [
            SizedBox(height: Get.height*.035,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         IconButton(
            //             onPressed: (){
            //               Get.back();
            //             }, icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,)),
            //         Image.asset('assets/images/firstlogomarketing.png',scale: 1,),
            //         SizedBox(
            //           width: Get.width * 0.018,
            //         ),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               "Example Comp...",
            //               style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),
            //             ),
            //             SizedBox(
            //               height: Get.height * 0.005,
            //             ),
            //             Row(
            //               children: [
            //                 Image.asset('assets/images/liveimage.png'),
            //                 Text(
            //                   "Online",
            //                   style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //
            //       ],
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(right: 8.0),
            //       child: Row(
            //         children: [
            //           CircleAvatar(
            //             backgroundColor: Colors.white,
            //             radius: 15,
            //             child: IconButton(
            //                 padding: EdgeInsets.only(top: 1),
            //                 onPressed: (){}, icon: Image.asset('assets/images/call.png')),
            //           ),
            //           SizedBox(
            //             width: Get.width * 0.018,
            //           ),
            //           // CircleAvatar(
            //           //   backgroundColor: Colors.white,
            //           //   radius: 15,
            //           //   child: IconButton(
            //           //       padding: EdgeInsets.only(top: 1),
            //           //       onPressed: (){
            //           //         // Get.to(() =>VideoCallingLivePage());
            //           //       }, icon: Image.asset('assets/images/videocall.png')),
            //           // ),
            //           SizedBox(
            //             width: Get.width * 0.018,
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(right: 8.0),
            //             child: Image.asset('assets/images/Options.png',color: AppColors.white,),
            //           )
            //         ],
            //       ),
            //     )
            //   ],
            // ),
            // SizedBox(height: Get.height*.04,),
            Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30),)
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height*.04,),
                        Center(
                          child:Text("Today",style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white),),

                        ),
                        SizedBox(height: Get.height*.04,),
                        // ******************** other ******************
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Container(
                                  width: Get.width/2,
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF4D6FED),//
                                          Color(0xFF56B8F6),
                                        ],
                                        begin: Alignment.bottomCenter, // Start point of gradient
                                        end: Alignment.topCenter,),
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
                                  ),

                                  child: Center(
                                    child: Text("Hello sir, Good Morning",style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 13,color: AppColors.white)),
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height*.01,),
                              Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("09:30 am",style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 10,color: Color(0xffCFCFCF))),
                                    Image.asset('assets/images/statuscheck.png'),
                                    Image.asset('assets/images/statuscheck2.png'),

                                  ],
                                ),

                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: Get.height*.04,),
                        // ******************** main ******************
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              Image.asset('assets/images/firstlogomarketing.png',scale: 1.2,),
                              SizedBox(width: Get.width*.04,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.bottomStart,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[800],
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                                      ),
                                      width: Get.width/2,
                                      padding: EdgeInsets.all(20),
                                      child: Center(
                                        child: Text("Morning, Can i help you ?",style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 13,color: AppColors.white)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Get.height*.01,),
                                  Align(
                                    alignment: AlignmentDirectional.bottomStart,
                                    child: Text("09:30 am",style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 10,color: Color(0xffCFCFCF))),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height*.04,),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
                                  ),
                                  width: Get.width/2,
                                  padding: const EdgeInsets.all(20),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text("I saw the UI/UX Designer vacancy that you uploaded on linkedin yesterday and I am interested in joining your company.",style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 13,color: AppColors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height*.01,),
                              const Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("09:30 am",style: TextStyle(
                                        color: Colors.white
                                    ),),
                                    Text("_//",style: TextStyle(
                                        color: Colors.green
                                    ),)
                                  ],
                                ),

                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: Get.height*.04,),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              Image.asset('assets/images/firstlogomarketing.png',scale: 1.2,),
                              SizedBox(width: Get.width*.04,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.bottomStart,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[800],
                                          borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                                      ),
                                      width: Get.width/2,
                                      padding: const EdgeInsets.all(20),
                                      child: Center(
                                        child: Text("Oh yes, please send your CV/Resume here",style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 13,color: AppColors.white)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Get.height*.01,),
                                  Align(
                                    alignment: AlignmentDirectional.bottomStart,
                                    child: Text("09:30 am",style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 10,color: Color(0xffCFCFCF))),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Get.height*.04,),

                        //***************** comment *********************


                      ],
                    ),
                  ),
                )
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.black,
                          borderRadius: BorderRadius.circular(23),
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: SizedBox(
                          height: Get.height*0.07,
                          child: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: GestureDetector(
                                    onTap: () {

                                    },
                                    child: Image.asset('assets/images/sendme.png')),
                                onPressed: _submitComment,
                              ),
                              prefixIcon: IconButton(
                                icon: Image.asset('assets/images/addfile.png'),
                                onPressed: _submitComment,
                              ),
                              hintText: 'Type Message',
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
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
