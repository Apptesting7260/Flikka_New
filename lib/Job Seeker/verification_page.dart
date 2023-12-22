import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flikka/widgets/google_map_widget.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationSeeker extends StatefulWidget {
  const VerificationSeeker({super.key});

  @override
  State<VerificationSeeker> createState() => _VerificationSeekerState();
}

class _VerificationSeekerState extends State<VerificationSeeker> {
  List<PlatformFile> selectedFiles = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: Image.asset('assets/images/backicon.png'),
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text("verification",style: Get.theme.textTheme.displayLarge),

        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Seeker Verification",style: Get.theme.textTheme.displayLarge,),
              SizedBox(height: Get.height*0.01,),
              Text("Upload your National ID card",style: Get.theme.textTheme.bodyMedium!.copyWith(color: Color(0xffCFCFCF)),),
              //Image.asset('assets/images/fileuploadverification.png',color: Colors.grey,)
              SizedBox(height: Get.height*0.03,),
              Center(
                child: Container(
                  height: Get.height*0.24,
                    width: Get.width, //padding of outer Container
                    child:
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(12),
                      color: Colors.grey,//color of dotted/dash line
                      strokeWidth: 0.5, //thickness of dash/dots
                      dashPattern: [1,4],
                      //dash patterns, 10 is dash width, 6 is space width
                      child: Center(
                        child:
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.black),
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf', 'doc', 'docx'],
                            );

                            if (result != null) {
                              selectedFiles.add(result.files.first);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("File Selected"),
                                    content: Text("Do you want to store the selected file?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Close the dialog
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Store the selected files or perform any other action
                                          Navigator.pop(context); // Close the dialog
                                        },
                                        child: Text("Store"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/uploadiconverify.png'),
                              SizedBox(width: Get.width * 0.02),
                              Text(
                                'National ID card',
                                style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF)),
                              ),
                            ],
                          ),
                        ),


                      ),
                    ),
                    )
                ),
              SizedBox(height: Get.height*0.06,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: SizedBox(
                  height: Get.height * 0.08,
                  //width: Get.width * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.all(0), // Set padding to 0 to allow gradient to cover the entire button
                    ),
                    onPressed: () {},
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF4D6FED),//
                            Color(0xFF56B8F6),
                          ],
                          begin: Alignment.bottomCenter, // Start point of gradient
                          end: Alignment.topCenter, // End point of gradient
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(

                        alignment: Alignment.center,
                        child: Text(
                            "Upload",
                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white)
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
