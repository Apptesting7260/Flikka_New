

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flikka/Job%20Recruiter/ViewRecruiterJob.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../../Job Seeker/SeekerJobs/add_a_job_dropdown_section.dart';

class AddJobPageDown extends StatefulWidget {
  const AddJobPageDown({super.key});

  @override
  State<AddJobPageDown> createState() => _AddJobPageDownState();
}

class _AddJobPageDownState extends State<AddJobPageDown> {
  //********************* for edition ******************
  String uri = '';
  //********************* for job position *************
  TextEditingController jobpositionController = TextEditingController();
  void jobposition() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "change position",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: const TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: jobpositionController,
            decoration: InputDecoration(
              hintText: 'Add/change Your Position',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //********************* for job location *************
  TextEditingController joblocationController = TextEditingController();
  void joblocation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "change location",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: const TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: jobpositionController,
            decoration: InputDecoration(
              hintText: 'Add/change Your location',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //********************* for job description *************
  TextEditingController jobdescriptionController = TextEditingController();
  void jobdescription() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "change description",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: const TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: jobpositionController,
            decoration: InputDecoration(
              hintText: 'Add/change Your description',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //********************* for job requirements *************
  TextEditingController jobrequirementsController = TextEditingController();
  void jobrequirements() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "change requirements",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: const TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: jobpositionController,
            decoration: InputDecoration(
              hintText: 'Add/change Your requirements',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //********************* for job employment *************
  TextEditingController jobemploymentController = TextEditingController();
  void jobemployment() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "change employment",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: const TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: jobpositionController,
            decoration: InputDecoration(
              hintText: 'Add/change Your employment',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ********************* for job workplace *************
  TextEditingController jobworkplaceController = TextEditingController();
  void jobworkplace() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "change workplace",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: const TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: jobpositionController,
            decoration: InputDecoration(
              hintText: 'Add/change Your workplace',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ********************* for job experience *************
  TextEditingController jobexperienceController = TextEditingController();
  void jobexperience() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "change experience",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: const TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: jobpositionController,
            decoration: InputDecoration(
              hintText: 'Add/change Your experience',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ********************* for job preferred *************
  TextEditingController jobpreferredController = TextEditingController();
  void jobpreferred() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "change preferred",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: const TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: jobpositionController,
            decoration: InputDecoration(
              hintText: 'Add/change Your preferred',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ********************* for job education *************
  TextEditingController jobeducationController = TextEditingController();
  void jobeducation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "change education",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: const TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: jobpositionController,
            decoration: InputDecoration(
              hintText: 'Add/change Your education',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ********************* for job language *************
  TextEditingController joblanguageController = TextEditingController();
  void joblanguage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "change language",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: TextField(
            style: const TextStyle(color: AppColors.white, fontSize: 23),
            onChanged: (String value) {
              setState(() => uri = value);
            },
            controller: jobpositionController,
            decoration: InputDecoration(
              hintText: 'Add/change Your language',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.white, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Submit",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement comment submission logic here
                // You can use the commentController.text to access the comment text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //****************************** add file for more *********************************

  bool isPosition = false;
  bool isLocation = false;
  bool isDescription = false;
  bool isRequirements = false;
  bool isEmploymenttype = false;
  bool isTypeofworkplace = false;
  bool isWorkexperience = false;
  bool isPreferredWE = false;
  bool isEducation = false;
  bool isLanguage = false;

  List<PlatformFile> selectedFiles = [];
  String selectedEmplo = 'On-site';
  String selectedItmeS = 'Content Manager';
  String selectedItmeL = 'California';

  List<String> dropdownOptionE = [
    'On-site',
    'Work Form Home',
    'Walking',
    'Other'
  ];
  List<String> dropdownOptionS = [
    'Elearnign',
    'Programming',
    'Services',
    'Content Manager'
  ];
  List<String> dropdownOptionL = ['India', 'Pakistan', 'California', 'Kajira'];

  File? selectedImage;
  bool showCheckIcon = false;
  void _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      String? imagePath = result.files.first.path;
      if (imagePath != null) {
        setState(() {
          selectedImage = File(imagePath);
          showCheckIcon = true;
        });
      }
    }
  }

  void _clearImage() {
    setState(() {
      selectedImage = null;
      showCheckIcon = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image.asset('assets/images/icon_back_blue.png')),
          ),
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text("Add A Job",
              style: Get.theme.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w700)),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  'Post',
                  style: Get.theme.textTheme.labelMedium!
                      .copyWith(color: const Color(0xff56B8F6)),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 15),
          child: ListView(
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),

              Center(
                child: Stack(
                  children: [
                    Container(
                      height: Get.height * 0.17,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: const Color(0xff353535),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: selectedImage == null
                          ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: _selectImage,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Image.asset('assets/images/icon_gallery.png',height: Get.height*.052,),
                                  Positioned(
                                    bottom: -3,
                                    right: -3,
                                    child:Image.asset('assets/images/icon_Add_photo.png',height: Get.height*.022,)
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height:
                                MediaQuery.of(context).size.height *
                                    0.02),
                            Text(
                              "Select feature image",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: const Color(0xffCFCFCF),fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      )
                          : Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.fitWidth,
                                  height: Get.height * 0.15,
                                  width: Get.width*0.15,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Container(
                                  margin: EdgeInsets.only(left: Get.width*0.05),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF56B8F6),
                                        Color(0xFF4D6FED),
                                      ],
                                      begin: Alignment.topCenter, // Start from the top center
                                      end: Alignment.bottomCenter, // End at the bottom center
                                    ),
                                  ),
                                  child: const Icon(Icons.check,color: AppColors.white,size: 20,),
                                ),
                              )
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: InkWell(
                                onTap: _clearImage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: const Icon(
                                    Icons.close,size: 14,
                                    color: Color(0xff56B8F6),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: Get.height * 0.025,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.blackdown,
                ),
                height: Get.height * 0.08,
                width: Get.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Job Position",
                        style: Get.theme.textTheme.titleSmall!
                            .copyWith(color: AppColors.white),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPosition = !isPosition;
                                });
                              },
                              child:

                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF56B8F6),
                                      Color(0xFF4D6FED),
                                    ],
                                    begin: Alignment.topCenter, // Start from the top center
                                    end: Alignment.bottomCenter, // End at the bottom center
                                  ),
                                ),
                                child: const Icon(Icons.add,color: Color(0xff56B8F6),size: 14,),
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isPosition == true)
                AddAJobDropdownSection(
                    onPressed: (){
                      jobposition();
                    },
                    title: 'Job Position',
                    subtitle: 'Administrative Assistant',
                    imagePath: Image.asset('assets/images/editicon2.png')),
              //************************* for locatiion **************************
              SizedBox(
                height: Get.height * 0.025,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.blackdown,
                ),
                height: Get.height * 0.08,
                width: Get.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Job location",
                        style: Get.theme.textTheme.titleSmall!
                            .copyWith(color: AppColors.white),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLocation = !isLocation;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF56B8F6),
                                      Color(0xFF4D6FED),
                                    ],
                                    begin: Alignment.topCenter, // Start from the top center
                                    end: Alignment.bottomCenter, // End at the bottom center
                                  ),
                                ),
                                child: const Icon(Icons.add,color: Color(0xff56B8F6),size: 14,),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isLocation == true)
                AddAJobDropdownSection(
                    onPressed: (){
                      joblocation();
                    },
                    title: 'Job location',
                    subtitle: 'California, USA',
                    imagePath: Image.asset('assets/images/editicon2.png')),

              //************************* for Description **************************
              SizedBox(
                height: Get.height * 0.025,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.blackdown,
                ),
                height: Get.height * 0.08,
                width: Get.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Description",
                        style: Get.theme.textTheme.titleSmall!
                            .copyWith(color: AppColors.white),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isDescription = !isDescription;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF56B8F6),
                                      Color(0xFF4D6FED),
                                    ],
                                    begin: Alignment.topCenter, // Start from the top center
                                    end: Alignment.bottomCenter, // End at the bottom center
                                  ),
                                ),
                                child: const Icon(Icons.add,color: Color(0xff56B8F6),size: 14,),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isDescription == true)
                AddAJobDropdownSection(
                    onPressed: (){
                      jobdescription();
                    },
                    title: 'Description',
                    divider: const Divider(
                      thickness: 0.2,
                      color: AppColors.white,
                    ),
                    subtitle:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lectus id commodo egestas metus interdum dolor.',
                    imagePath: Image.asset('assets/images/editicon2.png')),

              //************************* for Requirements **************************
              SizedBox(
                height: Get.height * 0.025,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.blackdown,
                ),
                height: Get.height * 0.08,
                width: Get.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Requirements",
                        style: Get.theme.textTheme.titleSmall!
                            .copyWith(color: AppColors.white),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isRequirements = !isRequirements;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF56B8F6),
                                      Color(0xFF4D6FED),
                                    ],
                                    begin: Alignment.topCenter, // Start from the top center
                                    end: Alignment.bottomCenter, // End at the bottom center
                                  ),
                                ),
                                child: const Icon(Icons.add,color: Color(0xff56B8F6),size: 14,),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isRequirements == true)
                AddAJobDropdownSection(
                    onPressed: (){
                      jobrequirements();
                    },
                    subtitle: '',
                    imagePath: Image.asset('assets/images/editicon2.png'),
                    title: 'Requirements',
                    divider: const Divider(
                      thickness: 0.2,
                      color: AppColors.white,
                    ),
                    column: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('•'),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Container(
                              width: Get.width * 0.77,
                              child: Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                                style: Get.theme.textTheme.bodyLarge!
                                    .copyWith(color: const Color(0xffCFCFCF)),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('•'),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Container(
                              width: Get.width * 0.77,
                              child: Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                                style: Get.theme.textTheme.bodyLarge!
                                    .copyWith(color: const Color(0xffCFCFCF)),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('•'),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Container(
                              width: Get.width * 0.77,
                              child: Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                                style: Get.theme.textTheme.bodyLarge!
                                    .copyWith(color: const Color(0xffCFCFCF)),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              //************************* for Employment type **************************
              SizedBox(
                height: Get.height * 0.025,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.blackdown,
                ),
                height: Get.height * 0.08,
                width: Get.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Employment type",
                        style: Get.theme.textTheme.titleSmall!
                            .copyWith(color: AppColors.white),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEmploymenttype = !isEmploymenttype;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF56B8F6),
                                      Color(0xFF4D6FED),
                                    ],
                                    begin: Alignment.topCenter, // Start from the top center
                                    end: Alignment.bottomCenter, // End at the bottom center
                                  ),
                                ),
                                child: const Icon(Icons.add,color: Color(0xff56B8F6),size: 14,),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isEmploymenttype == true)
                AddAJobDropdownSection(
                    onPressed: (){
                      jobemployment();
                    },
                    title: 'Employment type',
                    subtitle: 'Full Time',
                    imagePath: Image.asset('assets/images/editicon2.png')),

              //************************* for  Type of workplace **************************
              SizedBox(
                height: Get.height * 0.025,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.blackdown,
                ),
                height: Get.height * 0.08,
                width: Get.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Type of workplace",
                        style: Get.theme.textTheme.titleSmall!
                            .copyWith(color: AppColors.white),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isTypeofworkplace = !isTypeofworkplace;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF56B8F6),
                                      Color(0xFF4D6FED),
                                    ],
                                    begin: Alignment.topCenter, // Start from the top center
                                    end: Alignment.bottomCenter, // End at the bottom center
                                  ),
                                ),
                                child: const Icon(Icons.add,color: Color(0xff56B8F6),size: 14,),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isTypeofworkplace == true)
                AddAJobDropdownSection(
                    onPressed: (){
                      jobworkplace();
                    },
                    title: 'Type of workplace',
                    subtitle: 'On-site',
                    imagePath: Image.asset('assets/images/editicon2.png')),

              //************************* for Work experience **************************
              SizedBox(
                height: Get.height * 0.025,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.blackdown,
                ),
                height: Get.height * 0.08,
                width: Get.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Work experience",
                        style: Get.theme.textTheme.titleSmall!
                            .copyWith(color: AppColors.white),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isWorkexperience = !isWorkexperience;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF56B8F6),
                                      Color(0xFF4D6FED),
                                    ],
                                    begin: Alignment.topCenter, // Start from the top center
                                    end: Alignment.bottomCenter, // End at the bottom center
                                  ),
                                ),
                                child: const Icon(Icons.add,color: Color(0xff56B8F6),size: 14,),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isWorkexperience == true)
                AddAJobDropdownSection(
                    onPressed: (){
                      jobexperience();
                    },
                    title: 'Work experience',
                    subtitle: '2 - 4 Years',
                    imagePath: Image.asset('assets/images/editicon2.png')),

              //************************* for Preferred work experience  **************************
              SizedBox(
                height: Get.height * 0.025,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.blackdown,
                ),
                height: Get.height * 0.08,
                width: Get.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Preferred work experience",
                        style: Get.theme.textTheme.titleSmall!
                            .copyWith(color: AppColors.white),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPreferredWE = !isPreferredWE;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF56B8F6),
                                      Color(0xFF4D6FED),
                                    ],
                                    begin: Alignment.topCenter, // Start from the top center
                                    end: Alignment.bottomCenter, // End at the bottom center
                                  ),
                                ),
                                child: const Icon(Icons.add,color: Color(0xff56B8F6),size: 14,),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isPreferredWE == true)
                AddAJobDropdownSection(
                    onPressed: (){
                      jobpreferred();
                    },
                    title: 'Preferred work experience',
                    subtitle: 'Lorem ipsum with Preferred work experience',
                    imagePath: Image.asset('assets/images/editicon2.png')),

              //************************* for Education **************************
              SizedBox(
                height: Get.height * 0.025,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.blackdown,
                ),
                height: Get.height * 0.08,
                width: Get.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Education",
                        style: Get.theme.textTheme.titleSmall!
                            .copyWith(color: AppColors.white),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEducation = !isEducation;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF56B8F6),
                                      Color(0xFF4D6FED),
                                    ],
                                    begin: Alignment.topCenter, // Start from the top center
                                    end: Alignment.bottomCenter, // End at the bottom center
                                  ),
                                ),
                                child: const Icon(Icons.add,color: Color(0xff56B8F6),size: 14,),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isEducation == true)
                AddAJobDropdownSection(
                    onPressed: (){
                      jobeducation();
                    },
                    title: 'Education',
                    subtitle: 'graduate',
                    imagePath: Image.asset('assets/images/editicon2.png')),

              //************************* for Language **************************
              SizedBox(
                height: Get.height * 0.025,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.blackdown,
                ),
                height: Get.height * 0.08,
                width: Get.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Language",
                        style: Get.theme.textTheme.titleSmall!
                            .copyWith(color: AppColors.white),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLanguage = !isLanguage;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60.0),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF56B8F6),
                                      Color(0xFF4D6FED),
                                    ],
                                    begin: Alignment.topCenter, // Start from the top center
                                    end: Alignment.bottomCenter, // End at the bottom center
                                  ),
                                ),
                                child: const Icon(Icons.add,color: Color(0xff56B8F6),size: 14,),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isLanguage == true)
                AddAJobDropdownSection(
                    onPressed: (){
                      joblanguage();
                    },
                    title: 'Language',
                    subtitle: 'Hindi - English',
                    imagePath: Image.asset('assets/images/editicon2.png')),

              SizedBox(
                height: Get.height * 0.05,
              ),
              Center(
                child: MyButton(
                    style: Get.theme.textTheme.bodyMedium!
                        .copyWith(color: AppColors.white),
                    title: 'Continue',
                    onTap1: () {
                      // Get.to(()=>const ViewRecruiterJob());
                    }),
              ),
              SizedBox(
                height: Get.height * 0.07,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
