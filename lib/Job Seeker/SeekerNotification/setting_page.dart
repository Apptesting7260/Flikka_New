import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';
import '../../controllers/DeleteUserController/DeleteUserController.dart';
import '../../controllers/LogoutController/LogoutController.dart';
import '../Authentication/forgot_password.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  LogoutController logoutController  = Get.put( LogoutController()) ;

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

  final _controller = ValueNotifier<bool>(false);

  DeleteUserController deleteUserController = Get.put(DeleteUserController()) ;

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
        title: Text("Settings",style: Get.theme.textTheme.displayLarge),

      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height*0.04,),
            Container(
              height: Get.height*0.08,
              width: Get.width*0.9,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    IconButton(onPressed: (){} ,icon: Image.asset('assets/images/notificationfull.png',color: AppColors.blueThemeColor,)),
                    Text("Notifications",style: Get.theme.textTheme.bodyMedium),
                  ],),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: AdvancedSwitch(
                      controller: _controller,
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey,
                      // activeChild: Text('ON'),
                      // inactiveChild: Text('OFF',style: TextStyle(
                      //   color: Colors.black
                      // ),),
                      activeImage: AssetImage('assets/images/switchon.png'),
                      inactiveImage: AssetImage('assets/images/whites.jpg'),
                      borderRadius: BorderRadius.all(const Radius.circular(15)),
                      width: Get.width*0.15,
                      height: Get.height*0.04,
                      enabled: true,
                      disabledOpacity: 0.5,
                    ),
                  ),

                ],
              )
            ),
            SizedBox(height: Get.height*0.022,),
            GestureDetector(
              onTap: () {
                Get.to(() => const ForgotPassword()) ;
              },
              child: Container(
                  height: Get.height*0.08,
                  width: Get.width*0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        IconButton(onPressed: (){} ,icon: Image.asset('assets/images/lockicon.png',color: AppColors.blueThemeColor,)),
                        Text("Password",style: Get.theme.textTheme.bodyMedium),
                      ],),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined,size: 15,))
                    ],
                  )
              ),
            ),
            SizedBox(height: Get.height*0.022,),
            GestureDetector(
              onTap: () {
                CommonFunctions.confirmationDialog(context, message :"Do you want to log out", onTap: (){
                  Get.back() ;
                  logoutController.logout(context) ;
                  showLogoutDialog(context)  ;
                }) ;

              },
              child: Container(
                  height: Get.height*0.08,
                  width: Get.width*0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        IconButton(onPressed: (){} ,icon: Image.asset('assets/images/logout.png',color: AppColors.blueThemeColor,)),
                        Text("Logout",style: Get.theme.textTheme.bodyMedium),
                      ],),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined,size: 15,))
                    ],
                  )
              ),
            ),
            SizedBox(height: Get.height*0.022,),
            GestureDetector(
              onTap: () {
                CommonFunctions.confirmationDialog(context, message: "Do you want to delete your account", onTap: () {
                  Get.back() ;
                  CommonFunctions.showLoadingDialog(context, "Deleting...") ;
                  deleteUserController.deleteUser(context) ;
                }) ;

              },
              child: Container(
                  height: Get.height*0.08,
                  width: Get.width*0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        IconButton(onPressed: (){} ,icon: Image.asset('assets/images/logout.png',color: AppColors.blueThemeColor,)),
                        Text("Delete account",style: Get.theme.textTheme.bodyMedium),
                      ],),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_outlined,size: 15,))
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
