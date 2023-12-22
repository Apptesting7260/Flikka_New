
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flikka/controllers/LoginController/LoginController.dart';
import 'package:flikka/Job%20Seeker/Authentication/sign_up.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  LoginController loginController =Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;

  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Get.width*.05),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height*.04,) ,
               Center(child: Image.asset("assets/images/icon_flikka_logo.png",height: Get.height*.06,)) ,
                SizedBox(height: Get.height*.04,) ,
                Center(child: Image.asset("assets/images/icon_login_logo.png",height: Get.height*.25,)) ,
                SizedBox(height: Get.height*.02,),
                Text("Email",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                SizedBox(height: Get.height*.01,),
                TextFormField(
                  controller: loginController.emailController.value,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    filled: true,
                    fillColor: const Color(0xffFFFFFF),
                    errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.red),
                    hintText: "Enter your email",
                    hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w500),
                  ),
                  cursorColor: AppColors.blueThemeColor,
                  onChanged: (value) {
                    loginController.errorMessage.value = "" ;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    } else if (!_isValidEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Get.height*.02,),
                Text("Password",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                SizedBox(height: Get.height*.01,),
                TextFormField(
                  controller: loginController.passwordController.value,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    loginController.errorMessage.value = "" ;
                  },
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.08,vertical: Get.height*.027),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.red),
                      filled: true,
                      fillColor: Color(0xffFFFFFF),
                      hintText: "Enter your password",
                      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w500),
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027),
                      suffixIcon: Padding(
                        padding:  EdgeInsets.only(right: Get.width*.02),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Color(0xff646464),
                            )),
                      )
                  ),
                  cursorColor: AppColors.blueThemeColor,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Password";
                    }
                  },
                ),
                SizedBox(height: Get.height*.01,),
                Obx(() => loginController.errorMessage.value.isEmpty ?
                const SizedBox() :
                Text(loginController.errorMessage.value,style: const TextStyle(color: Colors.red),)
                ) ,
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                      onTap: () {
                        Get.to(() =>const ForgotPassword());
                      },
                      child: Text("Forgot Password ?",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: AppColors.blueThemeColor),)),
                ),
                SizedBox(height: Get.height*.02,),
                Obx(() =>  Center(
                  child: MyButton(
                    height: Get.height*.075,
                      loading: loginController.loading.value,
                      title: "LOGIN",
                      onTap1: () {
                        loginController.errorMessage.value = "" ;
                        if(_formKey.currentState!.validate()) {
                          if(loginController.loading.value){}else {
                            loginController.loginApiHit(context);
                          }
                        }
                      }
                  ),
                ),),
                SizedBox(height: Get.height*.02,),
                Center(
                  child: SizedBox(
                    width:   295,
                    height: Get.height*.075,
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffFFFFFF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/google.png",height: Get.height*.03,),
                          SizedBox(width: Get.width*.03), // Add spacing between the icon and text
                          Text("SIGN IN WITH GOOGLE",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w700),),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height*0.02,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      text: "You don't have an account yet?  ",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, color: Color(0xffCFCFCF)),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignUp()),
                          text: "Sign up",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400,color: AppColors.blueThemeColor,decoration: TextDecoration.underline,decorationColor: AppColors.blueThemeColor,),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),

      ),
    );
  }
}

