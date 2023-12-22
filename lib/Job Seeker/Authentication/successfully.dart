
import 'package:flikka/Job%20Seeker/Role_Choose/choose_role.dart';
import 'package:flikka/controllers/ResetPasswordController/ResetPasswordController.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/app_colors.dart';
import 'login.dart';

class Successfully extends StatefulWidget {
  const Successfully({Key? key}) : super(key: key);

  @override
  State<Successfully> createState() => _SuccessfullyState();
}

class _SuccessfullyState extends State<Successfully> {
  ResetPasswordController ResetPasswordControllerInstanse=Get.put(ResetPasswordController());

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }
  test(){
    print("gtettetetetete");
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }


  bool _isPasswordVisible = false;
  bool _isRememberMe = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blueAccent,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                  // gradient: LinearGradient(
                  //   // colors: [Color(0xff56B8F6), Color(0xff4D6FED)],
                  //   colors: [Color(0xff2386C7), Color(0xff4D6FED)],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                    color: AppColors.blueThemeColor
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Get.height*.08,),
                    Center(
                      child: SizedBox(
                        // width: Get.width*.8,
                          child: Text("Successfully",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 30))),
                    ),
                    SizedBox(height: Get.height*.02,),
                    Center(
                      child: SizedBox(
                        width: Get.width*.9,
                        child: Text("Your password has been updated, please change your password regularly to avoid this happening",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffFFFFFF),fontSize: 13),),
                      ),
                    ),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.72, // half screen
                minChildSize: 0.72, // half screen
                maxChildSize: 1, // full screen
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30) ,
                          topLeft:Radius.circular(30) , ),
                        color: Colors.black),
                    // color: Colors.black,
                    child:   SingleChildScrollView(
                      controller:scrollController ,
                      child: Container(
                        height: Get.height,
                        width: Get.width,
                        decoration: const BoxDecoration(
                          color: Color(0xff000000),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(33.0),
                            topRight: Radius.circular(33.0),
                          ),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: Get.width*.06),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height*.06,),
                              Center(child: Image.asset("assets/images/icon_successfully.png",height: Get.height*.16,)),
                              SizedBox(height: Get.height*.05,),
                            Obx(() => Center(
                              child: MyButton(
                                  loading: ResetPasswordControllerInstanse.loading.value,
                                  title: "CONTINUE",
                                  onTap1: () {
                                    // print(ResetPasswordControllerInstanse.loading.value);
                                    // ResetPasswordControllerInstanse.resetPasswordApiHit("");
                                  }
                              ),
                            ),) ,
                              SizedBox(height: Get.height*.02,),
                              Center(
                                child: SizedBox(
                                  width:   295,
                                  height:   56,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(()=>const Login());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xffFFFFFF),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    child: Text("BACK TO LOGIN",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

