import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flikka/Job%20Recruiter/recruiter_profile/recruiter_profile_edit.dart';
import 'package:flikka/Job%20Seeker/Role_Choose/choose_position.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ImportCv extends StatefulWidget {
  final int role ;
  const ImportCv({super.key, required this.role,});

  @override
  State<ImportCv> createState() => ImportCvState();
}

class ImportCvState extends State<ImportCv> {

  late String extractedText;

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
                  onPressed: () {
                    pickCVFile() ;
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffFFFFFF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text("IMPORT FROM CV DOCUMENT",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
                ),
              ),
            ),
            SizedBox(height: Get.height*.02,),
            GestureDetector(
              onTap: () {
                if (kDebugMode) {
                  print("Tapped");
                  print("${widget.role}") ;
                }

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

  Future<void> extractTextFromPdf(String path) async {
    try {
      // Load an existing PDF document.
      final PdfDocument document = PdfDocument(inputBytes: File(path).readAsBytesSync());
      // Extract the text from all the pages.
      extractedText = PdfTextExtractor(document).extractText();
      // Dispose the document.
      document.dispose();
      if (kDebugMode) {
        print("=============$extractedText") ;
      }

      // Extract name, location, and phone number using regular expressions
      extractNameLocationPhone(extractedText);

      // Notify the widget to rebuild with the extracted text
      setState(() {});
    } catch (e) {
      // Handle PDF parsing errors
      print("Error extracting text from PDF: $e");
    }
  }

  void extractNameLocationPhone(String text) {
    // Example regular expressions (adjust based on your actual PDF structure)
    final nameRegex = RegExp(r'Name: (.+)', caseSensitive: false);
    final locationRegex = RegExp(r'Location: (.+)', caseSensitive: false);
    final phoneRegex = RegExp(r'Phone: (.+)', caseSensitive: false);

    // Extracted values
    final nameMatch = nameRegex.firstMatch(text);
    final locationMatch = locationRegex.firstMatch(text);
    final phoneMatch = phoneRegex.firstMatch(text);

    // Handle extracted values as needed
    final name = nameMatch?.group(1) ?? '';
    final location = locationMatch?.group(1) ?? '';
    final phone = phoneMatch?.group(1) ?? '';

    // Print or use the extracted information
    if (kDebugMode) {
      print("Name: $name");
      print("Location: $location");
      print("Phone Number: $phone");
    }

  }

  Future<void> pickCVFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      if (kDebugMode) {
        print(file) ;
        print(result.files.single.path!) ;
      }
      extractTextFromPdf(result.files.single.path!) ;

    }
  }
}
