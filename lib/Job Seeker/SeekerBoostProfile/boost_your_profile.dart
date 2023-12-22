import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../widgets/app_colors.dart';
import '../../widgets/my_button.dart';

class BoostYourProfiel extends StatefulWidget {
  const BoostYourProfiel({super.key});

  @override
  State<BoostYourProfiel> createState() => _BoostYourProfielState();
}

class _BoostYourProfielState extends State<BoostYourProfiel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: MyButton(
            title: 'Boost Your Profile',
            onTap1: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    //*********** you can't definle any value because this is auto value padding adde **********
                    insetPadding: EdgeInsets.symmetric(horizontal: 0),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: Get.height * 0.035),
                          Container(
                            padding:EdgeInsets.all(17),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60.0),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF56B8F6),
                                  Color(0xFF4D6FED),
                                ],
                                begin: Alignment.topCenter, // Start from the top center
                                end: Alignment.bottomCenter, // End at the bottom center
                              ),
                            ),
                            child: Image.asset('assets/images/boost.png',scale: 3.4,),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          Text(
                            "Boost your profile",
                            style: Get.theme.textTheme.labelMedium
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Text(
                              "Lorem Ipsum is simply dummy text",
                              style: Get.theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400,color: AppColors.white)
                          ),
                          SizedBox(height: Get.height * 0.05),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF56B8F6),
                                  Color(0xFF4D6FED),
                                ],
                                begin: Alignment.topCenter, // Start from the top center
                                end: Alignment.bottomCenter, // End at the bottom center
                              ),
                            ),
                            height: Get.height*0.21,
                            width: Get.width*0.32,
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(height: Get.height * 0.035),
                                  Text("1",
                                      style: Get.theme.textTheme.displaySmall!.copyWith(fontSize:25,color: AppColors.white)
                                  ),
                                  SizedBox(height: Get.height * 0.014),
                                  Text(
                                      "month",
                                       style: Get.theme.textTheme.titleSmall!.copyWith(fontSize:15,color: AppColors.white)
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Text(
                                      "\$100",
                                      style: Get.theme.textTheme.bodyMedium!.copyWith(fontSize:13,color: AppColors.white)
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Text(
                                      "Save 36%",
                                      style: Get.theme.textTheme.titleSmall!.copyWith(fontSize:11,color: AppColors.white)
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              height: Get.height * 0.035),
                          Center(
                            child: MyButton(
                              title: "BOOST ME",
                              onTap1: () {
                                // Get.to(() => LocationPopUp());
                              },
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02),
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                  );
                },
              );
            },
          ),
        ),
      )
    );
  }
}
