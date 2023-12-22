import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

class VerificationAuthorized extends StatefulWidget {
  const VerificationAuthorized({super.key});

  @override
  State<VerificationAuthorized> createState() => _VerificationAuthorizedState();
}

class _VerificationAuthorizedState extends State<VerificationAuthorized> {


  List<String> ListItems = [
    'Certificate of Incorporation',
    'Companys Cancelled Cheque',
    'Company PAN Card',
    'GST Certificate of the Company',

  ];
  ////Upload Cv////////
  String _filePath = '';
  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path!;
      });
    } else {
      // User canceled the picker
    }
  }

  void _openSelectedFile() {
    if (_filePath.isNotEmpty) {
      OpenFile.open(_filePath); // You need to import the 'open_file' package
    }
  }
  ///////////Cv////////
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width*.05),
            child: Column(
              children: [
                SizedBox(height: Get.height*.05,),
               Row(
                 children: [
                   Image.asset("assets/images/icon_back_blue.png",height: Get.height*.04,),
                   SizedBox(width: Get.width*.04,),
                   Text("verification",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),)
                 ],
               ),
                SizedBox(height: Get.height*.03,),
                Text("Verify with authorized company document(s):",style: Theme.of(context).textTheme.displayLarge,),
                SizedBox(height: Get.height*.03,),
                Container(
                  height: Get.height*.083,
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xff56B8F6).withOpacity(0.4),Color(0xff4D6FED).withOpacity(0.4)],begin: Alignment.topCenter,end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                        border: InputBorder.none,
                          hintText: "Example Company Inc.",
                          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700,fontSize: 12),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                                onTap: () {
                                  _openBottomSheet(context);
                                },
                                child: Image.asset("assets/images/Edit.png",height: Get.height*.02,)),
                          ),contentPadding: EdgeInsets.symmetric(horizontal: Get.width*.06,vertical: Get.height*.025)
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: Get.height*.035,),
                Text("Upload one of the following company document(s) to verify authenticity of the company",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                SizedBox(height: Get.height*.035,),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ListItems.length,
                  itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 3,
                          backgroundColor: Color(0xffCFCFCF),
                        ),
                        SizedBox(width: Get.width*.04,),
                        Text(ListItems[index] ??"Certificate of Incorporation",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                      ],
                    ),
                  );
                },),
                SizedBox(height: Get.height*.06,),
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(20),
                  dashPattern: [5, 5],
                  color: Color(0xffCFCFCF),
                  strokeWidth: 0.7,
                  child: GestureDetector(
                    onTap: () {
                      if (_filePath.isNotEmpty) {
                        OpenFile.open(_filePath);
                      } else {
                        _openFilePicker();
                      }
                    },
                    child: Container(
                      height: Get.height * .19,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _filePath == ''? Image.asset(
                              "assets/images/icon_upload_cv.png",width: Get.width*.075,
                              height: Get.height * .06,
                            ):Image.asset(
                              "assets/images/icon_uploded_cv.png",width: Get.width*.075,
                              height: Get.height * .06,
                            ),
                            SizedBox(width: Get.width * .04),
                            if (_filePath.isNotEmpty)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: Get.width*.02),
                                  ConstrainedBox(

                                    constraints: BoxConstraints(
                                      maxHeight: 300,
                                      maxWidth: 200
                                    ),
                                    child: Text(
                                      "File uploaded: ${_filePath.split('/').last}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(fontWeight: FontWeight.w400),

                                     overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Text(
                                "Upload",softWrap: true,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.w400),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height*.06,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: Color(0xffCFCFCF),
                    ),
                    SizedBox(width: Get.width*.04,),
                    Expanded(child: Text("Please check the name of the company in the document(s), matches with the entered name of the company. If the names do not match, it might not pass the verification process.",softWrap: true,style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),)),
                  ],
                ),
                SizedBox(height: Get.height*.017,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Image.asset("assets/images/icon_privacy.png",height: Get.height*.025,),
                    SizedBox(width: Get.width*.04,),
                    Expanded(child: Text("If the document has several pages please upload a single PDF file",softWrap: true,style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),)),
                  ],
                ),
                SizedBox(height: Get.height*.01,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: Color(0xffCFCFCF),
                    ),
                    SizedBox(width: Get.width*.04,),
                    Expanded(child: Text("If the document has several pages please upload a single PDF file",softWrap: true,style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),)),
                  ],
                ),
                SizedBox(height: Get.height*.013,),
                Text("You can redact sensitive information like salary",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                SizedBox(height: Get.height*.07,),
                MyButton(title: "SAVE", onTap1: () {

                },),
                SizedBox(height: Get.height*.1,),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'This is a bottom sheet!',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),

              ],
            ),
          ),
        );
      },
    );
}
}
