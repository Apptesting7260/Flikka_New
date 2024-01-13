import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/controllers/AddJobController/AddJobController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_trimmer/video_trimmer.dart';
import '../../controllers/SeekerChoosePositionGetController/SeekerChoosePositionGetController.dart';
import '../../controllers/ViewLanguageController/ViewLanguageController.dart';
import '../../models/SearchPlaceModel/SearchPlaceModel.dart';
import '../../models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../utils/Constants.dart';
import '../../utils/MultiSelectField.dart';
import 'package:http/http.dart' as http;

import '../RecruiterRequiredSkills/required_skills.dart';


class AddAJobPage extends StatefulWidget {
  final RecruiterJobsData? recruiterJobsData ;
  const AddAJobPage({super.key, this.recruiterJobsData});

  @override
  State<AddAJobPage> createState() => _AddAJobPageState();
}

class _AddAJobPageState extends State<AddAJobPage> {

  final _formKey = GlobalKey<FormState>();
  var isLoading = false;

  bool submitted = false ;
  var qualification ;

  final List<String> itemsEmp = ['full-time','part-time','contract','temporary', 'internship', 'fresher' ,];
  dynamic employmentType;

  var jobTypeTitle;
  String? jobPosition ;

  final List<String> itemsExp = [
    'on-site','remote','hybrid'
  ];
  dynamic workplaceType ;

  final List<String> itemQualificaton = [
    'bachelor degree','master degree','12th pass', 'diploma', 'doctoral degree', '10th pass', 'm. phil'
  ];
  String? qualificatonType;
  List<String> years = ["1","2","3","4","5","6","7","8","9","10",
    "11","12","13","14","15","16","17","18","19","20"] ;

  List<String> months = ["01","02","03","04","05","06","07","08","09","10", "11"] ;

  List? languageList = [];
  String? yearValue ;
  String? monthsValue ;

 AddJobController addJobController = Get.put(AddJobController()) ;
  SeekerChoosePositionGetController seekerChoosePositionGetController = Get.put(SeekerChoosePositionGetController());

  ViewLanguageController viewLanguageController = Get.put(ViewLanguageController()) ;

