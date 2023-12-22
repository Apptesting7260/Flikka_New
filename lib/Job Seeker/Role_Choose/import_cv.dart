import 'package:flikka/Job%20Recruiter/recruiter_profile/recruiter_profile_edit.dart';
import 'package:flikka/Job%20Seeker/Role_Choose/choose_position.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImportCv extends StatefulWidget {
  final int role ;
  const ImportCv({Key? key, required this.role,}) : super(key: key);

  @override
  State<ImportCv> createState() => _ImportCvState();
}

class _ImportCvState extends State<ImportCv> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Get.height*.21,),
            Center(child: Image.asset("assets/images/cv_icon.png",height: Get.height*.2,)),
            SizedBox(height: Get.height*.05,),
            Text( widget.role == 0 ? "Create an account" : "Import Data",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: const Color(0xffFFFFFF)),),
            SizedBox(height: Get.height*.02,),
             Center(
               child: SizedBox(
                 width: Get.width*.8,
                 child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                   textAlign: TextAlign.center,
                   style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
               ),
             ),
            SizedBox(height: Get.height*.04,),
            MyButton(
              title: "IMPORT DATA FROM LINKEDIN", onTap1: () {

            },),
            SizedBox(height: Get.height*.02,),
            Center(
              child: SizedBox(
                width:   295,
                height:   56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffFFFFFF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text("IMPORT FROM CV DOCUMENT",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
                ),
              ),
            ),
            SizedBox(height: Get.height*.02,),
            // Center(
            //   child: SizedBox(
            //     width:   295,
            //     height:   56,
            //     child: ElevatedButton(
            //        clipBehavior: Clip.none,
            //       onPressed: () { print("tapped") ;
            //         print("${widget.role}") ;
            //       widget.role == 0 ?  Get.to(() => const ChoosePosition() ): Get.to(() => const RecruiterProfileEdit());
            //       },
            //       style: ElevatedButton.styleFrom(
            //         primary: Color(0xff000),
            //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            //         side: BorderSide(color: Color(0xffFFFFFF))
            //       ),
            //       child: Text("FILL MANUALLY",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF)),),
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                print("Tapped");
                print("${widget.role}") ;
                      widget.role == 0 ?  Get.to(() => const ChoosePosition() ): Get.to(() => const RecruiterProfileEdit());
              },
              child: Container(
                alignment: Alignment.center,
                width:  295,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  border: Border.all(color: Color(0xffFFFFFF)),
                 color: Color(0xff000)
                ),
                child:
                     Text(
                  "FILL MANUALLY",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFFFFFF),
                  ),
                )

              ),
            ),
            SizedBox(height: Get.height*.1,),
          ],
        ),
      ),
    ));
  }
}
