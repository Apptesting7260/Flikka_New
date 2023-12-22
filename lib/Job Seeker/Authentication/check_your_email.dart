
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'login.dart';

class CheckEmail extends StatefulWidget {
  const CheckEmail({Key? key}) : super(key: key);

  @override
  State<CheckEmail> createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
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

    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(statusBarColor: Colors.white),
    // );
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    // colors: [Color(0xff56B8F6), Color(0xff4D6FED)],
                    colors: [Color(0xff2386C7), Color(0xff4D6FED)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Get.height*.08,),
                    Center(
                      child: SizedBox(
                          // width: Get.width*.8,
                          child: Text("Check Your Email",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 30))),
                    ),
                    SizedBox(height: Get.height*.02,),
                    Center(
                      child: SizedBox(
                        width: Get.width*.9,
                        child: Text("We have sent the reset password to the email address",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffFFFFFF),fontSize: 13),),
                      ),
                    ),
                    SizedBox(height: Get.height*.01,),
                    Center(
                      child: SizedBox(
                        width: Get.width*.9,
                        child: Text("example@gmail.com",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF),fontSize: 14),),
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
                    decoration: BoxDecoration(
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
                        decoration: BoxDecoration(
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
                              Center(child: Image.asset("assets/images/icon_check_email.png",height: Get.height*.16,)),
                              SizedBox(height: Get.height*.05,),
                              Center(
                                child: MyButton(title: "OPEN YOUR EMAIL",
                                    onTap1: () {

                                    }
                                ),
                              ),
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
                              SizedBox(height: Get.height*.2,),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: RichText(text: TextSpan(text: "You have not received the email?  ",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffFFFFFF)),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()..onTap=()=>(),
                                        text: "Resend",
                                        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500,color: Color(0xff56B8F6),fontSize: 15,decoration: TextDecoration.underline))
                                  ]
                                )
                                ),
                              )
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
        // body: SafeArea(
        //   child: Container(
        //     height: Get.height,
        //     width: Get.width,
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //         colors: [Color(0xff56B8F6), Color(0xff4D6FED)],
        //         begin: Alignment.topLeft,
        //         end: Alignment.bottomRight,
        //       ),
        //     ),
        //     child: Form(
        //       key: _formKey,
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           SizedBox(height: Get.height*.08,),
        //           Center(
        //             child: SizedBox(
        //                 width: Get.width*.8,
        //                 child: Text("Create an Account",style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 30))),
        //           ),
        //           SizedBox(height: Get.height*.02,),
        //           Center(
        //             child: SizedBox(
        //               width: Get.width*.8,
        //               child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        //                 textAlign: TextAlign.center,
        //                 style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffFFFFFF),fontSize: 13),),
        //             ),
        //           ),
        //           SizedBox(height: Get.height*.1,),
        //           Expanded(
        //             child: Container(
        //               height: Get.height,
        //               width: Get.width,
        //               decoration: BoxDecoration(
        //                 color: Color(0xff000000),
        //                 borderRadius: BorderRadius.only(
        //                   topLeft: Radius.circular(33.0),
        //                   topRight: Radius.circular(33.0),
        //                 ),
        //               ),
        //               child: Padding(
        //                 padding:  EdgeInsets.symmetric(horizontal: Get.width*.06),
        //                 child: SingleChildScrollView(
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       SizedBox(height: Get.height*.09,),
        //                       Text("Full name",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
        //                       SizedBox(height: Get.height*.01,),
        //                       TextFormField(
        //                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
        //                         decoration: InputDecoration(
        //                             border:OutlineInputBorder(
        //                               borderRadius: BorderRadius.circular(35),
        //                             ),
        //                             filled: true,
        //                             fillColor: Color(0xffFFFFFF),
        //                             hintText: "Enter your name",
        //                             hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w500),
        //                             contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027)
        //                         ),
        //                         onFieldSubmitted: (value) {
        //
        //                         },
        //                         validator: (value) {
        //                           if (value == null || value.isEmpty) {
        //                             return 'Please enter your name';
        //                           }
        //                           return null;
        //                         },
        //                       ),
        //                       SizedBox(height: Get.height*.02,),
        //                       Text("Email",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
        //                       SizedBox(height: Get.height*.01,),
        //                       TextFormField(
        //                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
        //                         decoration: InputDecoration(
        //                           contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027),
        //                           border: OutlineInputBorder(
        //                             borderRadius: BorderRadius.circular(35),
        //                           ),
        //                           filled: true,
        //                           fillColor: Color(0xffFFFFFF),
        //                           hintText: "Enter your email",
        //                           hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w500),
        //                         ),
        //                         onFieldSubmitted: (value) {
        //
        //                         },
        //                         validator: (value) {
        //                           if (value == null || value.isEmpty) {
        //                             return 'Please enter an email address';
        //                           } else if (!_isValidEmail(value)) {
        //                             return 'Please enter a valid email address';
        //                           }
        //                           return null;
        //                         },
        //                       ),
        //                       SizedBox(height: Get.height*.02,),
        //                       Text("Password",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
        //                       SizedBox(height: Get.height*.01,),
        //                       TextFormField(
        //                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w600),
        //                         obscureText: !_isPasswordVisible,
        //                         decoration: InputDecoration(
        //                           //contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.08,vertical: Get.height*.027),
        //                             border: OutlineInputBorder(
        //                               borderRadius: BorderRadius.circular(35),
        //                             ),
        //                             filled: true,
        //                             fillColor: Color(0xffFFFFFF),
        //                             hintText: "Enter your password",
        //                             hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w500),
        //                             contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.027),
        //                             suffixIcon: Padding(
        //                               padding:  EdgeInsets.only(right: Get.width*.02),
        //                               child: IconButton(
        //                                   onPressed: () {
        //                                     setState(() {
        //                                       _isPasswordVisible = !_isPasswordVisible;
        //                                     });
        //                                   },
        //                                   icon: Icon(
        //                                     _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        //                                     color: Color(0xff646464),
        //                                   )),
        //                             )
        //                         ),
        //                         validator: (value) {
        //                           if (value!.isEmpty) {
        //                             return "Please Enter Password";
        //                           } else if (value.length < 8) {
        //                             return "Password must be at least 8 characters long";
        //                           } else if (!value.contains(RegExp(r'[A-Z]'))) {
        //                             return "Password must contain at least one uppercase letter";
        //                           } else if (!value.contains(RegExp(r'[a-z]'))) {
        //                             return "Password must contain at least one lowercase letter";
        //                           } else if (!value.contains(RegExp(r'[0-9]'))) {
        //                             return "Password must contain at least one digit";
        //                           } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        //                             return "Password must contain at least one special character";
        //                           }
        //                           return null; // Return null if the password is valid
        //                         },
        //                       ),
        //                       SizedBox(height: Get.height*.02,),
        //                       Row(
        //                         children: [
        //                           Container(
        //                             width: Get.width*.06,
        //                             height: Get.width*.06,
        //                             child: Checkbox(
        //                               value: _isRememberMe,
        //                               onChanged: (newValue) {
        //                                 setState(() {
        //                                   _isRememberMe = newValue!;
        //                                 });
        //                               },
        //                               fillColor: MaterialStateProperty.all(Color(0xff56B8F6)),
        //                               checkColor: Colors.white,
        //                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        //                             ),
        //                           ),
        //                           SizedBox(width: Get.width*.03), // Add spacing between the checkbox and the label
        //                           Text("Remember Me",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
        //                         ],
        //                       ),
        //                       SizedBox(height: Get.height*.04,),
        //                       Center(
        //                         child: MyButton(title: "SIGN UP",
        //                             onTap1: () {
        //                               // if(_formKey.currentState!.validate()) {
        //                               //   _formKey.currentState!.save();
        //                               //    _submit();
        //                               //   Get.to(ChooseRole());
        //                               // }
        //                               Get.to(ChooseRole());
        //                             }
        //                         ),
        //                       ),
        //                       SizedBox(height: Get.height*.03,),
        //                       Center(
        //                         child: SizedBox(
        //                           width:   295,
        //                           height:   56,
        //                           child: ElevatedButton(
        //                             onPressed: () {},
        //                             style: ElevatedButton.styleFrom(
        //                               primary: Color(0xffFFFFFF),
        //                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        //                             ),
        //                             child: Row(
        //                               mainAxisAlignment: MainAxisAlignment.center,
        //                               children: [
        //                                 Image.asset("assets/images/google.png",height: Get.height*.03,),
        //                                 SizedBox(width: Get.width*.03), // Add spacing between the icon and text
        //                                 Text("SIGN IN WITH GOOGLE",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff000000),fontWeight: FontWeight.w700),),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //
        //                       SizedBox(height: Get.height*.1,),
        //                       Align(
        //                         alignment: Alignment.bottomCenter,
        //                         child: RichText(
        //                           text: TextSpan(
        //                             text: "You don't have an account yet?  ",
        //                             style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, color: Color(0xffCFCFCF)),
        //                             children: [
        //                               TextSpan(
        //                                 text: "Sign in",
        //                                 style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400,color: Color(0xff56B8F6),decoration: TextDecoration.underline),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ),
        //                       SizedBox(height: Get.height*.05,),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),

      ),
    );
  }
}

