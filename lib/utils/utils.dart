
import 'package:flikka/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../widgets/app_colors.dart';
import '../widgets/my_button.dart';

class Utils {


  static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode  nextFocus ){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message){
    Fluttertoast.showToast(
      msg: message ,
      backgroundColor: AppColors.blueThemeColor,
      textColor: AppColor.whiteColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,

    );
  }

  static toastMessageCenter(String message){
    Fluttertoast.showToast(
      msg: message ,
      backgroundColor: AppColor.redColor,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      textColor: AppColor.whiteColor,
    );
  }

  static snackBar(String title, String message){
    Get.snackbar(
      title,
      message ,
        backgroundColor: Colors.blueAccent
    );
    }

 static showMessageDialog(BuildContext context , String message) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child:  Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Center(child: Text(message,style: Theme.of(context).textTheme.titleSmall,)) ,
              const SizedBox(height: 15,) ,
              Center(
                child: MyButton(
                  width: Get.width*.3,
                  height: Get.height*.05,
                  title: "Ok", onTap1: () {
                 Get.back() ;
                },),
              )
            ],
          ),
        ),
      );
    },
  );
}

  static showApiErrorDialog(BuildContext context , String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: AppColors.graySilverColor)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text(message,style: Theme.of(context).textTheme.bodySmall,)) ,
                const SizedBox(height: 15,) ,
                Center(
                  child: MyButton(
                    width: Get.width*.27,
                    height: Get.height*.05,
                    title: "Ok",
                      onTap1: () {
                      Get.back() ;
                  },),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}


