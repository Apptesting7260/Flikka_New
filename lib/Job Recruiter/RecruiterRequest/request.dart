import 'package:flikka/Job%20Recruiter/profile/candidate_profile_sehedule_interview_meeting.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {

  ////Show dialog in save

  void _showSaveRequestDialog(BuildContext context) {
    showDialog(barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          backgroundColor: Color(0xff353535),
          title: Center(child: Text("Save Notes",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),)),
          actions: <Widget>[
            Center(child: Text("Lorem Ipsum is simply industry.",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),)),
            TextFormField(
              maxLines: 5,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                  border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none
                      // borderSide: BorderSide(color: Color(0xff1A1A1A))
                  ),
                  filled: true,
                  fillColor: Color(0xff1A1A1A),
                  hintText: "Enter Name",
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                    //borderSide: BorderSide(color: Colors.white),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      borderSide: BorderSide.none
                  ),
                  hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Color(0xffCFCFCF)),
                  //contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.038)
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
          ],
        );
      },
    );
  }
///////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width*.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.height*.03,),
                Row(
                  children: [
                    SizedBox(height: Get.height*.05,),
                    Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.05,))),
                    SizedBox(width: Get.width*.04,),
                    Text("Requests",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
                  ],
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height*.02),
                    child: Container(
                      width: Get.width,
                      height: Get.height*.60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Color(0xff353535),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           SizedBox(height: Get.height*.03,),
                            CircleAvatar(
                              radius: 32,
                              backgroundImage:  AssetImage("assets/images/icon_request_profile.png"),
                            ),
                            SizedBox(height: Get.height*.03,),
                            Text("Bred Jackson",style: Theme.of(context).textTheme.displayLarge,),
                            Text(
                                "Software engineer ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w600)
                            ),
                            SizedBox(height: Get.height*.003,),
                            Text("California, USA",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                            SizedBox(height: Get.height*.03,),
                            Row(
                              children: [
                                Image.asset("assets/images/icon work experience.png",height: Get.height*.03,color: AppColors.blueThemeColor,),
                                SizedBox(width: Get.width*.03,),
                                Text("Work experience",style: Theme.of(context).textTheme.titleSmall,),

                              ],
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: Get.width*.09),
                              child: Text("4 Years",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Color(0xffCFCFCF)),),
                            ),
                            SizedBox(height: Get.height*.03,),
                            Row(
                              children: [
                                Image.asset("assets/images/icon education.png",height: Get.height*.04,color: AppColors.blueThemeColor),
                                SizedBox(width: Get.width*.03,),
                                Text("Education",style: Theme.of(context).textTheme.titleSmall,),
                              ],
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: Get.width*.09),
                              child: Text("University of Oxford",style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w400),),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: Get.width*.09),
                              child: Text("Sep 2010 - Aug 2013 . 5 Years",style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Color(0xffCFCFCF),fontWeight: FontWeight.w400),),
                            ),
                            SizedBox(height: Get.height*.03,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyButton(
                                  width: Get.width*.32,
                                  height: Get.height*.067,
                                  title: "ACCEPT", onTap1: () {
                                    Get.to(()=>CandidateProfileseheduleMetting());
                                },),
                                SizedBox(
                                  width:   Get.width*.32,
                                  height: Get.height*.067,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xffFFFFFF),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    child: Text("REJECT",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        // barrierDismissible: false,
                                        context: context, builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                        backgroundColor: Color(0xff353535),
                                        contentPadding: EdgeInsets.zero,
                                        content:
                                        Container(
                                          alignment: Alignment.center,
                                          height:Get.height*.5,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(height: Get.height*0.001,),
                                              Center(child:
                                          Text("Save Notes",style: Theme.of(context).textTheme.displaySmall,)
                                              ),
                                              SizedBox(height: Get.height*.02,),
                                              Center(child:
                                             Text("Lorem Ipsum is simply industry.",style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),)
                                              ),
                                              SizedBox(height: Get.height*.03,),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: Get.width*.04),
                                                child: TextFormField(
                                                    maxLines: 4,
                                                    style: Theme.of(context).textTheme.bodyMedium,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Color(0xff1A1A1A),
                                                      hintText: "Enter Note",
                                                      hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Color(0xffCFCFCF)),
                                                      contentPadding: EdgeInsets.symmetric(vertical: Get.height*.03,horizontal: Get.width*.05),
                                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
                                                          borderSide: BorderSide(color: Color(0xff1A1A1A))),

                                                      enabledBorder:  OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(22),
                                                        // borderSide: BorderSide(color: Colors.white),
                                                      ),
                                                      errorBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(22.0)),
                                                        borderSide: BorderSide(color: Colors.red),
                                                      ),
                                                      disabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(22.0)),
                                                        borderSide: BorderSide(color: Color(0xff373737)),
                                                      ),

                                                    )
                                                ),
                                              ),
                                              SizedBox(height: Get.height*0.03,),
                                              MyButton(
                                                 width: Get.width*.65,
                                                title: "SAVE", onTap1: () {

                                              },)
                                            ],),
                                        ),
                                      );
                                    }
                                    );
                                  },
                                    child: Image.asset("assets/images/icon_save_request.png",height: Get.height*.06,))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },),
                SizedBox(height: Get.height*.03,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
