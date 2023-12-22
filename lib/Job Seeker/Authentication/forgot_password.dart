
import 'package:flikka/Job%20Seeker/Role_Choose/choose_role.dart';
import 'package:flikka/controllers/ForgotPasswordController/ForgotPasswordController.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/app_colors.dart';
import 'login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ForgotPasswordController ForgotPasswordControllerInstanse=Get.put(ForgotPasswordController());

  final _formKey = GlobalKey<FormState>();
  var isLoading = false;


  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueThemeColor,
          leading: IconButton(onPressed: () {
            Get.back();
          }, icon: Image.asset("assets/images/icon_back.png",)),
          // title:  Text("Forum", style: Get.theme.textTheme.displayLarge),
          toolbarHeight: 70,
        ),
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                    color: AppColors.blueThemeColor
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Get.height*.06,),
                    Center(
                      child: SizedBox(
                          //width: Get.width*.76,
                          child: Text("Forgot Password?",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 30))),
                    ),
                    SizedBox(height: Get.height*.02,),
                    Center(
                      child: SizedBox(
                        width: Get.width*.9,
                        child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffFFFFFF),fontSize: 13),),
                      ),
                    ),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.72, // half screen
                minChildSize: 0.72, // half screen
                maxChildSize: 0.72, // full screen
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30) ,
                          topLeft:Radius.circular(30) , ),
                        color: Colors.black),
                    // color: Colors.black,
                    child:   SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Container(
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
                              Center(child: Image.asset("assets/images/icon_forgot_pass.png",height: Get.height*.16,)),
                              SizedBox(height: Get.height*.04,),
                              Text("Email",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                              SizedBox(height: Get.height*.01,),
                              TextFormField(
                                controller: ForgotPasswordControllerInstanse.emailController.value,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  ),

                                  filled: true,
                                  fillColor: Color(0xffFFFFFF),
                                  hintText: "Enter your email",
                                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w500),
                                ),
                                onChanged: (value) {
                                  ForgotPasswordControllerInstanse.forgotPasswordErrorMessage.value = "" ;
                                },
                                onFieldSubmitted: (value) {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email address';
                                  } else if (!_isValidEmail(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              Obx(() => ForgotPasswordControllerInstanse.forgotPasswordErrorMessage.value.isEmpty ?
                              const SizedBox() :
                              Text(ForgotPasswordControllerInstanse.forgotPasswordErrorMessage.value,style: TextStyle(color: Colors.red),)
                              ),
                              SizedBox(height: Get.height*.03,),
                            Obx(() =>  Center(
                              child: MyButton(
                                loading: ForgotPasswordControllerInstanse.loading.value,
                                  width: Get.width*.72,
                                  title: "RESET PASSWORD",
                                  onTap1: () {
                                    ForgotPasswordControllerInstanse.forgotPasswordErrorMessage.value = "" ;
                                    if(_formKey.currentState!.validate()) {
                                      if(ForgotPasswordControllerInstanse.loading.value){}else {
                                        ForgotPasswordControllerInstanse.forgotPasswordApiHit(context);
                                      }
                                    }
                                  }
                              ),
                            ),) ,
                              SizedBox(height: Get.height*.018,),
                              Center(
                                child: SizedBox(
                                  width:   Get.width*.7,
                                  height:   56,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(()=>const Login());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xffFFFFFF),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    child:Text("BACK TO LOGIN",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),),
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

