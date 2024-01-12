import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Recruiter/AddJobPage/create_job_post.dart';
import 'package:flikka/Job%20Recruiter/bottom_bar/tab_bar.dart';
import 'package:flikka/controllers/LogoutController/LogoutController.dart';
import 'package:flikka/controllers/ViewRecruiterProfileController/ViewRecruiterProfileController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Job Seeker/SeekerNotification/setting_page.dart';
import '../ChartReport/chart_report.dart';


class DrawerRecruiter extends StatefulWidget {
  const DrawerRecruiter({super.key});

  @override
  State<DrawerRecruiter> createState() => _DrawerRecruiterState();
}

class _DrawerRecruiterState extends State<DrawerRecruiter> {

  LogoutController logoutController = Get.put(LogoutController()) ;
  ViewRecruiterProfileGetController viewRecruiterProfileController = Get.put(ViewRecruiterProfileGetController());

  String iconProfile = 'assets/images/profiledrawericon.png' ;
  String iconApplicant = 'assets/images/icon_applicant.png' ;
  String iconJobPost = 'assets/images/icon_job_post.png' ;
  String iconReport = 'assets/images/icon_report.png' ;
  String iconSetting = 'assets/images/settingdrawericon.png' ;
  String iconLogout = 'assets/images/logoutdrawericon.png' ;
  
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back() ;
                    },
                  ) ,
                  Positioned(
                    right: 0,
                    child: Container(
                      //height: Get.height * 1.43,
                      width: Get.width * 0.62,
                      color: Colors.transparent,
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              height: Get.height*.27,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: AppColors.blueThemeColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: Get.height*.026,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius:45,
                                          backgroundColor: const Color(0xffE94D8A).withOpacity(0.3),
                                          child: CachedNetworkImage(
                                              imageUrl: viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.profileImg ?? "assets/images/icon_recruiter_drawer.png",
                                              imageBuilder: (context, imageProvider) => Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                  fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),placeholder: (context, url) => const CircularProgressIndicator(color: Colors.white),
                                          ),
                                          //backgroundImage:  NetworkImage(viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.profileImg ?? "assets/images/icon_recruiter_drawer.png"),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.companyName ?? "No Data",
                                          style: Get.theme.textTheme.titleSmall,
                                        ),
                                        SizedBox(
                                          height: Get.height*.002,
                                        ),
                                        Text(
                                          viewRecruiterProfileController.viewRecruiterProfile.value.recruiterProfileDetails?.companyLocation ?? "No Data",
                                         overflow: TextOverflow.ellipsis, style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          Container(
                            height: Get.height/1.4,
                            color: AppColors.homeGrey,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     // Get.offAll(TabScreen(index: 0,));
                                  //   },
                                  //   child: ListTile(
                                  //     horizontalTitleGap:0,
                                  //     dense: true,
                                  //     leading: IconButton(
                                  //         onPressed: () {
                                  //           // print("object") ;
                                  //           // Get.to(TabScreenEmployer(index: 0,)) ;
                                  //         },
                                  //         icon: Image.asset('assets/images/homedrawericon.png')
                                  //     ),
                                  //     title: InkWell(
                                  //         onTap: () {
                                  //           Get.offAll(TabScreenEmployer(index: 0,));
                                  //         },
                                  //         child: Text(
                                  //           "Home",
                                  //           style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                  //         )),
                                  //   ),
                                  // ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: drawerIcon(iconProfile),
                                    title: InkWell(
                                        onTap: (){
                                          Get.offAll(TabScreenEmployer(index: 4,));
                                        },
                                        child: Text(
                                          "Profile",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16, color: AppColors.black),
                                        )),
                                  ),
                                  // ListTile(
                                  //   horizontalTitleGap:0,
                                  //   dense: true,
                                  //   leading: IconButton(
                                  //       onPressed: () {
                                  //         // Get.to(NewArrivals());
                                  //       },
                                  //       icon: Image.asset('assets/images/interviewdrawericon.png',scale: 2.8,fit: BoxFit.cover,)
                                  //   ),
                                  //   title: InkWell(
                                  //     onTap: () {
                                  //       Get.to(MettingListTabbar());
                                  //     },
                                  //     child: Text(
                                  //       "Interviews",
                                  //       style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                  //     ),
                                  //   ),
                                  // ),
                                  ListTile(
                                    onTap: () {

                                    },
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: drawerIcon(iconApplicant),
                                    title: InkWell(
                                        onTap: (){
                                          Get.offAll(TabScreenEmployer(index: 1,));
                                        } ,
                                        child: Text(
                                          "Applicant Tracking",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16, color: AppColors.black),
                                        )),
                                  ),
                                  // ListTile(
                                  //   onTap: () {
                                  //     // Get.to(() =>SavedPost());
                                  //   },
                                  //   horizontalTitleGap:0,
                                  //   dense: true,
                                  //   leading: IconButton(
                                  //       onPressed: () {
                                  //         //Get.to((ResetPassword()));
                                  //       },
                                  //       icon: Image.asset('assets/images/icon_hiring.png',scale: 2.8,fit: BoxFit.cover,)),
                                  //   title: InkWell(
                                  //       onTap: (){
                                  //         Get.to((ApplicantTrackingHiringManager()));
                                  //       } ,
                                  //       child: Text(
                                  //         "Hiring Manager Account",
                                  //         style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                  //       )),
                                  // ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: drawerIcon(iconJobPost),
                                    title: InkWell(
                                        onTap: (){
                                          Get.to(() => CreateJobPost()) ;
                                        } ,
                                        child: Text(
                                          "Job Post",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16, color: AppColors.black),
                                        )),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: drawerIcon(iconReport),
                                    title: InkWell(
                                        onTap: (){
                                          Get.to(() => const ChartReport());
                                        } ,
                                        child: Text(
                                          "Report",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16, color: AppColors.black),
                                        )),
                                  ),
                                  // ListTile(
                                  //   horizontalTitleGap:0,
                                  //   dense: true,
                                  //   leading: IconButton(
                                  //       onPressed: () {
                                  //
                                  //       },
                                  //       icon: Image.asset('assets/images/icon_saved_post_drawer.png',scale: 2.8,fit: BoxFit.cover,)),
                                  //   title: InkWell(
                                  //       onTap: (){
                                  //         Get.to((SavedPostRecuiter()));
                                  //       } ,
                                  //       child: Text(
                                  //         "Save Post",
                                  //         style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                  //       )),
                                  // ),

                                  // ListTile(
                                  //   horizontalTitleGap:0,
                                  //   dense: true,
                                  //   leading: IconButton(
                                  //       onPressed: () {
                                  //         //Get.to((ResetPassword()));
                                  //       },
                                  //       icon: Image.asset('assets/images/icon_request.png',scale: 2.8,fit: BoxFit.cover,)),
                                  //   title: InkWell(
                                  //       onTap: (){
                                  //         Get.to(() =>Request());
                                  //       } ,
                                  //       child: Text(
                                  //         "Request",
                                  //         style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                  //       )),
                                  // ),
                                  // ListTile(
                                  //   horizontalTitleGap:0,
                                  //   dense: true,
                                  //   leading: IconButton(
                                  //       onPressed: () {
                                  //         //Get.to((ResetPassword()));
                                  //       },
                                  //       icon: Image.asset('assets/images/notificationdrawericon.png',scale: 2.8,fit: BoxFit.cover,)),
                                  //   title: InkWell(
                                  //       onTap: (){
                                  //         Get.to(() =>const Notification1());
                                  //       } ,
                                  //       child: Text(
                                  //         "Notificationst",
                                  //         style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                  //       )),
                                  // ),
                                  // ListTile(
                                  //   horizontalTitleGap:0,
                                  //   dense: true,
                                  //   leading: IconButton(
                                  //       onPressed: () {
                                  //         //Get.to((MyOrder()));
                                  //       },
                                  //       icon: Image.asset('assets/images/aboutdrawericon.png',scale: 2.8,fit: BoxFit.cover,)
                                  //   ),
                                  //   title: InkWell(
                                  //       onTap: () {},
                                  //       child: Text(
                                  //         "About",
                                  //         style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                  //       )),
                                  // ),
                                  ListTile(
                                    onTap: () {
                                      // Get.to(() =>SettingPage());
                                    },
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: drawerIcon(iconSetting),
                                    title: InkWell(
                                        onTap: () {
                                          Get.to(() =>const SettingPage());
                                        },
                                        child: Text(
                                          "Setting",
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16, color: AppColors.black),
                                        )),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: drawerIcon(iconLogout),
                                    onTap: () {
                                      logoutController.logout(context) ;
                                      showLogoutDialog(context) ;
                                    },
                                   
                                    title: Text(
                                      "Logout",
                                      style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16, color: AppColors.black),
                                    ),
                                  ),
                                  SizedBox(height: Get.height*.2,),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      );
  }

  drawerIcon ( String image ) {
    return Image.asset(image,height: 22,fit: BoxFit.cover,) ;
  }


  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(backgroundColor: Color(0xff353535),)) ,
                    SizedBox(width: Get.width*.1,),
                    Text("Logging out...",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),) ,
                  ],
                )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }
}
