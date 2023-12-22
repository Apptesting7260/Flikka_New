import 'dart:convert';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/controllers/CreateUpdateRecruiterProfileController/CreateUpdateRecruiterProfileController.dart';
import 'package:flikka/controllers/SelectIndustryController/SelectIndustryController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/ViewRecruiterProfileModel/ViewRecruiterProfileModel.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/CommonWidgets.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/SearchPlaceModel/SearchPlaceModel.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import 'package:http/http.dart' as http;
import '../../utils/Constants.dart';

class RecruiterProfileEdit extends StatefulWidget {
  final ViewRecruiterProfileModel? profileModel ;
  const RecruiterProfileEdit({super.key, this.profileModel});

  @override
  State<RecruiterProfileEdit> createState() => _RecruiterProfileEditState();
}

class _RecruiterProfileEditState extends State<RecruiterProfileEdit> {
  var companyNameController = TextEditingController();
  var companyLocationController = TextEditingController();
  var addBioController = TextEditingController();
  var contactPersonNameController = TextEditingController();
  //var homeDescriptionController = TextEditingController();
  var websiteLinkController = TextEditingController();
  var aboutDescriptionController = TextEditingController();
  var specializationController = TextEditingController();

  File? coverImage;
  File? profileImage;
  /////Upload cover image dialog////////////
  Future<void> _openCoverImagePickerDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          title: Center(
            child: Text(
              'Please choose image',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                width: Get.width * .25,
                height: Get.height * .05,
                title: "Camera",
                onTap1: () {
                  _pickImage(ImageSource.camera);
                  Get.back() ;
                },
              ),
              const SizedBox(
                width: 10,
              ),
              MyButton(
                width: Get.width * .25,
                height: Get.height * .05,
                title: "Gallery",
                onTap1: () {
                  _pickImage(ImageSource.gallery);
                  Get.back() ;
                },
              ),
            ],
          ),
        );
      },
    );
  }

  late File? _pickedImage;
  final imgPicker = ImagePicker();
  final coverImageCropper = ImageCropper();
  Future<void> _pickImage(abc) async {
    var imgCamera = await imgPicker.pickImage(source: abc);

    if (imgCamera != null) {
      final croppedImage = await coverImageCropper.cropImage(
        sourcePath: imgCamera.path,
        aspectRatio: const CropAspectRatio(ratioX: 1.5, ratioY: 1),
        // Adjust aspect ratio as needed
        compressQuality: 60,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              hideBottomControls: true,
              toolbarColor: AppColors.blueThemeColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Cropper',aspectRatioLockEnabled: true
          ),
        ], // Adjust compression quality as needed
      );

      setState(() {
        coverImage = File(croppedImage!.path);
        print(coverImage?.path);
      });
    }
  }


  Future<void> _openProfileImagePickerDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          title: Center(
            child: Text(
              'Please choose image',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                width: Get.width * .25,
                height: Get.height * .05,
                title: "Camera",
                onTap1: () {
                  _pickImagee(ImageSource.camera);
                },
              ),
              const SizedBox(
                width: 10,
              ),
              MyButton(
                width: Get.width * .25,
                height: Get.height * .05,
                title: "Gallery",
                onTap1: () {
                  _pickImagee(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  dynamic industry;
  String? companySize;
  DateTime? founded;

  late File? _pickedCoverImage;
  final imagePicker = ImagePicker();
  final profileImageCropper = ImageCropper();
  Future<void> _pickImagee(abc) async {
    var imgCamera = await imgPicker.pickImage(source: abc);
    if (imgCamera != null) {
      final croppedImage = await profileImageCropper.cropImage(
        sourcePath: imgCamera.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        // Adjust aspect ratio as needed
        compressQuality: 60,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              hideBottomControls: true,
              toolbarColor: AppColors.blueThemeColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Cropper',aspectRatioLockEnabled: true
          ),
        ], // Adjust compression quality as needed
      );

      setState(() {
        profileImage = File(croppedImage!.path);
        print(profileImage);
      });
      Get.back();
    }
  }
  ////////////profile image/////////////

  final List<String> itemsC = [
    'Social Marketing',
    'Programming',
    'Health Finance',
    'Content Manager'
  ];
  String? socialValue;

  final List<String> itemsCompanySize = [
    '0-10',
    '10-20',
    '20-30',
    '30-50',
    '50-75',
    '75-100'
  ];
  String? sizeValues;

  String? selectedDateString ;
  String foundedText = 'Select Date';
  Future<void> _selectDate(BuildContext context) async {
    if(widget.profileModel?.recruiterProfileDetails?.founded != null && widget.profileModel?.recruiterProfileDetails?.founded?.length != 0) {
      // selectedDate = DateTime.parse("${widget.profileModel?.recruiterProfileDetails?.founded}") ;
    }
    if (kDebugMode) {
      print(selectedDate) ;
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedDateString = "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2
            , '0')}";
        foundedText = "${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}-${picked.year.toString().padLeft(4, '0')}";
        founded = picked;
      });
    }
  }

  DateTime selectedDate = DateTime.now();

  CreateUpdateRecruiterProfileController CreateUpdateRecruiterProfileControllerInstanse = Get.put(CreateUpdateRecruiterProfileController());

  var formKey = GlobalKey<FormState>();

  websiteLink(String value) {
    print("object");
    final Uri? uri = Uri.tryParse(value);
    if (!uri!.hasAbsolutePath) {
      return 'Please enter valid url';
    }
  }

  nameInitialize() async {
    if(widget.profileModel?.contactPerson != null && widget.profileModel?.contactPerson?.length !=0){
      contactPersonNameController.text = widget.profileModel?.contactPerson ?? "" ;
    } else {
      SharedPreferences sp = await SharedPreferences.getInstance();
      contactPersonNameController.text = sp.getString("name")!;
    }
  }

  SelectIndustryController selectIndustryController = Get.put(SelectIndustryController());
  final ScrollController scrollController = ScrollController();

  String parseDateString(String dateString) {
    List<String> dateParts = dateString.split(RegExp(r'[-/]'));
    if (kDebugMode) {
      print("=============$dateString===============") ;
      print("=============${dateParts.length}.===============") ;
    }

    if (dateParts.length == 3) {
      try {
        int year = int.parse(dateParts[2]);
        int month = int.parse(dateParts[0]);
        int day = int.parse(dateParts[1]);

          print('below date') ;
          print('$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}') ;
          return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

      } catch (e) {
        // Ignore errors and continue to the next format
      }
    }

    // If none of the formats worked, handle the error or return a default value
    print("Error parsing date");
    return ""; // Or return a default value
  }


  @override
  void initState() {
    nameInitialize();
    selectIndustryController.selectIndustriesApi();
    companyLocationController.text = Constants.address ;
    if (widget.profileModel?.recruiterProfileDetails != null) {
      companyNameController.text = widget.profileModel?.recruiterProfileDetails?.companyName ?? "" ;
      companyLocationController.text = widget.profileModel?.recruiterProfileDetails?.companyLocation ?? "" ;
      addBioController.text = CommonFunctions.parseHtmlAndAddNewline(widget.profileModel?.recruiterProfileDetails?.addBio ?? "") ;
      websiteLinkController.text = widget.profileModel?.recruiterProfileDetails?.websiteLink ?? "" ;
      aboutDescriptionController.text = CommonFunctions.parseHtmlAndAddNewline(widget.profileModel?.recruiterProfileDetails?.aboutDescription ?? "") ;
      specializationController.text = CommonFunctions.parseHtmlAndAddNewline(widget.profileModel?.recruiterProfileDetails?.specialties ?? "") ;
      socialValue = widget.profileModel?.recruiterProfileDetails?.industry  ;
      companySize = widget.profileModel?.recruiterProfileDetails?.companySize  ;
      foundedText = widget.profileModel?.recruiterProfileDetails?.founded ?? 'Select Date'  ;
      if(widget.profileModel?.recruiterProfileDetails?.founded != null) {
      selectedDateString = parseDateString(widget.profileModel?.recruiterProfileDetails!.founded ?? "") ;
      print("$selectedDateString ==============================") ;
      }
      industry = widget.profileModel?.recruiterProfileDetails?.industryID ;
    }

    super.initState();
  }

  var isLoading = false;
  List<Location> locations = [] ;
  double? lat;
  double? long;
  List<Predictions> searchPlace = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (selectIndustryController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (selectIndustryController.error.value == 'No internet') {
            return Scaffold(
              body: InterNetExceptionWidget(
                onPress: () {
                  selectIndustryController.selectIndustriesApi();
                },
              ),
            );
          } else {
            return Scaffold(
              body: GeneralExceptionWidget(onPress: () {
                selectIndustryController.selectIndustriesApi();
              }),
            );
          }
        case Status.COMPLETED:
          return SafeArea(
              child: Scaffold(
            body: SingleChildScrollView(
              //padding: const EdgeInsets.symmetric(horizontal: 15),
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * .03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Image.asset(
                                  "assets/images/icon_back_blue.png",
                                  height: Get.height * .055,
                                )),
                            SizedBox(
                              width: Get.width * .04,
                            ),
                            Text(
                              "Add your detail",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .05,
                      ),
                      Container(
                        height: Get.height * .30 + 50,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (coverImage == null && widget.profileModel?.recruiterProfileDetails?.coverImg == null) {
                                  _openCoverImagePickerDialog();
                                }
                                return;
                              },
                              child: Container(
                                height: Get.height * .30,
                                width: Get.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xff454545),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    coverImage != null ? Image.file(coverImage!, height: Get.height, width: Get.width, fit: BoxFit.cover,) :
                                    widget.profileModel?.recruiterProfileDetails?.coverImg != null ?
                                    Image.network(widget.profileModel?.recruiterProfileDetails?.coverImg ?? "", width: Get.width, fit : BoxFit.cover,) :
                                    Image.asset("assets/images/icon_upload_cv.png", height: Get.height * .05,) ,

                                    if (coverImage == null && widget.profileModel?.recruiterProfileDetails?.coverImg == null)
                                      SizedBox(width: Get.width * .04,),
                                    if (coverImage == null && widget.profileModel?.recruiterProfileDetails?.coverImg == null)
                                      Text("Upload Cover Image",
                                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                            fontWeight: FontWeight.w400, color: const Color(0xffFFFFFF)),
                                      )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: coverImage == null && widget.profileModel?.recruiterProfileDetails?.coverImg == null
                                  ? const SizedBox()
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        _openCoverImagePickerDialog();
                                      },
                                    ),
                            ),
                            Positioned(
                              bottom: 5,
                              left: 20,
                              child: CircleAvatar(
                                radius: 45,
                                backgroundColor: const Color(0xff353535),
                                child: ClipOval(
                                  child: profileImage == null
                                      ? widget.profileModel?.recruiterProfileDetails?.profileImg == null ||
                                      widget.profileModel?.recruiterProfileDetails?.profileImg?.length == 0
                                      ? Image.asset(
                                          "assets/images/icon_profile.png",
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.cover,) : Image.network(widget.profileModel?.recruiterProfileDetails?.profileImg ?? "",
                                    height: Get.height, width: Get.width, fit: BoxFit.cover,)
                                      : Image.file(
                                          profileImage!,
                                          height: Get.height,
                                          width: Get.width,
                                          fit: BoxFit.cover,
                                        ),
                                  // :Image.file(imgFile!,height: Get.height,width: Get.width,fit:BoxFit.cover,)
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -0,
                              left: 85,
                              child: GestureDetector(
                                onTap: () {
                                  _openProfileImagePickerDialog();
                                  print(
                                      "This is profile ImgFile ${profileImage?.path}");
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  height: 37,
                                  width: 37,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.blueThemeColor),
                                  child: profileImage != null && profileImage?.path.length != 0 &&
                                      widget.profileModel?.recruiterProfileDetails?.profileImg?.length != 0
                                      ? const Icon(Icons.edit, color: Colors.white, size: 18,)
                                      : Image.asset(
                                          "assets/images/camera.png",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      SizedBox(height: Get.height * .02,),
                      Padding( padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "Select Profile image",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: const Color(0xffFFFFFF)),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * .031,
                      ),
                    ],
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Company name",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: Get.height * .01,
                          ),
                          CommonWidgets.textField(context,
                              companyNameController, "Enter company name",
                              onFieldSubmitted: (value) {}),
                          SizedBox(
                            height: Get.height * .032,
                          ),
                          Text(
                            "Company Location",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: Get.height * .01,
                          ),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            controller: companyLocationController,
                            style: Theme.of(context).textTheme.bodyMedium,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter your address';
                              }
                            },
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                if (companyLocationController.text.isEmpty) {
                                }
                              });
                              searchAutocomplete(value);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide: const BorderSide(color: Color(0xff373737))),
                                filled: true,
                                fillColor: const Color(0xff373737),
                                hintText: "Enter Location",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  // borderSide: BorderSide(color: Colors.white),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                  borderSide: BorderSide(color: Color(0xff373737)),
                                ),
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(color: const Color(0xffCFCFCF)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: Get.width * .06, vertical: Get.height * .027)),
                          ),
                          Visibility(
                            visible: companyLocationController.text.isNotEmpty,
                            child: SizedBox(
                              width: double.infinity,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: searchPlace.length,
                                  itemBuilder: (context, index) => ListTile(
                                    onTap: () {
                                      setState(() {
                                        companyLocationController.text = searchPlace[index].description ?? "";
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
                          SizedBox(
                            height: Get.height * .032,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Overview",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        CommonWidgets.textFieldMaxLines(
                          context, addBioController, "Enter bio ",
                          onFieldSubmitted: (value) {},
                          // maxCharacter: 1000,
                        ),
                        // SizedBox(height: Get.height*.01,),
                        CommonWidgets.divider(),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        Text(
                          "Contact Person Name",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        CommonWidgets.textField(
                          context,
                          contactPersonNameController,
                          "Enter contact person name",
                          onFieldSubmitted: (value) {},
                        ),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        CommonWidgets.divider(),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        Text(
                          "Website Link",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: websiteLinkController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  borderSide: const BorderSide(
                                      color: Color(0xff373737))),
                              filled: true,
                              fillColor: const Color(0xff373737),
                              hintText: "Enter website link",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                // borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0)),
                                borderSide:
                                    BorderSide(color: Color(0xff373737)),
                              ),
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: const Color(0xffCFCFCF)),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Get.width * .06,
                                  vertical: Get.height * .027)),
                          validator: (value) {
                            String pattern =
                                r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
                            RegExp regExp = new RegExp(pattern);
                            if (value?.length == 0) {
                              return 'Please enter url';
                            } else if (!regExp.hasMatch(value!)) {
                              return 'Please enter valid url';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: Get.height * .025,
                        ),
                        CommonWidgets.divider(),
                        Text(
                          "About",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: Get.height * .02,
                        ),

                        Text(
                          "Description",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        CommonWidgets.textFieldMaxLines(
                          context,
                          aboutDescriptionController,
                          "Enter description",
                          onFieldSubmitted: (value) {},
                        ),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        CommonWidgets.divider(),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        Text(
                          "Industry",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        Center(
                          child: DropdownButtonHideUnderline(
                            child: Obx(
                              () => DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Enter industry',
                                        style: Get.theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: selectIndustryController.getIndustriesData.value.industries?.map((item) => DropdownMenuItem<String>(
                                          onTap: () {
                                            setState(() {
                                              industry = item.id.toString();
                                              socialValue = item.industryPreferences;
                                            });
                                          },
                                          value: item.industryPreferences,
                                          child: Text(
                                            "${item.industryPreferences}",
                                            style: Get
                                                .theme.textTheme.bodyLarge!
                                                .copyWith(
                                                    color: AppColors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: socialValue,
                                onChanged: (String? value) {},
                                buttonStyleData: ButtonStyleData(
                                  height: Get.height * 0.078,
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    color: const Color(0xff373737),
                                  ),
                                  elevation: 2,
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Image.asset(
                                      'assets/images/arrowdown.png'),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.yellow,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: Get.height * 0.35,
                                  width: Get.width * 0.902,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: const Color(0xff353535),
                                  ),
                                  offset: const Offset(5, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Obx(() => CreateUpdateRecruiterProfileControllerInstanse.industryError.value.isEmpty
                            ? const SizedBox()
                            : Center(
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      CreateUpdateRecruiterProfileControllerInstanse
                                          .industryError.value,
                                      style: TextStyle(color: Colors.red),
                                    )))),
                        SizedBox(
                          height: Get.height * .04,
                        ),
                        Text(
                          "Company Size",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select employees',
                                style: Get.theme.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: itemsCompanySize.map((String item) =>
                                      DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          "$item Employees",
                                          style: Get.theme.textTheme.bodyLarge!
                                              .copyWith(color: AppColors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: companySize,
                              onChanged: (String? value) {
                                setState(() {
                                  companySize = value;
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: Get.height * 0.078,
                                width: Get.width,
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  color: const Color(0xff373737),
                                ),
                                elevation: 2,
                              ),
                              iconStyleData: IconStyleData(
                                icon:
                                    Image.asset('assets/images/arrowdown.png'),
                                iconSize: 14,
                                iconEnabledColor: Colors.yellow,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: Get.height * 0.35,
                                width: Get.width * 0.902,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: const Color(0xff353535),
                                ),
                                offset: const Offset(5, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness:
                                      MaterialStateProperty.all<double>(6),
                                  thumbVisibility:
                                      MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                        ),
                        Obx(() => CreateUpdateRecruiterProfileControllerInstanse
                                .companySizeError.value.isEmpty
                            ? const SizedBox()
                            : Center(
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      CreateUpdateRecruiterProfileControllerInstanse
                                          .companySizeError.value,
                                      style: TextStyle(color: Colors.red),
                                    )))),
                        SizedBox(
                          height: Get.height * .04,
                        ),
                        Text(
                          "Founded",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                            height: Get.height * 0.08,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: const Color(0xff373737),
                                borderRadius: BorderRadius.circular(35)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * .04),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    foundedText,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  GestureDetector(
                                    onTap: () => _selectDate(context),
                                    child: Image.asset(
                                      "assets/images/icon_calendar_blue.png",
                                      color: AppColors.blueThemeColor,
                                      height: Get.height * 0.030,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .04,
                        ),
                        Text(
                          "Specialization",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: Get.height * .01,
                        ),
                        CommonWidgets.textFieldMaxLines(
                          context,
                          specializationController,
                          "Enter Specialization",
                          onFieldSubmitted: (value) {},
                        ),
                        SizedBox(
                          height: Get.height * .05,
                        ),
                        Obx(
                          () => Center(
                            child: MyButton(
                                loading: CreateUpdateRecruiterProfileControllerInstanse.loading.value,
                                title: widget.profileModel != null ? "UPDATE" : "CONTINUE",
                                onTap1: () {
                                  CreateUpdateRecruiterProfileControllerInstanse
                                      .industryError.value = "";
                                  CreateUpdateRecruiterProfileControllerInstanse
                                      .companySizeError.value = "";
                                  CreateUpdateRecruiterProfileControllerInstanse
                                      .foundedError.value = "";
                                  if (!CreateUpdateRecruiterProfileControllerInstanse.loading.value) {
                                    if (formKey.currentState!.validate()) {
                                      if (industry == null) {
                                        CreateUpdateRecruiterProfileControllerInstanse
                                            .industryError.value =
                                        "Please choose industry";
                                      } else if (companySize == null) {
                                        CreateUpdateRecruiterProfileControllerInstanse
                                            .companySizeError.value =
                                        "Please select company size";
                                      } else {
                                        var formattedAddBioText = CommonFunctions
                                            .changeToHTML(
                                            addBioController.text ?? "");
                                        var formattedAboutDescriptionText = CommonFunctions
                                            .changeToHTML(
                                            aboutDescriptionController.text ??
                                                "");
                                        var formattedSpecilizationText = CommonFunctions
                                            .changeToHTML(
                                            specializationController.text ??
                                                "");

                                        if (kDebugMode) {
                                          print("this is =====================================$selectedDateString");
                                        }
                                        CreateUpdateRecruiterProfileControllerInstanse
                                            .createUpdateRecruiterProfileApi(
                                            profilePath: profileImage?.path,
                                            coverPath: coverImage?.path,
                                            companyName: companyNameController
                                                .text,
                                            companyLocation: companyLocationController
                                                .text,
                                            addBio: formattedAddBioText,
                                            websiteLink: websiteLinkController
                                                .text,
                                            aboutDescription: formattedAboutDescriptionText,
                                            industry: industry,
                                            companySize: companySize
                                                ?.replaceAll("Employees", ""),
                                            founded: selectedDateString,
                                            specialties: formattedSpecilizationText,
                                            contactPerson: contactPersonNameController
                                                .text);
                                      }
                                    } else {
                                      scrollController.animateTo(0,
                                          duration: const Duration(milliseconds: 100),
                                          curve: Curves.easeOut);
                                    }
                                }
                                }),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
      }
    });
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
    final query = companyLocationController.text;
    locations = await locationFromAddress(query);

    setState(() {
      var first = locations.first;
      lat = first.latitude;
      long = first.longitude;
      print("*****lat ${lat} : ${long}**********long");
    });
  }
}
