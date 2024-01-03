
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flikka/Job%20Seeker/Role_Choose/choose_role.dart';
import 'package:flikka/controllers/SignUPController/SignUpController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/CheckEmailSignUpController/CheckEmailSignUpController.dart';
import '../../controllers/SocialLoginController/SocialLoginController.dart';
import '../../utils/CommonFunctions.dart';
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
 String fcmToken = "";
FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
bool _isPasswordVisible = false;

Future<void> getFcmToken() async {
  // Delay for demonstration purposes; you might not need this delay
  await Future.delayed(Duration(seconds: 1));

  String? token = await FirebaseMessaging.instance.getAPNSToken();
  print(token);
}

@override
void initState() {
  super.initState();
  // Call the async function within initState
  initAsync();
}
  SocialLoginController socialLoginController = Get.put(SocialLoginController()) ;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

void initAsync() async {
  // Use a try-catch block to handle potential errors during the async operation
  try {
    await getFcmToken();
  } catch (e) {
    print("Error getting FCM token: $e");
    // Handle the error as needed
  }
}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode()) ;
      },
      child: SafeArea(
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
                        onPressed: () {
                          _handleSignIn() ;
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
                ],
              ),
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
      var result = await socialLoginController.socialLoginApi("${user.email}", "${user.displayName}",
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

      return null;
    }
  }
}