  Future<void> _openVideoPickerDialogAddJob() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide.none),
          title: Center(
            child: Text(
              'Please choose video',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyButton(
                    width: Get.width * .25,
                    height: Get.height * .05,
                    title: "Camera",
                    onTap1: () {
                      _startRecording(ImageSource.camera);
                      Get.back();
                    },
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyButton(
                    width: Get.width * .25,
                    height: Get.height * .05,
                    title: "Gallery",
                    onTap1: () {
                      _startRecording(ImageSource.gallery);
                      Get.back();
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _startRecording(ImageSource source) async {
    final video = await ImagePicker().pickVideo(
        source: source,
      maxDuration: const Duration(seconds: 15), ) ;
    if (video != null) {
      await trimVideo(video.path);
    }
  }

  Future<String?> trimVideo(String path) async {
    CommonFunctions.showLoadingDialog(context, "Uploading") ;
    final Trimmer trimmer = Trimmer();
    String? trimmedPath;

    // Step 1: Trim the video
    await trimmer.loadVideo(videoFile: File(path));

    await trimmer.saveTrimmedVideo(
      startValue: 0,
      endValue: 15000,
      onSave: (String? outputPath) async {
        print("$outputPath outputpath------------------------------------------------------") ;

        if (outputPath != null) {
          setState(() {
            videoFilePath = outputPath ;
            Get.back() ;
          });
          // final MediaInfo? info = await VideoCompress.compressVideo(
          //   trimmedPath!,
          //   quality: VideoQuality.MediumQuality,
          //   deleteOrigin: false,
          // );

          // if (outputPath?.path != null && info?.path?.isNotEmpty == true) {
          //   // The compressed video path
          //   String compressedPath = info!.path!;
          //   print('Compressed video path: $compressedPath');
          //
          //   setState(() {
          //     videoFilePath = info.path!;
          //     if (kDebugMode) {
          //       print("this is file size ================== ${info.filesize}");
          //     }
          //   });
          //
          //   return compressedPath;
          // } else {
          //   print('Video compression failed');
          //   return null;
          // }
        } else {
          print('Video trimming failed');
          return null;
        }
      },
    );

    // Step 2: Compress the trimmed video

  }

  // Future<void> compressVideo(String inputPath) async {
  //   CommonFunctions.showLoadingDialog(context, "Uploading") ;
  //   final MediaInfo? info = await VideoCompress.compressVideo(
  //     inputPath,
  //     quality: VideoQuality.MediumQuality,
  //     deleteOrigin: false,
  //   );
  //
  //   if (kDebugMode) {
  //     print('Compressed video path: ${info?.path}');
  //   }
  //   if(info?.path != null && info?.path?.length != 0 ) {
  //     setState(() {
  //       videoFilePath = info!.path! ;
  //       if (kDebugMode) {
  //         print("this is file size ================== ${info.filesize}") ;
  //       }
  //     });
  //     Get.back() ;
  //   }
  // }
  String videoFilePath = '';

  TextEditingController jobTitleController = TextEditingController() ;
  TextEditingController jobPositionController = TextEditingController() ;
  TextEditingController specializationController = TextEditingController() ;
  TextEditingController jobLocationController = TextEditingController() ;
  TextEditingController jobDescriptionController = TextEditingController() ;
  TextEditingController jobRequirementController = TextEditingController() ;
  TextEditingController educationController = TextEditingController() ;
  TextEditingController experienceController = TextEditingController() ;
  TextEditingController preferredExperienceController = TextEditingController() ;

  FocusNode jobTypeFocus = FocusNode() ;
  FocusNode typeOfWorkPlaceFocus = FocusNode() ;


  List<Location> locations = [] ;
  double? lat;
  double? long;
  List<Predictions> searchPlace = [];


  @override
  void initState() {
    seekerChoosePositionGetController.seekerGetPositionApi(false) ;
    viewLanguageController.viewLanguageApi() ;
    LanguageSelectorState.languages = [] ;
    if(widget.recruiterJobsData != null) {
      jobTitleController.text = widget.recruiterJobsData?.jobTitle ?? "" ;
      specializationController.text = widget.recruiterJobsData?.specialization ?? "" ;
      jobLocationController.text = widget.recruiterJobsData?.jobLocation ?? "" ;
      jobDescriptionController.text =   CommonFunctions.parseHtmlAndAddNewline(widget.recruiterJobsData?.description ?? "") ?? "" ;
          // parse(parse(widget.recruiterJobsData?.description ?? "").body?.text).documentElement?.text ?? "" ;

      jobRequirementController.text = CommonFunctions.parseHtmlAndAddNewline(widget.recruiterJobsData?.requirements ?? "") ?? "" ;
      educationController.text = widget.recruiterJobsData?.education ?? "" ;
      experienceController.text = widget.recruiterJobsData?.workExperience ?? "" ;
      preferredExperienceController.text = widget.recruiterJobsData?.preferredWorkExperience ?? "" ;
      jobTypeTitle = widget.recruiterJobsData?.jobPosition ;
      if(widget.recruiterJobsData?.employmentType.toString().toLowerCase() != "null") {
        employmentType = widget.recruiterJobsData?.employmentType ;
      }
      if(widget.recruiterJobsData?.typeOfWorkplace.toString().toLowerCase() != "null") {
        workplaceType = widget.recruiterJobsData?.typeOfWorkplace ;
      }
      if(widget.recruiterJobsData?.education != null) {
        qualificatonType = widget.recruiterJobsData?.education ;
        debugPrint(qualificatonType) ;
      }

      if(widget.recruiterJobsData?.jobPositions.toString().toLowerCase() != "null") {
        jobPosition = widget.recruiterJobsData?.jobPositions ;
      }
      if(widget.recruiterJobsData?.language != null) {
        languageList = widget.recruiterJobsData?.language?.map((e) => e.languages).toList() ?? [];
        LanguageSelectorState.languages = widget.recruiterJobsData?.language?.map((e) => e.id.toString()).toList() ?? [];
      }
      if(widget.recruiterJobsData?.workExperience != null && widget.recruiterJobsData?.workExperience?.length != 0){
          var experience = widget.recruiterJobsData?.workExperience?.split(".");
          if(experience?.length == 2) {
            if( experience?[0] != null && experience?[0].length != 0 && experience?[0].toString() != "0") {
              yearValue = experience?[0];
            }
            if( experience?[1] != null && experience?[1].length != 0 && experience?[1].toString() != "00") {
              monthsValue = experience?[1] ;
            }
        }
      }

    }
    super.initState();
  }

  final ScrollController scrollController =ScrollController() ;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (viewLanguageController.rxRequestStatus.value) {
        case Status.LOADING:
          return const
          Scaffold(body: Center(child: CircularProgressIndicator()),);

        case Status.ERROR:
          if (viewLanguageController.error.value ==
              'No internet') {
            return InterNetExceptionWidget(
              onPress: () {},
            );
          } else {
            return Scaffold(body: GeneralExceptionWidget(
                onPress: () {}));
          }
        case Status.COMPLETED:
      return
      Obx( () => seekerChoosePositionGetController.rxRequestStatus.value == Status.LOADING ?
    const Center(child: CircularProgressIndicator(),) :
       Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 10),
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Image.asset('assets/images/icon_back_blue.png')),
            ),
            elevation: 0,
            title: Text( widget.recruiterJobsData != null ? "Edit" : "Add A Job",style: Get.theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
            actions: [
              widget.recruiterJobsData != null ?
            TextButton(onPressed: (){
              Get.to( () => RequiredSkills(recruiterJobsData: widget.recruiterJobsData,) , arguments: {"job_id" :widget.recruiterJobsData?.id  });
            }, child: Text('Skip',style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.blueThemeColor),))
         : const SizedBox() ],
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 15),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height*0.03,),
                    Center(
                      child: Stack(
                          children:[
                            GestureDetector(
                              onTap: () {
                                _openImagePickerDialog();
                              },
                              child: Container(
                                height: Get.height*0.30,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: const Color(0xff353535),
                                    borderRadius: BorderRadius.circular(22)
                                ),
                                child: widget.recruiterJobsData?.featureImg != null && imgFile?.path == null ?
                                    CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: "${widget.recruiterJobsData?.featureImg}" ,
                                      placeholder: (context , url) => const Center(child: CircularProgressIndicator(),),)
                                    :  imgFile?.path == null ?
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                InkWell(
                                  onTap: () async {
                                    _openImagePickerDialog();
                                    print("This is imgfile ${imgFile?.path}");
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                      children:[
                                        Image.asset('assets/images/icon_gallery.png',height: Get.height*.052,color: AppColors.blueThemeColor,),
                                        Positioned(
                                            bottom: -2,
                                            right: -2,
                                            child: Image.asset('assets/images/icon_Add_photo.png',height: Get.height*.021,)
                                        ),
                                      ] ),
                                ),
                                SizedBox(height: Get.height*0.02,),
                                Text("Select feature image",style: Get.theme.textTheme.bodySmall!.copyWith(color: Color(0xffCFCFCF)),),
                                    ],
                                  ) :
                                    Image.file(imgFile! , fit: BoxFit.cover,),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: imgFile == null ?
                                  const SizedBox() :
                              IconButton(onPressed: () {
                                _openImagePickerDialog();
                              }, icon: const Icon(Icons.edit,color: Colors.white,size: 28,)),
                            ),
                          ]
                      ),),
                    Obx(() => addJobController.featureImageError.value.isEmpty ?
                    const SizedBox() :
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(addJobController.featureImageError.value,style: TextStyle(color: Colors.red),))
                    ) ,
                    SizedBox(height: Get.height*0.03,),
                    Text(
                      "Add your short video here",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(20),
                      dashPattern: const [5, 5],
                      color: const Color(0xffCFCFCF),
                      strokeWidth: 0.7,
                      child: GestureDetector(
                        onTap: () {
                          _openVideoPickerDialogAddJob() ;
                        },
                        child: Container(
                          height: Get.height * .15,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/icon_upload_cv.png",
                                  width: Get.width * .07,
                                  height: Get.height * .06,
                                ),
                                SizedBox(width: Get.width * .0),
                                videoFilePath.isNotEmpty ?
                                SizedBox(
                                  width: Get.width * .6,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(width: Get.width * .02),
                                      Flexible(
                                        child: Text(
                                          "File uploaded: ${videoFilePath.split('/').last}",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                              ?.copyWith(
                                              fontWeight:
                                              FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ) :
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 4),
                                  child: Text(
                                    "Upload Video",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height*0.04,),
                    Text('Job Title',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: jobTitleController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(color: Color(0xff373737))
                        ),
                        fillColor: const Color(0xff373737),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          //borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          borderSide: BorderSide(color: Color(0xff373737)),
                        ),
                        hintText: 'Add job title ',
                        hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),
                      ),
                      onFieldSubmitted: (value) {

                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: Get.height*0.03,),
                    Text('Job position',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    Container(
                      alignment: Alignment.center,
                      padding:  EdgeInsets.only(left: Get.width *0.04,right: Get.width *0.05 ,top: Get.height*.0065,bottom: Get.height*.0065),
                      decoration: BoxDecoration(
                        color: const Color(0xff373737),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Center(
                        child:
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            alignment: Alignment.centerLeft,
                            borderRadius: BorderRadius.circular(20),
                            isExpanded: true,
                            value: jobPosition,
                            hint:  Text(
                              'Add Position',
                              style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),
                              overflow: TextOverflow.ellipsis,
                            ),
                            items: seekerChoosePositionGetController.seekerChoosePositionGetList.value.data
                                ?.map((item) => DropdownMenuItem(
                              value: item.positions,
                              onTap: () {
                                setState(() {
                                  jobTypeTitle = item.id.toString() ;
                                  jobPosition = item.positions ;
                                });
                                },
                              child: Text(
                                "${ item.positions}",
                                style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )).toList(),
                            elevation: 2,
                            onChanged: (String? value) {  },
                          ),

                        ),
                      ),
                    ),
                    Obx(() => addJobController.jobPositionErrorMessage.value.isEmpty ?
                    const SizedBox() :
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(addJobController.jobPositionErrorMessage.value,style: TextStyle(color: Colors.red),))
                    ) ,
                    SizedBox(height: Get.height*0.03,),
                    Text('Specialization',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: specializationController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(color: Color(0xff373737))
                        ),
                        fillColor: Color(0xff373737),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          //borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          borderSide: BorderSide(color: Color(0xff373737)),
                        ),
                        hintText: 'Add Specialization',
                        hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),
                      ),
                      onFieldSubmitted: (value) {

                      },
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'This field is empty';
                      //   }
                      //   return null;
                      // },

                    ),
                    SizedBox(height: Get.height*0.03,),
                    Text('Job location',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: jobLocationController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                          border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: BorderSide(color: Color(0xff373737))
                          ),
                          fillColor: Color(0xff373737),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                          enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            //borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                            borderSide: BorderSide(color: Color(0xff373737)),
                          ),
                          hintText: 'Add location',
                          hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF))
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (jobLocationController.text.isEmpty) {
                          }
                        });
                        searchAutocomplete(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter job location';
                        }
                      },
                    ),
                    Visibility(
                      visible: jobLocationController.text.isNotEmpty,
                      child: SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: searchPlace.length,
                            itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                setState(() {
                                  jobLocationController.text = searchPlace[index].description ?? "";
                                  _getLatLang();
                                  setState(() {
                                    searchPlace.clear();
                                  });
                                });
                              },
                              horizontalTitleGap: 0,
                              title: Text(
                                searchPlace[index].description ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )),
                      ),
                    ),
                    SizedBox(height: Get.height*0.03,),
                    Text('Description',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: jobDescriptionController,
                        maxLines: 5,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xff373737),
                          hintText: "Add description",
                            hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),
                          contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(22),
                              borderSide: const BorderSide(color: Color(0xff373737))),

                          enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            // borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22.0)),
                            borderSide: BorderSide(color: Color(0xff373737)),
                          ),

                        ) ,
                      onFieldSubmitted: (value) {

                      },
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'This field is empty';
                      //   }
                      //   return null;
                      // },
                    ),
                    SizedBox(height: Get.height*0.03,),
                    Text('Requirements',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: jobRequirementController,
                        maxLines: 5,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff373737),
                          hintText: "Add requirements",
                            hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),
                          contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(22),
                              borderSide: BorderSide(color: Color(0xff373737))),
                          enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            // borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22.0)),
                            borderSide: BorderSide(color: Color(0xff373737)),
                          ),

                        ) ,
                      onFieldSubmitted: (value) {

                      },
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'This field is empty';
                      //   }
                      //   return null;
                      // },
                    ),
                    SizedBox(height: Get.height*0.03,),
                    Text('Job Type',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    Center(
                      child:
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          focusNode: jobTypeFocus ,
                          isExpanded: true,
                          hint:  Text(
                            'Select job type',
                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          items: itemsEmp
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: employmentType,
                          onChanged: (String? value) {
                            setState(() {
                              employmentType = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: Get.height*0.08,
                            width: double.infinity,
                            padding:  EdgeInsets.symmetric(horizontal: Get.width*.04, ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),

                              color: Color(0xff353535),
                            ),
                            elevation: 2,
                          ),
                          iconStyleData:  IconStyleData(
                            icon: Image.asset('assets/images/arrowdown.png'),
                            iconSize: 14,
                            iconEnabledColor: Colors.yellow,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: Get.height*0.35,
                            width: Get.width*0.902,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: const Color(0xff353535),
                            ),
                            offset: const Offset(5, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius:  const Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility: MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height*0.042,),
                    Text('Type of workplace',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    Center(
                      child:
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          focusNode: typeOfWorkPlaceFocus,
                          isExpanded: true,
                          hint:  Text(
                            'Select workplace',
                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          items: itemsExp
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: workplaceType,
                          onChanged: (String? value) {
                            setState(() {
                              workplaceType = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: Get.height*0.08,
                            width: double.infinity,
                            padding:  EdgeInsets.symmetric(horizontal: Get.width*.04, ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),

                              color: const Color(0xff353535),
                            ),
                            elevation: 2,
                          ),
                          iconStyleData:  IconStyleData(
                            icon: Image.asset('assets/images/arrowdown.png'),
                            iconSize: 14,
                            iconEnabledColor: Colors.yellow,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: Get.height*0.35,
                            width: Get.width*0.902,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: const Color(0xff353535),
                            ),
                            offset: const Offset(5, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius:  const Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility: MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height*0.042,),
                    Text('Work experience',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint:  Text(
                              'years',
                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                            items: years.map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )).toList(),
                            value: yearValue,
                            onChanged: (String? value) {
                              setState(() {
                                yearValue = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: Get.height*0.08,
                              width: Get.width*0.4,
                              padding:  EdgeInsets.symmetric(horizontal: Get.width*.04, ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),

                                color: const Color(0xff353535),
                              ),
                              elevation: 2,
                            ),
                            iconStyleData:  IconStyleData(
                              icon: Image.asset('assets/images/arrowdown.png'),
                              iconSize: 14,
                              iconEnabledColor: Colors.yellow,
                              iconDisabledColor: Colors.grey,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: Get.height*0.35,
                              width: Get.width*0.35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: const Color(0xff353535),
                              ),
                              offset: const Offset(5, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius:  const Radius.circular(40),
                                thickness: MaterialStateProperty.all<double>(6),
                                thumbVisibility: MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint:  Text(
                              'months',
                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                            items: months.map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )).toList(),
                            value: monthsValue,
                            onChanged: (String? value) {
                              setState(() {
                                monthsValue = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: Get.height*0.08,
                              width: Get.width*0.4,
                              padding:  EdgeInsets.symmetric(horizontal: Get.width*.04, ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),

                                color: const Color(0xff353535),
                              ),
                              elevation: 2,
                            ),
                            iconStyleData:  IconStyleData(
                              icon: Image.asset('assets/images/arrowdown.png'),
                              iconSize: 14,
                              iconEnabledColor: Colors.yellow,
                              iconDisabledColor: Colors.grey,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: Get.height*0.35,
                              width: Get.width*0.35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: const Color(0xff353535),
                              ),
                              offset: const Offset(5, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius:  const Radius.circular(40),
                                thickness: MaterialStateProperty.all<double>(6),
                                thumbVisibility: MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height*0.042,),
                    Text('Preferred work experience',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: preferredExperienceController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                          border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: const BorderSide(color: Color(0xff373737))
                          ),
                          fillColor: const Color(0xff373737),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: Get.width *0.04,vertical: Get.height*.027),
                          enabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            //borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35.0)),
                            borderSide: BorderSide(color: Color(0xff373737)),
                          ),
                          hintText: 'Add Preferred work experience',
                          hintStyle:  Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF))
                      ),
                      onFieldSubmitted: (value) {

                      },
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'This field is empty';
                      //   }
                      //   return null;
                      // },

                    ),
                    SizedBox(height: Get.height*0.042,),
                    Text('Qualification',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint:  Text(
                            qualificatonType ?? 'Select qualification',
                            style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          items: itemQualificaton
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              qualificatonType = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: Get.height*0.08,
                            width: double.infinity,
                            padding:  EdgeInsets.symmetric(horizontal: Get.width*.04, ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),

                              color: const Color(0xff353535),
                            ),
                            elevation: 2,
                          ),
                          iconStyleData:  IconStyleData(
                            icon: Image.asset('assets/images/arrowdown.png'),
                            iconSize: 14,
                            iconEnabledColor: Colors.yellow,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: Get.height*0.35,
                            width: Get.width*0.902,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: const Color(0xff353535),
                            ),
                            offset: const Offset(5, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius:  const Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility: MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height*0.042,),
                    Text('Language',style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(height: Get.height*0.01,),
                    LanguageSelector(selectedLanguageList: languageList,languageList: viewLanguageController.viewLanguageData.value.languages,),
                    SizedBox(height: Get.height*0.065,),

                    Obx( () =>
                       Center(
                        child: MyButton(
                          loading: addJobController.loading.value,
                            title: widget.recruiterJobsData != null ? "Update" : 'Continue', onTap1: addJobController.submitted.value ? () {} : (){
                          addJobController.featureImageError.value = "" ;
                          addJobController.jobTypeErrorMessage.value = "" ;
                          addJobController.typeOfWorkPlaceErrorMessage.value = "" ;
                          addJobController.jobPositionErrorMessage.value = "" ;
                          addJobController.qualificationErrorMessage.value = "" ;
                          addJobController.languageErrorMessage.value = "" ;
                          // if( widget.recruiterJobsData?.featureImg == null && imgFile == null) {
                          //   addJobController.featureImageError.value = "Please select image" ;
                          //   scrollController.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
                          // }

                          if(_formKey.currentState!.validate()) {
                            if (jobPosition == null) {
                              addJobController.jobPositionErrorMessage.value = "Please select job position";
                              scrollController.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
                            }
      // else if (employmentType == null) {
                            //   addJobController.jobTypeErrorMessage.value = "Please select job type";
                            //   scrollController.animateTo(jobTypeFocus.context!.size!.height  + Get.height*.65, duration: Duration(milliseconds: 100), curve: Curves.easeOut) ;
                            // } else if (workplaceType == null) {
                            //   addJobController.typeOfWorkPlaceErrorMessage.value = "Please select type of workplace";
                            //   scrollController.animateTo(typeOfWorkPlaceFocus.context!.size!.height  + Get.height*.75, duration: Duration(milliseconds: 100), curve: Curves.easeOut) ;
                            // } else if (qualificatonType == null) {
                            //   addJobController.qualificationErrorMessage.value =  "Please select qualification" ;
                            // } else if(LanguageSelectorState.languages.isEmpty) {
                            //   addJobController.languageErrorMessage.value = "Please select language" ;
                            // }
                            else {
                              var formattedDescriptionText = CommonFunctions.changeToHTML(jobDescriptionController.text ?? "") ;
                              var formattedRequirementText = CommonFunctions.changeToHTML(jobRequirementController.text ?? "") ;
                              debugPrint(formattedDescriptionText) ;
                              debugPrint(formattedRequirementText) ;
                              // String formattedDescriptionText = jobDescriptionController.text ;
                              // List<String> descriptionPara = formattedDescriptionText.split('\n');
                              // List<String> formattedDescription = descriptionPara.map((line) => line.isEmpty ? '<p>&nbsp;</p>'  : '<p>$line</p>').toList();
                              //  formattedDescriptionText = formattedDescription.join('');
                              if(addJobController.loading.value) {} else {
                                addJobController.addJobApi(
                                videoFilePath ,
                                  imgFile?.path,
                                  jobTypeTitle,
                                  jobTitleController.text,
                                  specializationController.text,
                                  jobLocationController.text,
                                  formattedDescriptionText,
                                  formattedRequirementText,
                                  employmentType,
                                  workplaceType,
                                  yearValue,
                                  monthsValue,
                                  preferredExperienceController.text,
                                  qualificatonType.toString(),
                                  LanguageSelectorState.languages,
                                recruiterJobsData: widget.recruiterJobsData ,
                                jobId: widget.recruiterJobsData?.jobsDetail?.jobId
                              );
                              }
                            }
                          }else{
                            scrollController.animateTo(Get.height *.5, duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
                          }
                                // Get.to(()=> const RequiredSkills());
                        }),
                      ),
                    ),
                    SizedBox(height: Get.height*0.08,),
                  ],
                ),
              ),
            ),
          ),
        )
                )
      );
      }
    }
    );
  }

  Future<void> _openImagePickerDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          title:Center(
            child: Text(
              'Please choose image',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,fontSize: 18),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                width: Get.width*.25,
                height: Get.height*.05,
                title: "Camera", onTap1: () {
                  Get.back() ;
                _pickImage(ImageSource.camera);
              },),
              const SizedBox(width: 10,) ,
              MyButton(
                width: Get.width*.25,
                height: Get.height*.05,
                title: "Gallery", onTap1: () {
                Get.back() ;
                  _pickImage(ImageSource.gallery);
              },),
            ],
          ),
        );
      },
    );
  }

  final imgPicker = ImagePicker();
  final featureImageCropper = ImageCropper() ;
  File? imgFile;
  File? profilePath;
  Future<void> _pickImage(abc) async {
    var imgCamera = await imgPicker.pickImage(source: abc);
    if(imgCamera != null) {
      final croppedImage = await featureImageCropper.cropImage(
          sourcePath: imgCamera.path,
        aspectRatio: const CropAspectRatio(ratioX: 1.5, ratioY: 1),
        compressQuality: 60,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              hideBottomControls: true,
              toolbarColor: AppColors.blueThemeColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          IOSUiSettings(title: 'Cropper', aspectRatioLockEnabled: true,),
        ],// Adjust compression quality as needed
      );
      setState(() {
        imgFile = File(croppedImage!.path) ;
        profilePath = File(croppedImage.path) ;
        print(imgFile) ;
      });
    }
  }

  void searchAutocomplete(String query) async {
    print("calling");
    Uri uri = Uri.https(
        "maps.googleapis.com",
        "maps/api/place/autocomplete/json",
        {"input": query, "key": Constants.googleAPiKey});
    print(uri);
    try {
      final response = await http.get(uri);
      print(response.statusCode);
      final parse = jsonDecode(response.body);
      print(parse);
      if (parse['status'] == "OK") {
        setState(() {
          SearchPlaceModel searchPlaceModel = SearchPlaceModel.fromJson(parse);
          searchPlace = searchPlaceModel.predictions!;

          print(searchPlace.length);
        });
      }
    } catch (err) {}
  }

  Future<void> _getLatLang() async {
    final query = jobLocationController.text;
    locations = await locationFromAddress(query);

    setState(() {
      var first = locations.first;
      lat = first.latitude;
      long = first.longitude;
      print("*****lat ${lat} : ${long}**********long");
    });
  }
}
