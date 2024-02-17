import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({super.key});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/maps_icon.png"),
          SizedBox(height: Get.height*.05,),
          Center(
            child: Text("This features only for premium Users",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.black,fontWeight: FontWeight.w600),),
          ),
        ],
      ),
    );
  }
}
