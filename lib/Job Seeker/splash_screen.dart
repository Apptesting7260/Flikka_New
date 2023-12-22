import 'dart:async';
import 'package:flikka/Job%20Seeker/Authentication/login.dart';
import 'package:flikka/Job%20Seeker/Role_Choose/location_pop_up.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Job Recruiter/bottom_bar/tab_bar.dart';
import 'Authentication/user/create-profile.dart';
import 'Role_Choose/choose_position.dart';
import 'Role_Choose/choose_skills.dart';
import 'SeekerBottomNavigationBar/tab_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer( const Duration(seconds: 5),
        () async {
          SharedPreferences sp = await SharedPreferences.getInstance();
          print(sp.getInt("step") ) ;
          print("this is role ${sp.getString("loggedIn")}" ) ;
          if(sp.getString("loggedIn") == "recruiter") {
            if(  sp.getInt("step") == 1) {
              Get.offAll(() => const LocationPopUp(role: 1)) ;
            } else {
            Get.offAll( () => TabScreenEmployer(index: 0,)) ; }
          } else if (sp.getString("loggedIn") == "seeker") {
            if(  sp.getInt("step") == 1) {
              Get.offAll(() => const LocationPopUp(role: 0)) ;
            } else if (sp.getInt("step") == 2) {
              Get.offAll(() => const ChooseSkills()) ;
            } else if(sp.getInt("step") == 3) {
              Get.offAll(() => const CreateProfile()) ;
            } else {
            Get.offAll(const TabScreen(index: 0)) ; }
          } else {
            Get.off(() => const Login());
          }
        }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("assets/images/icon_splash_logo.jpg",fit: BoxFit.cover),
      ),
    );
  }
}
