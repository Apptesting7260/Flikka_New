import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MemberShip extends StatefulWidget {
  const MemberShip({super.key});

  @override
  State<MemberShip> createState() => _MemberShipState();
}

class _MemberShipState extends State<MemberShip> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        title: Text("Membership", style: Get.theme.textTheme.displayLarge),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ListView.builder(
                // scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 3,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: Get.height*.25,
                      width: Get.width,
                      decoration:  const BoxDecoration(
                          color: AppColors.blueThemeColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)
                          )
                      ),
                      child:  Column(
                        children: [
                          SizedBox(height: 20,) ,
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children:  [
                                TextSpan(
                                    text: '\$', // Dollar sign in small
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 19,fontWeight: FontWeight.w400)
                                ),
                                TextSpan(
                                  text: '149', // Number in bold and big text
                                  style: Theme.of(context).textTheme.displayLarge,
                                ),

                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                                text: "USD /month",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 19,fontWeight: FontWeight.w400)
                            ),
                          ),
                          SizedBox(height: Get.height*.02,) ,
                          Container(
                            height: 40,
                            width: 140,
                            decoration:  BoxDecoration(
                              color: Color(0xff256AFE),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: Text("MONTHLY ONLY",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 10,fontWeight: FontWeight.w700),))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: Get.height*.7,
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: Color(0xff353535),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Get.height*.03,) ,
                            Center(child: Text("Starter",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 30),)) ,
                            Center(child: Text("Designed for occasional hiring",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),)),
                            SizedBox(height: 20,) ,
                            Container(
                              // margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.only(left: 15),
                              height: 55,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Color(0xff454545),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("UP TO 50 EMPLOYEES",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),),

                                ],
                              ),
                            ),
                            const SizedBox(height: 20,) ,
                            Text("Includes:",style: Theme.of(context).textTheme.titleSmall,) ,
                            SizedBox(height: Get.height*.4,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    horizontalTitleGap: 0,
                                    leading: const CircleAvatar(
                                      radius: 3,
                                      backgroundColor: Colors.white,
                                    ),
                                    title: Text("Features available in all plans Up to 2 active jobs 200 AI sourcing profile views per month",overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),),
                                  ) ;
                                },
                              ),
                            ) ,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height*.04,) ,
                  ],
                );
              },)
            ],
          ),
        ),
      ),
    );
  }
}
