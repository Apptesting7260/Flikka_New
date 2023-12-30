
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flikka/Job%20Recruiter/metting_list/metting_list_tabbar.dart';
import 'package:flikka/Job%20Seeker/SeekerChatMessage/message_page.dart';
import 'package:flikka/Job%20Seeker/SeekerCompanies/companies_seeker_page.dart';
import 'package:flikka/Job%20Seeker/Authentication/user/user_profile.dart';
import 'package:flikka/Job%20Seeker/SeekerJobs/AppliedJobs.dart';
import 'package:flikka/Payment_Methods/wallet.dart';
import 'package:flikka/controllers/LogoutController/LogoutController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/app_colors.dart';
import '../JobAlert/jobAlert.dart';
import '../SeekerNotification/SeekerNotification.dart';
import '../SeekerNotification/setting_page.dart';
import '../saved_post_widget.dart';
import '../SeekerBottomNavigationBar/tab_bar.dart';

class DrawerClass extends StatefulWidget {
  final String? name ;
  final String? location ;
  final String? jobTitle ;
  final String? profileImage ;
  const DrawerClass({super.key, required this.name, required this.location, required this.jobTitle, this.profileImage});

  @override
  State<DrawerClass> createState() => _DrawerClassState();
}

class _DrawerClassState extends State<DrawerClass> {

  LogoutController logoutController  = Get.put( LogoutController()) ;

  String homeIcon = 'assets/images/homedrawericon.png' ;
  String profileIcon = 'assets/images/profiledrawericon.png' ;
  String interviewIcon = 'assets/images/interviewdrawericon.png' ;
  String notificationIcon = 'assets/images/notificationdrawericon.png' ;
  String savePostIcon = 'assets/images/icon_saved_post_drawer.png' ;
  String companyIcon = 'assets/images/icon_companies.png' ;
  String forumIcon = 'assets/images/icon_forum.png' ;
  String aboutIcon = 'assets/images/aboutdrawericon.png' ;
  String settingIcon = 'assets/images/settingdrawericon.png' ;
  String logoutIcon = 'assets/images/logoutdrawericon.png' ;
  String messageIcon = 'assets/images/icon_message.png' ;
  String appliedJobsIcon = 'assets/images/icon_applied_jobs.png' ;
  String jobAlertIcon = 'assets/images/icon_job_alert.png' ;
  String helpIcon = 'assets/images/icon_help.png' ;
  String walletIcon = 'assets/images/icon_wallet_drawer.png' ;

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () { Get.back() ;},
                  ) ,
                  Positioned(
                    right: 0,
                    child: Container(
                      //height: Get.height * 1.43,
                      width: Get.width * 0.62,
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              height: Get.height*.28,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: AppColors.blueThemeColor
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: Get.height*.04,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius:42,
                                          backgroundColor: Colors.transparent,
                                          child: CachedNetworkImage(
                                              imageUrl: "${widget.profileImage}",
                                          imageBuilder: (context, imageProvider) => Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                              fit: BoxFit.cover ,
                                              )
                                            ),
                                          ),
                                            placeholder: (context, url) => const CircularProgressIndicator(color: Colors.white,),
                                          ),
                                          // backgroundImage: NetworkImage("${widget.profileImage}"),
                                        ),
                                        const SizedBox(
                                          height: 9,
                                        ),
                                        Text("${widget.name}",
                                          style: Get.theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: Get.height*.002,
                                        ),
                                        Text(
                                            widget.jobTitle ?? "No job title",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall?.copyWith(color: const Color(0xffFFFFFF),fontWeight: FontWeight.w600)
                                        ),
                                        SizedBox(
                                          height: Get.height*.002,
                                        ),
                                        Text(
                                          "${widget.location}",overflow: TextOverflow.ellipsis,
                                          style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
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
                            color: const Color(0xff353535),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                  // ListTile(
                                  //   onTap: () {
                                  //     Get.offAll(const TabScreen(index: 0));
                                  //   },
                                  //   horizontalTitleGap:0,
                                  //   dense: true,
                                  //   leading: drawerIcon(homeIcon) ,
                                  //   title: Text(
                                  //     "Home",
                                  //     style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                  //   ),
                                  // ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    onTap: () {
                                      Get.to(() => const UserProfile());
                                    },
                                    dense: true,
                                    leading: drawerIcon(profileIcon) ,
                                    title: Text(
                                      "Profile",
                                      style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                    ),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:3,
                                    onTap: (){
                                      Get.to(() =>const SeekerMessagePage());
                                    } ,
                                    dense: true,
                                    leading: drawerIcon(messageIcon) ,
                                    title: Text(
                                      "Message",
                                      style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                    ),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    onTap: () {
                                      Get.to(const MettingListTabbar());
                                    },
                                    leading: drawerIcon(interviewIcon),
                                    title: Text(
                                      "Interviews",
                                      style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Get.to(() => const SeekerNotification());
                                    },
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: drawerIcon(notificationIcon),
                                    title: Text(
                                      "Notifications",
                                      style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                       Get.to(() => const SetJobAlert());
                                    },
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: drawerIcon(jobAlertIcon),
                                    title: Text(
                                      "Job alert",
                                      style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Get.to(() =>const SavedPost());
                                    },
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: drawerIcon(savePostIcon) ,
                                    title: Text(
                                      "Save Post",
                                      style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                    ),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    onTap: () {
                                      Get.to( () => const SeekerAppliedJobs()) ;
                                    },
                                    leading: drawerIcon(appliedJobsIcon) ,
                                    title: Text(
                                      "Applied jobs",
                                      style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                    ),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    onTap: () {
                                      Get.to( () => const Wallet()) ;
                                    },
                                    leading: drawerIcon(walletIcon) ,
                                    title: Text(
                                      "Wallet",
                                      style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                    ),
                                  ),
                                  // ListTile(
                                  //   horizontalTitleGap:0,
                                  //   dense: true,
                                  //   onTap: () {
                                  //     Get.to( () => const SeekerRequestedJobs()) ;
                                  //   },
                                  //   leading: drawerIcon(appliedJobsIcon) ,
                                  //   title: Text(
                                  //     "Requested jobs",
                                  //     style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                  //   ),
                                  // ),
                                  // ListTile(
                                  //   horizontalTitleGap:0,
                                  //   onTap: (){
                                  //     Get.to(() =>const CompanySeekerPage());
                                  //   } ,
                                  //   dense: true,
                                  //   leading: drawerIcon(companyIcon) ,
                                  //   title: Text(
                                  //     "Companies",
                                  //     style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                  //   ),
                                  // ),

                                  // ListTile(
                                  //   horizontalTitleGap:0,
                                  //   dense: true,
                                  //   leading: drawerIcon(aboutIcon) ,
                                  //   title: Text(
                                  //     "About",
                                  //     style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                  //   ),
                                  // ),
                                  ListTile(
                                    onTap: () {
                                      Get.to(() =>const SettingPage());
                                    },
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: drawerIcon(settingIcon) ,
                                    title: Text(
                                      "Setting",
                                      style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {

                                    },
                                    horizontalTitleGap:0,
                                    dense: true,
                                    leading: drawerIcon("assets/images/icon_help.png") ,
                                    title: Text(
                                      "Help",
                                      style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
                                    ),
                                  ),
                                  ListTile(
                                    horizontalTitleGap:0,
                                    dense: true,
                                    onTap: () {
                                      logoutController.logout(context) ;
                                      showLogoutDialog(context)  ;
                                    },
                                    leading: drawerIcon(logoutIcon) ,
                                    title: Text(
                                      "Logout",
                                      style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,fontSize: 16),
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
