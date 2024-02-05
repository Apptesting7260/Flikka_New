import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/CommonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_colors.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: AppColors.blueThemeColor,
        leading: GestureDetector(
            onTap: () {
              Get.back() ;
            },
            child: Image.asset("assets/images/icon_back.png")),
        title: Text("John Due",style: Theme.of(context).textTheme.titleSmall,),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: Get.height,
            width: Get.width,
            decoration: const BoxDecoration(color: AppColors.blueThemeColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: Get.height*.05,)  ,
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/icon_about_ue_user.png"),

                ),
                SizedBox(height: Get.height*.02,)  ,
                Text("John Due",style: Theme.of(context).textTheme.titleSmall,),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.72, // half screen
            minChildSize: 0.72, // half screen
            maxChildSize: 0.72, // full screen
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30) ,
                          topLeft:Radius.circular(30) , ),
                        color: Colors.black),
                child: Column(
                  children: [
                    Row(
                      children: [
                          Image.asset("assets/images/icon_phone_call.png",height: Get.height*.04,),
                        Text("Phone Number",style: Theme.of(context).textTheme.titleSmall,)
                      ],
                    ),
                    TextFormField(
                      // controller: SaveBankDetailsControllerInstanse.bankName.value,
                      readOnly: true,
                      style: const TextStyle(color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "+918789567845",
                        hintStyle: const TextStyle(fontSize: 14.0, color: Color
                            .fromRGBO(255, 255, 255, 1)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 17, horizontal: 15),
                        fillColor: const Color(0xff373737),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33),
                            borderSide: BorderSide.none
                        ),
                      ),
                    ),
                    CommonWidgets.divider(),
                    Row(
                      children: [
                        Image.asset("assets/images/icon_phone_call.png",height: Get.height*.04,),
                        Text("Phone Number",style: Theme.of(context).textTheme.titleSmall,)
                      ],
                    ),
                  ],
                ),
              );

            },
          ),
        ],
      ),

    );
  }
}
