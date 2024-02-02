
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flikka/Job%20Seeker/Role_Choose/choose_role.dart';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flikka/controllers/LoginController/LoginController.dart';
import 'package:flikka/Job%20Seeker/Authentication/sign_up.dart';
import 'package:flikka/main.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../controllers/SocialLoginController/SocialLoginController.dart';
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
@override
void initState() {
  // _getAPNSToken();
   getFcmToken();
  super.initState();
  
}

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  SocialLoginController socialLoginController = Get.put(SocialLoginController()) ;

  getFcmToken() {
    print("sdfsdfdsfdsfdsafdsfdsf");
    firebaseMessaging.getToken().then((String? token) async {
      if (token == null) {
      } else {
        fcmToken = token;

        print("token=======$fcmToken");
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode()) ;
      },
      child: Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.black,
          toolbarHeight: 0,),
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
                        _handleSignIn() ;
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffFFFFFF),
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
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400,color: AppColors.blueThemeColor,decoration: TextDecoration.underline),
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

  Future<User?> _handleSignIn() async {
    try {
      // Trigger Google Sign-In
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        // The user canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      // Create GoogleAuthProvider credential using the obtained tokens
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Sign in to Firebase with the Google Auth credentials
      final UserCredential authResult = await _auth.signInWithCredential(credential);

      // Get the signed-in user
      final User? user = authResult.user;
      if(user != null) {
        CommonFunctions.showLoadingDialog(context, "Loading...") ;
      var result = await  socialLoginController.socialLoginApi("${user.email}", "${user.displayName}",
            fcmToken, "", "${user.uid}", context,user: user) ;
      if(result != null){
        Get.back() ;
      }
      }

      if (kDebugMode) {
        print("Signed in: ${user!.displayName}");
      }


      return user;
    } catch (error) {
      if (kDebugMode) {
        print("Error during Google sign-in: $error");
      }

      // Handle sign-in failure gracefully
      // You can customize this based on your app's requirements
      // For example, show an error dialog or display a message to the user
      return null;
    }
  }

}

