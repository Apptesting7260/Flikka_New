import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUS extends StatefulWidget {
  const AboutUS({super.key});

  @override
  State<AboutUS> createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {

  final List<String> imageUrls = [
    'assets/images/icon_about_us_home_counter.png',
    'assets/images/icon_about_us_daily_user_visited.png',
    'assets/images/icon_about_us_daily_job_post.png',
    'assets/images/icon_about_us_total_recruiter.png',
  ] ;

  String dynamicText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida. Risus commodo viverra maecenas accumsan lacus vel facilisis.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida. Risus commodo viverra maecenas accumsan lacus vel facilisis. Consectetur adipiscing elit Lorem ipsum dolor sit amet, consectetur adipiscing elit, Lorem ipsum dolor sit amet, consectetur adipiscing elit," ;
  String dynamicTextSecond = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida. Risus commodo viverra maecenas accumsan lacus vel facilisis.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida. Risus commodo viverra maecenas accumsan lacus vel facilisis. Consectetur adipiscing elit Lorem ipsum dolor sit amet, consectetur adipiscing elit, Lorem ipsum dolor sit amet, consectetur adipiscing elit," ;

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
          "About Us",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/icon_about_us_banner.jpg"),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
               child: Column(
                 // crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Get.height*.02,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'About ',
                            style: Theme.of(context).textTheme.displayLarge
                          ),
                           TextSpan(
                            text: 'Flikka',
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppColors.blueThemeColor)
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height*.02,),
                  Text(dynamicText,textAlign: TextAlign.justify,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height*.04,),
                  Image.asset("assets/images/icon_about_us_logo.png") ,
                  SizedBox(height: Get.height*.04,),
                  Text(dynamicTextSecond,textAlign: TextAlign.justify,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height*.04,),
                  Text("How It Works?",style: Theme.of(context).textTheme.displaySmall,),
                  SizedBox(height: Get.height*.01,),
                  Text("To choose your trending job dream & to make future bright.",textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height*.02,),
                  ListView.builder(
                    shrinkWrap: true,
                      itemCount: 3,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                      List<String> itemText = [
                        "Create Your Account",
                        "Find Your Job",
                        "Join Your Company",
                      ];
                        return Padding(
                          padding: EdgeInsets.only(bottom: Get.height*.02),
                          child: Container(
                            height: Get.height*.3,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: AppColors.blackdown,
                                borderRadius: BorderRadius.circular(17)
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: Get.height*.03,),
                                Image.asset("assets/images/icon_about_us_person.png",height: Get.height*.1,),
                                SizedBox(height: Get.height*.015,),
                                Text(itemText[index],style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
                                SizedBox(height: Get.height*.01,),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
                                  child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF))),
                                ),
                              ],
                            ),
                          ),
                        );
                      },),
                  SizedBox(height: Get.height*.02,),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                      List<String> itemText = [
                        "Total Recruiters",
                        "Daily User Visited",
                        "Daily Job Posted",
                        "Total Recruiters",
                      ] ;
                      return Padding(
                        padding: EdgeInsets.only(bottom: Get.height*.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(imageUrls[index],height: Get.height*.06,),
                            SizedBox(width: Get.width*.04,) ,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text("100+",overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 30),),
                                Text(itemText[index],style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),),
                              ],
                            )
                          ],
                        ),
                      );
                        // return Center(
                        //   child: SizedBox(
                        //     width: Get.width*.5,
                        //     child: ListTile(
                        //       leading: Image.asset("assets/images/icon_home_counter.png",height: Get.height*.05,),
                        //       title: Text("100+",overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 30),),
                        //       subtitle: Text("Total Recruiters",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),),
                        //     ),
                        //   ),
                        // ) ;
                      },),
                  SizedBox(height: Get.height*.02,),
                  Text("Customer Feedback",style: Theme.of(context).textTheme.displaySmall,),
                  SizedBox(height: Get.height*.01,),
                  Text("To choose your trending job dream & to make future bright.", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height*.02,),
                   Stack(
                     alignment: Alignment.center,
                   children: [
                     const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/images/icon_about_ue_user.png"),
                                   ),
                     Image.asset("assets/images/icon_about_us_circle.png",height: Get.height*.11,)
                   ]
                  ),
                  SizedBox(height: Get.height*.02,),
                  Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text", textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height*.04,),
                  Text("Jessica Parker",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
                  SizedBox(height: Get.height*.01,),
                  Text("marketing intern",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height*.03,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: AppColors.blueThemeColor,
                          shape: BoxShape.circle
                        ),
                      ),
                      SizedBox(width: Get.width*.02,),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: AppColors.blueThemeColor,
                          shape: BoxShape.circle
                        ),
                      ),
                      SizedBox(width: Get.width*.02,),
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: AppColors.blueThemeColor,
                          shape: BoxShape.circle
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height*.03,),
                  Text("Newsletter",style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                  Text("Stay in your customers' minds with our engaging newsletters.", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height*.03,),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.blackdown,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: BorderSide.none
                      ),
                      labelText: 'Enter your email....',
                      // hintText: 'Type something here',
                    ),
                  ),
                  SizedBox(height: Get.height*.03,),
                  MyButton(title: "SUBMIT", onTap1: () {

                  },),
                  SizedBox(height: Get.height*.05,),
                ],
               ),
             )
          ],
        ),
      ),
    );
  }
}
