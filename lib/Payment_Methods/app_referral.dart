import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/app_colors.dart';

class AppReferral extends StatefulWidget {
  const AppReferral({super.key});

  @override
  State<AppReferral> createState() => _AppReferralState();
}

class _AppReferralState extends State<AppReferral> {
  final List<Map<String, dynamic>> items = [
    {'title': 'Item 1', 'subtitle': 'Subtitle 1'},
    {'title': 'Item 2', 'subtitle': 'Subtitle 2'},
    {'title': 'Item 3', 'subtitle': 'Subtitle 3'},
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset('assets/images/icon_back_blue.png')),
        ),
        elevation: 0,
        title: Text(
          "App Referral",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 15, top: 30),
        //     child: Text("Delete All",
        //         style: Get.theme.textTheme.bodyLarge!.copyWith(
        //             color: AppColors.blueThemeColor)),
        //   )
        // ],
      ),
      body: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Earning",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        Text(
                          "£60.00",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                  fontSize: 12, color: AppColors.blueThemeColor),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Referral",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        Text(
                          "5",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                  fontSize: 12, color: AppColors.blueThemeColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height*.04,),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.textFieldFilledColor,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        height: Get.height*.1,
                        width: Get.width,
                        child: ListTile(
                       title: Text("johndue123@gmail.com",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height*.001,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("£12.00",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.blueThemeColor),),
                                  Text("View",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.blueThemeColor),),
                                ],
                              ),
                            SizedBox(height: Get.height*.001,),
                              Text("Today 10:40 AM",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.blueThemeColor),),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      )),
    );
  }
}
