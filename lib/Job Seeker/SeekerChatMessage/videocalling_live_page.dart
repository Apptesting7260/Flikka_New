import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/app_colors.dart';

class VideoCallingLivePage extends StatefulWidget {
  const VideoCallingLivePage({super.key});

  @override
  State<VideoCallingLivePage> createState() => _VideoCallingLivePageState();
}

class _VideoCallingLivePageState extends State<VideoCallingLivePage> with WidgetsBindingObserver {

  void showInterviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          //*********** you can't define any value because this is auto value padding added **********
          //insetPadding: EdgeInsets.all(20),
          content: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: Get.height * 0.09),
                Text(
                  'Is interview completed?',
                  style: Get.theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: Get.height * 0.02),
                Text(
                  'Lorem Ipsum is simply industry.',
                  style: Get.theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400, color: Color(0xffCFCFCF)),
                ),
                SizedBox(height: Get.height * 0.04),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: Get.height * 0.06,
                          child: MyButton(onTap1: () {}, title: 'YES', style: Get.theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),),
                        ),
                      ),
                      SizedBox(width: 20), // Adding spacing between buttons
                      Expanded(
                        child: SizedBox(
                          height: Get.height * 0.06,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'NO',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, color: AppColors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.09),
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    // Set the system overlay style to light with transparent status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    // Reset the system overlay style to the default
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Expanded(child: Image.asset('assets/images/maleonlivecall.png', fit: BoxFit.cover, width: Get.width)),
              Expanded(child: Image.asset('assets/images/femaleonlivecall.png', fit: BoxFit.cover, width: Get.width)),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    // Handle camera toggle
                  },
                  icon: Image.asset('assets/images/cameraturn.png'),
                  color: Colors.white, // Set icon color
                  splashRadius: 20, // Set splash radius
                  padding: EdgeInsets.all(0), // Remove padding
                ),
                IconButton(
                  onPressed: () {
                    // Handle call cut
                  },
                  icon: Image.asset('assets/images/videocallicon.png'),
                  color: Colors.white, // Set icon color
                  splashRadius: 20, // Set splash radius
                  padding: EdgeInsets.all(0), // Remove padding
                ),
                IconButton(
                  onPressed: () {
                    // Handle microphone toggle
                  },
                  icon: Image.asset('assets/images/micicon.png'),
                  color: Colors.white, // Set icon color
                  splashRadius: 20, // Set splash radius
                  padding: EdgeInsets.all(0), // Remove padding
                ),
                IconButton(
                  onPressed: () {
                    // Handle microphone toggle
                  },
                  icon: GestureDetector(
                     onTap: () {
                       showInterviewDialog(context);
                     },
                      child: Image.asset('assets/images/callcuticon.png')),
                  color: Colors.white, // Set icon color
                  splashRadius: 20, // Set splash radius
                  padding: EdgeInsets.all(0), // Remove padding
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
