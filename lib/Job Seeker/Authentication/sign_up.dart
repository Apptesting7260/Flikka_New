
import 'package:flikka/Job%20Seeker/Role_Choose/choose_role.dart';
import 'package:flikka/controllers/SignUPController/SignUpController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/CheckEmailSignUpController/CheckEmailSignUpController.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  SignUpController SignUpControllerInstanse=Get.put(SignUpController());

  CheckEmailSignUpController checkEmailSignUpControllerInstanse=Get.put(CheckEmailSignUpController()) ;

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
                SizedBox(height: Get.height*.03,),
                Text("Full name",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                SizedBox(height: Get.height*.01,),
                TextFormField(
                  controller: SignUpControllerInstanse.nameController.value,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      filled: true,
                      fillColor: const Color(0xffFFFFFF),
                      hintText: "Enter your name",
                      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w500),
                      contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027)
                  ),
                  onFieldSubmitted: (value) {

                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Get.height*.02,),
                Text("Email",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                SizedBox(height: Get.height*.01,),
                TextFormField(
                  controller: SignUpControllerInstanse.emailController.value,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    filled: true,
                    fillColor: const Color(0xffFFFFFF),
                    hintText: "Enter your email",
                    hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w500),
                  ),
                  onFieldSubmitted: (value) {

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
                Obx(() => checkEmailSignUpControllerInstanse.errorMessage.value.isEmpty ?
                const SizedBox() :
                Text(checkEmailSignUpControllerInstanse.errorMessage.value,style: TextStyle(color: Colors.red),)
                ),
                SizedBox(height: Get.height*.02,),

                Text("Password",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                SizedBox(height: Get.height*.01,),
                TextFormField(
                  controller: SignUpControllerInstanse.passwordController.value,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    //contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.08,vertical: Get.height*.027),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Password";
                    } else if (value.length < 8) {
                      return "Password must be at least 8 characters long";
                    } else if (!value.contains(RegExp(r'[A-Z]'))) {
                      return "Password must contain at least one uppercase letter";
                    } else if (!value.contains(RegExp(r'[a-z]'))) {
                      return "Password must contain at least one lowercase letter";
                    } else if (!value.contains(RegExp(r'[0-9]'))) {
                      return "Password must contain at least one digit";
                    } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                      return "Password must contain at least one special character";
                    }
                    return null; // Return null if the password is valid
                  },
                ),

                SizedBox(height: Get.height*.05,),
                Obx(() => Center(
                  child: MyButton(
                      loading: checkEmailSignUpControllerInstanse.loading.value,
                      title: "CONTINUE",
                      onTap1: () async {
                        if(checkEmailSignUpControllerInstanse.loading.value) {} else {
                        checkEmailSignUpControllerInstanse.errorMessage.value = "" ;
                        if(_formKey.currentState!.validate()) {
                          checkEmailSignUpControllerInstanse
                              .checkEmailSignUpApiHit(
                              SignUpControllerInstanse.emailController.value.text, context);
                          SharedPreferences sp = await SharedPreferences.getInstance();
                          sp.setString("name", SignUpControllerInstanse.nameController.value.text);
                          sp.setString("email", SignUpControllerInstanse.emailController.value.text);
                          sp.setString("password", SignUpControllerInstanse.passwordController.value.text);
                        }
                        }
                        // Get.to(ChooseRole());
                      }
                  ),
                ),) ,
                SizedBox(height: Get.height*.02,),
                Center(
                  child: SizedBox(
                    width:   295,
                    height:   Get.height*.075,
                    child: ElevatedButton(
                      onPressed: () {},
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
                SizedBox(height: Get.height*0.027,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account?  ",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, color: Color(0xffCFCFCF)),
                      children: [

                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const Login()),
                          text: "Sign in",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400,color: AppColors.blueThemeColor,decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height*.04,) ,
                // DraggableScrollableSheet(
                //   initialChildSize: 0.72, // half screen
                //    minChildSize: 0.72, // half screen
                //   maxChildSize: 1, // full screen
                //   builder: (BuildContext context, ScrollController scrollController) {
                //     return Container(
                //       decoration: const BoxDecoration(
                //           borderRadius: BorderRadius.only(
                //             topRight: Radius.circular(30) ,
                //             topLeft:Radius.circular(30) , ),
                //           color: Colors.black),
                //       // color: Colors.black,
                //       child:   SingleChildScrollView(
                //         controller:scrollController ,
                //         child: Container(
                //           height: Get.height,
                //           width: Get.width,
                //           decoration: const BoxDecoration(
                //             color: Color(0xff000000),
                //             borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(33.0),
                //               topRight: Radius.circular(33.0),
                //             ),
                //           ),
                //           child: Padding(
                //             padding:  EdgeInsets.symmetric(horizontal: Get.width*.06),
                //             child: SingleChildScrollView(
                //               physics: NeverScrollableScrollPhysics(),
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   SizedBox(height: Get.height*.07,),
                //                   Text("Full name",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                //                   SizedBox(height: Get.height*.01,),
                //                   TextFormField(
                //                     controller: SignUpControllerInstanse.nameController.value,
                //                     autovalidateMode: AutovalidateMode.onUserInteraction,
                //                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
                //                     decoration: InputDecoration(
                //                         border:OutlineInputBorder(
                //                           borderRadius: BorderRadius.circular(35),
                //                         ),
                //                         filled: true,
                //                         fillColor: Color(0xffFFFFFF),
                //                         hintText: "Enter your name",
                //                         hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w500),
                //                         contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027)
                //                     ),
                //                     onFieldSubmitted: (value) {
                //
                //                     },
                //                     validator: (value) {
                //                       if (value == null || value.isEmpty) {
                //                         return 'Please enter your name';
                //                       }
                //                       return null;
                //                     },
                //                   ),
                //                   SizedBox(height: Get.height*.02,),
                //                   Text("Email",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                //                   SizedBox(height: Get.height*.01,),
                //                   TextFormField(
                //                       controller: SignUpControllerInstanse.emailController.value,
                //                     autovalidateMode: AutovalidateMode.onUserInteraction,
                //                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
                //                     decoration: InputDecoration(
                //                       contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027),
                //                       border: OutlineInputBorder(
                //                         borderRadius: BorderRadius.circular(35),
                //                       ),
                //                       filled: true,
                //                       fillColor: Color(0xffFFFFFF),
                //                       hintText: "Enter your email",
                //                       hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w500),
                //                     ),
                //                     onFieldSubmitted: (value) {
                //
                //                     },
                //                     validator: (value) {
                //                       if (value == null || value.isEmpty) {
                //                         return 'Please enter an email address';
                //                       } else if (!_isValidEmail(value)) {
                //                         return 'Please enter a valid email address';
                //                       }
                //                       return null;
                //                     },
                //                   ),
                //                   Obx(() => checkEmailSignUpControllerInstanse.errorMessage.value.isEmpty ?
                //                       const SizedBox() :
                //                   Text(checkEmailSignUpControllerInstanse.errorMessage.value,style: TextStyle(color: Colors.red),)
                //                   ),
                //                   SizedBox(height: Get.height*.02,),
                //
                //                   Text("Password",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
                //                   SizedBox(height: Get.height*.01,),
                //                   TextFormField(
                //                      controller: SignUpControllerInstanse.passwordController.value,
                //                     autovalidateMode: AutovalidateMode.onUserInteraction,
                //                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
                //                     obscureText: !_isPasswordVisible,
                //                     decoration: InputDecoration(
                //                       //contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.08,vertical: Get.height*.027),
                //                         border: OutlineInputBorder(
                //                           borderRadius: BorderRadius.circular(35),
                //                         ),
                //                         filled: true,
                //                         fillColor: Color(0xffFFFFFF),
                //                         hintText: "Enter your password",
                //                         hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w500),
                //                         contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027),
                //                         suffixIcon: Padding(
                //                           padding:  EdgeInsets.only(right: Get.width*.02),
                //                           child: IconButton(
                //                               onPressed: () {
                //                                 setState(() {
                //                                   _isPasswordVisible = !_isPasswordVisible;
                //                                 });
                //                               },
                //                               icon: Icon(
                //                                 _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                //                                 color: Color(0xff646464),
                //                               )),
                //                         )
                //                     ),
                //                     validator: (value) {
                //                       if (value!.isEmpty) {
                //                         return "Please Enter Password";
                //                       } else if (value.length < 8) {
                //                         return "Password must be at least 8 characters long";
                //                       } else if (!value.contains(RegExp(r'[A-Z]'))) {
                //                         return "Password must contain at least one uppercase letter";
                //                       } else if (!value.contains(RegExp(r'[a-z]'))) {
                //                         return "Password must contain at least one lowercase letter";
                //                       } else if (!value.contains(RegExp(r'[0-9]'))) {
                //                         return "Password must contain at least one digit";
                //                       } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                //                         return "Password must contain at least one special character";
                //                       }
                //                       return null; // Return null if the password is valid
                //                     },
                //                   ),
                //
                //                   SizedBox(height: Get.height*.05,),
                //                  Obx(() => Center(
                //                    child: MyButton(
                //                      loading: checkEmailSignUpControllerInstanse.loading.value,
                //                        title: "CONTINUE",
                //                        onTap1: () async {
                //                          checkEmailSignUpControllerInstanse.errorMessage.value = "" ;
                //                      signUpController.errorMessage.value = "" ;
                //                          if(_formKey.currentState!.validate()) {
                //                            checkEmailSignUpControllerInstanse.checkEmailSignUpApiHit(SignUpControllerInstanse.emailController.value.text);
                //                            SharedPreferences sp = await SharedPreferences.getInstance() ;
                //                            sp.setString("name", SignUpControllerInstanse.nameController.value.text) ;
                //
                //                          }
                //                          // Get.to(ChooseRole());
                //                        }
                //                    ),
                //                  ),) ,
                //                   SizedBox(height: Get.height*.02,),
                //                   Center(
                //                     child: SizedBox(
                //                       width:   295,
                //                       height:   56,
                //                       child: ElevatedButton(
                //                         onPressed: () {},
                //                         style: ElevatedButton.styleFrom(
                //                           primary: Color(0xffFFFFFF),
                //                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                //                         ),
                //                         child: Row(
                //                           mainAxisAlignment: MainAxisAlignment.center,
                //                           children: [
                //                             Image.asset("assets/images/google.png",height: Get.height*.03,),
                //                             SizedBox(width: Get.width*.03), // Add spacing between the icon and text
                //                             Text("SIGN IN WITH GOOGLE",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w700),),
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                   SizedBox(height: Get.height*0.027,),
                //                   Align(
                //                     alignment: Alignment.bottomCenter,
                //                     child: RichText(
                //                       text: TextSpan(
                //                         text: "Already have an account?  ",
                //                         style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, color: Color(0xffCFCFCF)),
                //                         children: [
                //
                //                           TextSpan(
                //                             recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const Login()),
                //                             text: "Sign in",
                //                             style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400,color: Color(0xff56B8F6),decoration: TextDecoration.underline),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}

