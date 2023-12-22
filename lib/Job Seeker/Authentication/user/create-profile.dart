import 'dart:convert';
import 'dart:io';
import 'package:flikka/controllers/SeekerProfile/SeekerCreateProfileController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/utils/CommonWidgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flikka/utils/Constants.dart';
import 'package:flikka/utils/MultiSelectField.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';
import '../../../controllers/ViewLanguageController/ViewLanguageController.dart';
import '../../../models/SearchPlaceModel/SearchPlaceModel.dart';
import '../../../res/components/general_expection.dart';
import '../../../res/components/internet_exception_widget.dart';
import '../../../utils/CommonFunctions.dart';
import '../../../widgets/app_colors.dart';
import 'package:http/http.dart' as http;

class ExperienceData {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  var startDateForm = GlobalKey<FormState>();
  var endDateForm = GlobalKey<FormState>();
  bool present = false;
}

class AppreciationData {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  DateTime endDate = DateTime.now();
}

class EducationData {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  var startDateForm = GlobalKey<FormState>();
  var endDateForm = GlobalKey<FormState>();
  bool present = false;
}

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  SeekerCreateProfileController seekerCreateProfileController =
      Get.put(SeekerCreateProfileController());

  bool fresher = false;
  bool experiencePresent = false;
  bool educationPresent = false;

  bool startExperienceDate = true;
  List<ExperienceData> experienceData = [];

  List<EducationData> educationData = [];

  List<AppreciationData> appreciationData = [];

  //////////Upload Cv////////////
  String _filePath = '';
  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      allowMultiple: false,
    );

    if (result != null) {
      if (result.files.single.path!.toLowerCase().endsWith('.pdf') ||
          result.files.single.path!.toLowerCase().endsWith('.doc') ||
          result.files.single.path!.toLowerCase().endsWith('.docx')) {
        setState(() {
          _filePath = result.files.single.path!;
          seekerCreateProfileController.cvErrorMessage.value = '';
        });
        print(_filePath);
      } else {
        if (_filePath.isEmpty) {
          seekerCreateProfileController.cvErrorMessage.value =
              'Please pick a file';
        } else {
          seekerCreateProfileController.cvErrorMessage.value =
              'Only pdf or document file is allowed';
        }
      }
    } else {
      // User canceled the picker
    }
  }

  String _documentTypeFilePath = '';
  String videoFilePath = '';
  File? videoFile ;
  Future<void> _openDocumentTypeFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'svg'],
    );

    if (result != null) {
      setState(() {
        _documentTypeFilePath = result.files.single.path!;
      });
      print(_documentTypeFilePath);
    } else {
      // User canceled the picker
    }
  }


  DateTime? startDateExperience;
  DateTime? startDateEducation;
  DateTime? endDateExperience;
  DateTime? endDateEducation;

  File? imgFile;

  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var aboutMeController = TextEditingController();
  var jobTitleController = TextEditingController();

  List workExperienceList = [];
  List educationList = [];
  List appreciationList = [];
  List languageList = [];
  var companyNameController = TextEditingController();
  var educationLevelController = TextEditingController();
  var institutionNameController = TextEditingController();
  var awardNameController = TextEditingController();
  var achievementController = TextEditingController();
  var languageController = TextEditingController();
  var phoneController = TextEditingController();
  var awardDate;
  var submitted = false;
  var introFormKey = GlobalKey<FormState>();
  var educationForm = GlobalKey<FormState>();
  var experienceForm = GlobalKey<FormState>();
  var languageForm = GlobalKey<FormState>();
  var startDateExperienceForm = GlobalKey<FormState>();
  var endDateExperienceForm = GlobalKey<FormState>();
  var startDateEducationForm = GlobalKey<FormState>();
  var endDateEducationForm = GlobalKey<FormState>();
  List<Location> locations = [];
  double? lat;
  double? long;
  List<Predictions> searchPlace = [];

  String? phoneNumber;
  bool validPhone = false;

  @override
  void initState() {
    super.initState();
    nameInitialize();
    _addExperience();
    _addEducation();
    _addAppreciation();
    viewLanguageController.viewLanguageApi();
    LanguageSelectorState.languages = [];
    locationController.text = Constants.address ;
  }

  List selectedFields = [];

  final ScrollController scrollController = ScrollController();

  nameInitialize() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    nameController.text = sp.getString("name")!;
  }

  ViewLanguageController viewLanguageController =
      Get.put(ViewLanguageController());
  var DocumentType;
  final List selectDocumentType = [
    'passport',
    'id_card',
  ];
  Key myIntlPhoneFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (viewLanguageController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (viewLanguageController.error.value == 'No internet') {
            return InterNetExceptionWidget(
              onPress: () {
                viewLanguageController.viewLanguageApi();
                LanguageSelectorState.languages = [];
              },
            );
          } else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              viewLanguageController.viewLanguageApi();
              LanguageSelectorState.languages = [];
            }));
          }
        case Status.COMPLETED:
          return SafeArea(
              child: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * .06),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: Get.height * .13,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Image.asset(
                                  "assets/images/icon_back_blue.png",
                                  height: Get.height * .05,
                                ))),
                        SizedBox(
                          width: Get.width * .04,
                        ),
                        Text(
                          "Create Profile",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Center(
                      child: SizedBox(
                        height: 96,
                        width: 96,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            CircleAvatar(
                              // radius: 30,
                              backgroundColor: const Color(0xff353535),
                              child: ClipOval(
                                  child: imgFile == null
                                      ? Image.asset(
                                          "assets/images/icon_profile.png",
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          imgFile!,
                                          height: Get.height,
                                          width: Get.width,
                                          fit: BoxFit.cover,
                                        )),
                            ),
                            Positioned(
                              top: 60,
                              left: 72,
                              // child: Image.asset("assets/images/icon_camera.png",height: Get.height*.07,)
                              child: GestureDetector(
                                onTap: () {
                                  _openImagePickerDialog();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 37,
                                  width: 37,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.blueThemeColor),
                                  child: imgFile != null &&
                                          imgFile?.path.length != 0
                                      ? const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 18,
                                        )
                                      : Image.asset(
                                          "assets/images/camera.png",
                                          height: 18,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .03,
                    ),
                    Center(
                        child: Text(
                      "Select Profile image",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: const Color(0xffFFFFFF)),
                    )),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    Obx(() => seekerCreateProfileController
                            .imageErrorMessage.value.isEmpty
                        ? const SizedBox()
                        : Center(
                            child: Text(
                            seekerCreateProfileController
                                .imageErrorMessage.value,
                            style: const TextStyle(color: Colors.red),
                          ))),
                    SizedBox(
                      height: Get.height * .035,
                    ),
                    Text(
                      "Upload Video",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: Get.height * .01,
                    ),
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
                          _openVideoPickerDialog() ;
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
                    SizedBox(
                      height: Get.height * .05,
                    ),
                    Form(
                      key: introFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidgets.textFieldHeading(context, "Full Name"),
                          SizedBox(
                            height: Get.height * .01,
                          ),
                          CommonWidgets.textField(
                              context, nameController, "Enter name",
                              onFieldSubmitted: (value) {}),
                          SizedBox(
                            height: Get.height * .042,
                          ),
                          CommonWidgets.textFieldHeading(context, "Location"),
                          SizedBox(
                            height: Get.height * .01,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            controller: locationController,
                            style: Theme.of(context).textTheme.bodyMedium,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter your address';
                              }
                            },
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                if (locationController.text.isEmpty) {}
                              });
                              searchAutocomplete(value);
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide: const BorderSide(
                                        color: Color(0xff373737))),
                                filled: true,
                                fillColor: const Color(0xff373737),
                                hintText: "Enter Location",
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
                          ),
                          Visibility(
                            visible: locationController.text.isNotEmpty,
                            child: SizedBox(
                              width: double.infinity,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: searchPlace.length,
                                  itemBuilder: (context, index) => ListTile(
                                        onTap: () {
                                          setState(() {
                                            locationController.text =
                                                searchPlace[index]
                                                        .description ??
                                                    "";
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      )),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * .042,
                          ),
                          CommonWidgets.textFieldHeading(
                              context, "Phone number"),
                          SizedBox(
                            height: Get.height * .01,
                          ),
                          IntlPhoneField(
                            flagsButtonPadding:
                                const EdgeInsets.only(bottom: 3),
                            autovalidateMode: AutovalidateMode.disabled,
                            key: myIntlPhoneFieldKey,
                            controller: phoneController,
                            style: Theme.of(context).textTheme.bodyMedium,
                            pickerDialogStyle: PickerDialogStyle(
                              countryNameStyle:
                                  Theme.of(context).textTheme.bodyMedium,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xff373737),
                              hintText: "Enter Phone number",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: const Color(0xffCFCFCF)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: Get.height * .025,
                                  horizontal: Get.width * .07),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Color(0xff373737))),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                                // borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22.0)),
                                borderSide:
                                    BorderSide(color: Color(0xff373737)),
                              ),
                            ),
                            languageCode: "en",
                            onChanged: (phone) {
                              phoneNumber = phone.completeNumber;
                              if (phone.isValidNumber()) {
                                validPhone = true;
                              }
                              debugPrint("this is ========= $phoneNumber");
                            },
                            validator: (p0) {
                              if (p0 != null) {
                                if (!p0.isValidNumber()) {
                                  return "Invalid number" ;
                                }
                              }
                            },
                            onCountryChanged: (country) {
                              print('Country changed to: ${country.name}');
                              print(country.dialCode + phoneController.text);
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          Obx(() => seekerCreateProfileController
                                  .phoneNumberErrorMessage.value.isEmpty
                              ? const SizedBox()
                              : Text(
                                  seekerCreateProfileController
                                      .phoneNumberErrorMessage.value,
                                  style: TextStyle(color: Colors.red),
                                )),
                          SizedBox(
                            height: Get.height * .042,
                          ),
                        ],
                      ),
                    ),
                    CommonWidgets.textFieldHeading(context, "About Me"),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    CommonWidgets.textFieldMaxLines(
                        context, aboutMeController, "Enter About",
                        onFieldSubmitted: (value) {}),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Text("Work experience",
                        style: Theme.of(context).textTheme.labelMedium),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: AppColors.blueThemeColor,
                          // fillColor:
                          //     MaterialStateProperty.all(const Color(0xff56B8F6)),
                          checkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          value: fresher,
                          onChanged: (val) {
                            setState(() {
                              fresher = val!;
                            });
                          },
                          side: const BorderSide(
                              width: 2, color: AppColors.blueThemeColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              fresher = !fresher;
                            });
                          },
                          child: Text(
                            "Fresher",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(fontSize: 15),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: Get.height * .001,
                    ),
                    CommonWidgets.divider(),
                    SizedBox(
                      height: Get.height * .001,
                    ),
                    !fresher
                        ? Form(
                            key: experienceForm,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: experienceData.length,
                              itemBuilder: (context, index) {
                                final column = experienceData[index];
                                jobTitleController = column.textController1;
                                companyNameController = column.textController2;
                                return Column(
                                  children: [
                                    addMoreFieldExperience(
                                      index: index,
                                      jobController: column.textController1,
                                      companyController: column.textController2,
                                      onFieldSubmitted: (value) {
                                        if (!value) {
                                          if (workExperienceList.isNotEmpty) {
                                            workExperienceList[index]
                                                    ["work_exp_job"] =
                                                column.textController1.text;
                                            workExperienceList[index]
                                                    ["company_name"] =
                                                column.textController2.text;
                                          }
                                        }
                                      },
                                      remove: () {
                                        setState(() {
                                          experienceData.removeAt(index);
                                          if (index <
                                              workExperienceList.length) {
                                            workExperienceList.removeAt(index);
                                          }
                                          print(workExperienceList);
                                        });
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: CommonWidgets
                                                  .textFieldHeading(
                                                      context, "Start date"),
                                            ),
                                            SizedBox(
                                              height: Get.height * .01,
                                            ),

                                            // DatePickerWidget(
                                            //   form: column.startDateForm,
                                            //   onDateSelected: (date) {
                                            //     setState(() {
                                            //       column.startDate = date;
                                            //       startDateExperience = date;
                                            //       // if(workExperienceList.length !=0 ){
                                            //       //   workExperienceList[index] = {
                                            //       //     "work_exp_job":
                                            //       //     column.textController1.text,
                                            //       //     "company_name":
                                            //       //     column.textController2.text,
                                            //       //     "job_start_date":
                                            //       //     column.startDate.toString(),
                                            //       //     "job_end_date":
                                            //       //     column.endDate.toString()
                                            //       //   } ;
                                            //       // }
                                            //     });
                                            //   },
                                            //   hint: " Enter start date", firstDate: DateTime(1990),),
                                            Focus(
                                              onFocusChange: (value) {
                                                if (workExperienceList
                                                    .isNotEmpty) {
                                                  workExperienceList[index]
                                                          ["job_start_date"] =
                                                      column.startDateController
                                                          .text;
                                                }
                                              },
                                              child: TextFormField(
                                                controller:
                                                    column.startDateController,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color: const Color(
                                                            0xffCFCFCF),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                onTap: () {
                                                  seekerCreateProfileController
                                                      .selectStartDateExperienceErrorMessage
                                                      .value = "";
                                                  _selectDate(
                                                      context,
                                                      DateTime(1990),
                                                      1,
                                                      column
                                                          .startDateController);
                                                },
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  errorStyle: const TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12),
                                                  constraints: const BoxConstraints(
                                                      //maxWidth: Get.width * 0.41,
                                                      ),
                                                  filled: true,
                                                  fillColor:
                                                      const Color(0xff373737),
                                                  hintText: "Select date",
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical:
                                                              Get.height * .027,
                                                          horizontal:
                                                              Get.width * .06),
                                                  hintStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                          color:
                                                              Color(0xffCFCFCF),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              35),
                                                      borderSide:
                                                          BorderSide.none),
                                                  suffixIcon: const Icon(
                                                    Icons.calendar_month,
                                                    size: 13,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Select start date';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.01,
                                            ),
                                            index == experienceData.length - 1
                                                ? addMoreField(onTap: () {
                                                    seekerCreateProfileController
                                                        .selectStartDateExperienceErrorMessage
                                                        .value = "";
                                                    if (!fresher) {
                                                      if (experienceForm
                                                          .currentState!
                                                          .validate()) {
                                                        if (column
                                                            .endDateController
                                                            .text
                                                            .isEmpty) {
                                                          seekerCreateProfileController
                                                                  .selectStartDateExperienceErrorMessage
                                                                  .value =
                                                              "Select date";
                                                        } else {
                                                          _addExperience();
                                                          if (workExperienceList
                                                                  .length <
                                                              index + 1) {
                                                            workExperienceList
                                                                .add({
                                                              "work_exp_job": column
                                                                  .textController1
                                                                  .text,
                                                              "company_name": column
                                                                  .textController2
                                                                  .text,
                                                              "job_start_date":
                                                                  column
                                                                      .startDateController
                                                                      .text,
                                                              "job_end_date": column
                                                                      .present
                                                                  ? "present"
                                                                  : column
                                                                      .endDateController
                                                                      .text,
                                                            });
                                                            print(
                                                                workExperienceList);
                                                          } else if (workExperienceList
                                                                  .length ==
                                                              index + 1) {
                                                            workExperienceList[
                                                                index] = {
                                                              "work_exp_job": column
                                                                  .textController1
                                                                  .text,
                                                              "company_name": column
                                                                  .textController2
                                                                  .text,
                                                              "job_start_date":
                                                                  column
                                                                      .startDateController
                                                                      .text,
                                                              "job_end_date": column
                                                                      .present
                                                                  ? "present"
                                                                  : column
                                                                      .endDateController
                                                                      .text,
                                                            };
                                                          }
                                                          setState(() {
                                                            // startDateExperience = null;
                                                            // endDateExperience = null;
                                                          });
                                                          print(
                                                              workExperienceList);
                                                        }
                                                      }
                                                    }
                                                    return null;
                                                  })
                                                : const SizedBox(),
                                          ],
                                        )),
                                        SizedBox(
                                          width: Get.width * .04,
                                        ),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: CommonWidgets
                                                  .textFieldHeading(
                                                      context, "End date"),
                                            ),
                                            SizedBox(
                                              height: Get.height * .01,
                                            ),

                                            // DatePickerWidget(
                                            //   form: column.endDateForm,
                                            //   onDateSelected: (date) {
                                            //     setState(() {
                                            //       column.endDate = date;
                                            //       endDateExperience = date;
                                            //       // if(workExperienceList.length !=0 ){
                                            //       //   workExperienceList[index] = {
                                            //       //     "work_exp_job":
                                            //       //     column.textController1.text,
                                            //       //     "company_name":
                                            //       //     column.textController2.text,
                                            //       //     "job_start_date":
                                            //       //     column.startDate.toString(),
                                            //       //     "job_end_date":
                                            //       //     column.endDate.toString()
                                            //       //   } ;
                                            //       // }
                                            //     });
                                            //   },
                                            //   hint: "Enter end date", firstDate: column.startDate,),
                                            Focus(
                                              onFocusChange: (value) {
                                                if (!value) {
                                                  if (workExperienceList
                                                      .isNotEmpty) {
                                                    workExperienceList[index]
                                                            ["job_end_date"] =
                                                        column.endDateController
                                                            .text;
                                                  }
                                                  debugPrint(workExperienceList[
                                                      index]);
                                                }
                                              },
                                              child: TextFormField(
                                                controller:
                                                    column.endDateController,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color: const Color(
                                                            0xffCFCFCF),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                onTap: () {
                                                  if (column.present) {
                                                  } else {
                                                    if (column
                                                        .startDateController
                                                        .text
                                                        .isEmpty) {
                                                      seekerCreateProfileController
                                                              .selectStartDateExperienceErrorMessage
                                                              .value =
                                                          "Select start date";
                                                    } else {
                                                      seekerCreateProfileController
                                                          .selectStartDateExperienceErrorMessage
                                                          .value = "";
                                                      _selectDate(
                                                          context,
                                                          DateTime.parse(column
                                                              .startDateController
                                                              .text),
                                                          2,
                                                          column
                                                              .endDateController);
                                                    }
                                                  }
                                                },
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  constraints: const BoxConstraints(
                                                      //maxWidth: Get.width * 0.41,
                                                      ),
                                                  filled: true,
                                                  fillColor:
                                                      const Color(0xff373737),
                                                  hintText: "Select date",
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical:
                                                              Get.height * .027,
                                                          horizontal:
                                                              Get.width * .06),
                                                  hintStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                          color: const Color(
                                                              0xffCFCFCF),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              35),
                                                      borderSide:
                                                          BorderSide.none),
                                                  suffixIcon: const Icon(
                                                    Icons.calendar_month,
                                                    size: 13,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  //   if (value == null || value.isEmpty) {
                                                  //     return seekerCreateProfileController.selectStartDateExperienceErrorMessage.value = 'Select date';
                                                  // }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: Get.height * .01,
                                            // ),
                                            index == experienceData.length - 1
                                                ? Obx(() =>
                                                    seekerCreateProfileController
                                                            .selectStartDateExperienceErrorMessage
                                                            .value
                                                            .isEmpty
                                                        ? const SizedBox()
                                                        : Text(
                                                            seekerCreateProfileController
                                                                .selectStartDateExperienceErrorMessage
                                                                .value,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red
                                                                    .shade600,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                          ))
                                                : const SizedBox(),
                                            index == experienceData.length - 1
                                                ? Row(
                                                    children: [
                                                      Checkbox(
                                                        checkColor:
                                                            Colors.white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        value: column.present,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            column.present =
                                                                val!;
                                                            experiencePresent =
                                                                column.present;
                                                            if (!column
                                                                .present) {
                                                              column
                                                                  .endDateController
                                                                  .text = "";
                                                            } else if (column
                                                                .present) {
                                                              column.endDateController
                                                                      .text =
                                                                  "present";
                                                            }
                                                          });
                                                        },
                                                        side: const BorderSide(
                                                            color: AppColors
                                                                .blueThemeColor),
                                                        activeColor: AppColors
                                                            .blueThemeColor,
                                                      ),
                                                      Text("Present",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: const Color(
                                                                        0xffFFFFFF),
                                                                  )),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                          ],
                                        )),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        : const SizedBox(),

                    //////////////////////////Add more fields in Work experience/////////////////////

                    SizedBox(
                      height: Get.height * .01,
                    ),
                    Text("Education",
                        style: Theme.of(context).textTheme.labelMedium),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    CommonWidgets.divider(),
                    SizedBox(
                      height: Get.height * .001,
                    ),
                    Form(
                      key: educationForm,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: educationData.length,
                        itemBuilder: (context, index) {
                          final education = educationData[index];
                          educationLevelController = education.textController1;
                          institutionNameController = education.textController2;
                          return Column(
                            children: [
                              addMoreFieldEducation(
                                index: index,
                                educationLevelController:
                                    education.textController1,
                                institutionNameController:
                                    education.textController2,
                                onFieldSubmitted: (value) {
                                  if (!value) {
                                    if (educationList.isNotEmpty) {
                                      educationList[index]["education_level"] =
                                          education.textController1.text;
                                      educationList[index]["institution_name"] =
                                          education.textController2.text;
                                    }
                                  }
                                },
                                remove: () {
                                  setState(() {
                                    educationData.removeAt(index);
                                    if (index < educationList.length) {
                                      educationList.removeAt(index);
                                    }
                                    print(educationList);
                                  });
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: CommonWidgets.textFieldHeading(
                                            context, "Start date"),
                                      ),
                                      SizedBox(
                                        height: Get.height * .01,
                                      ),

                                      // DatePickerWidget(
                                      //   form: education.startDateForm,
                                      //   onDateSelected: (date) {
                                      //     setState(() {
                                      //       education.startDate = date;
                                      //       startDateEducation = date;
                                      //         // educationList[index] = {
                                      //         //   "education_level":
                                      //         //   education.textController1.text,
                                      //         //   "institution_name":
                                      //         //   education.textController2.text,
                                      //         //   // "field_of_study": education.textController3.text,
                                      //         //   "education_start_date":
                                      //         //   education.startDate.toString(),
                                      //         //   "education_end_date":
                                      //         //   education.endDate.toString()
                                      //         // } ;
                                      //     });
                                      //   },
                                      //   hint: " Enter start date", firstDate: DateTime(1990),),
                                      Focus(
                                        onFocusChange: (value) {
                                          if (!value) {
                                            if (educationList.isNotEmpty) {
                                              educationList[index]
                                                      ["education_start_date"] =
                                                  education
                                                      .startDateController.text;
                                            }
                                          }
                                        },
                                        child: TextFormField(
                                          controller:
                                              education.startDateController,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  color: Color(0xffCFCFCF),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                          onTap: () {
                                            seekerCreateProfileController
                                                .selectStartDateEducationErrorMessage
                                                .value = "";
                                            _selectDate(
                                                context,
                                                DateTime(1990),
                                                3,
                                                education.startDateController);
                                          },
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            errorStyle: const TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12),
                                            constraints: const BoxConstraints(
                                                //maxWidth: Get.width * 0.41,
                                                ),
                                            filled: true,
                                            fillColor: const Color(0xff373737),
                                            hintText: "Select date",
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: Get.height * .027,
                                                    horizontal:
                                                        Get.width * .06),
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: Color(0xffCFCFCF),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                borderSide: BorderSide.none),
                                            suffixIcon: const Icon(
                                              Icons.calendar_month,
                                              size: 13,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Select start date';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * .01,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.001,
                                      ),
                                      index == educationData.length - 1
                                          ? addMoreField(onTap: () {
                                              seekerCreateProfileController
                                                  .selectStartDateEducationErrorMessage
                                                  .value = "";
                                              if (educationForm.currentState!
                                                  .validate()) {
                                                if (education.endDateController
                                                    .text.isEmpty) {
                                                  seekerCreateProfileController
                                                      .selectStartDateEducationErrorMessage
                                                      .value = "Select date";
                                                } else {
                                                  _addEducation();
                                                  if (educationList.length <
                                                      index + 1) {
                                                    educationList.add({
                                                      "education_level":
                                                          education
                                                              .textController1
                                                              .text,
                                                      "institution_name":
                                                          education
                                                              .textController2
                                                              .text,
                                                      "education_start_date":
                                                          education
                                                              .startDateController
                                                              .text,
                                                      "education_end_date":
                                                          education.present
                                                              ? "present"
                                                              : education
                                                                  .endDateController
                                                                  .text
                                                    });
                                                  } else if (educationList
                                                          .length ==
                                                      index + 1) {
                                                    educationList[index] = {
                                                      "education_level":
                                                          education
                                                              .textController1
                                                              .text,
                                                      "institution_name":
                                                          education
                                                              .textController2
                                                              .text,
                                                      "education_start_date":
                                                          education
                                                              .startDateController
                                                              .text,
                                                      "education_end_date":
                                                          education.present
                                                              ? "present"
                                                              : education
                                                                  .endDateController
                                                                  .text
                                                    };
                                                  }
                                                  setState(() {
                                                    // startDateEducation = null;
                                                    // endDateEducation = null;
                                                  });
                                                  print(educationList);
                                                }
                                              }
                                            })
                                          : const SizedBox(),
                                    ],
                                  )),
                                  SizedBox(
                                    width: Get.width * .04,
                                  ),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: CommonWidgets.textFieldHeading(
                                            context, "End date"),
                                      ),
                                      SizedBox(
                                        height: Get.height * .01,
                                      ),

                                      // DatePickerWidget(
                                      //   form: education.endDateForm,
                                      //   onDateSelected: (date) {
                                      //     setState(() {
                                      //       education.endDate = date;
                                      //       endDateEducation = date;
                                      //       // if(educationList.length !=0 ){
                                      //       //   educationList[index] = {
                                      //       //     "education_level":
                                      //       //     education.textController1.text,
                                      //       //     "institution_name":
                                      //       //     education.textController2.text,
                                      //       //     // "field_of_study": education.textController3.text,
                                      //       //     "education_start_date":
                                      //       //     education.startDate.toString(),
                                      //       //     "education_end_date":
                                      //       //     education.endDate.toString()
                                      //       //   } ;
                                      //       // }
                                      //     });
                                      //   },
                                      //   hint: "Enter end date", firstDate: DateTime(2000),),
                                      Focus(
                                        onFocusChange: (value) {
                                          if (!value) {
                                            if (educationList.isNotEmpty) {
                                              educationList[index]
                                                      ["education_end_date"] =
                                                  education
                                                      .endDateController.text;
                                            }
                                          }
                                        },
                                        child: TextFormField(
                                          controller:
                                              education.endDateController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  color: Color(0xffCFCFCF),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                          onTap: () {
                                            if (education.present) {
                                            } else {
                                              if (education.startDateController
                                                  .text.isEmpty) {
                                                seekerCreateProfileController
                                                    .selectStartDateEducationErrorMessage
                                                    .value = "Select start date";
                                              } else {
                                                seekerCreateProfileController
                                                    .selectStartDateEducationErrorMessage
                                                    .value = "";
                                                _selectDate(
                                                    context,
                                                    DateTime.parse(education
                                                        .startDateController
                                                        .text),
                                                    4,
                                                    education
                                                        .endDateController);
                                                print(
                                                    "this is after selection $startDateEducation");
                                              }
                                            }
                                          },
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            constraints: const BoxConstraints(
                                                //maxWidth: Get.width * 0.41,
                                                ),
                                            filled: true,
                                            fillColor: const Color(0xff373737),
                                            hintText: "Select date",
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: Get.height * .027,
                                                    horizontal:
                                                        Get.width * .06),
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color:
                                                        const Color(0xffCFCFCF),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                borderSide: BorderSide.none),
                                            suffixIcon: const Icon(
                                              Icons.calendar_month,
                                              size: 13,
                                            ),
                                          ),
                                          validator: (value) {
                                            //           if(seekerCreateProfileController.selectStartDateEducationErrorMessage.value.isEmpty) {
                                            //   if (value == null || value.isEmpty) {
                                            //     return 'Select date';
                                            //   }
                                            // }
                                            // return null;
                                          },
                                        ),
                                      ),
                                      index == educationData.length - 1
                                          ? Obx(() => seekerCreateProfileController
                                                  .selectStartDateEducationErrorMessage
                                                  .value
                                                  .isEmpty
                                              ? const SizedBox()
                                              : Text(
                                                  seekerCreateProfileController
                                                      .selectStartDateEducationErrorMessage
                                                      .value,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.red.shade600,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ))
                                          : const SizedBox(),
                                      index == educationData.length - 1
                                          ? Row(
                                              children: [
                                                Checkbox(
                                                  checkColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  value: education.present,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      education.present = val!;
                                                      educationPresent =
                                                          education.present;
                                                      if (!education.present) {
                                                        education
                                                            .endDateController
                                                            .text = "";
                                                      } else if (education
                                                          .present) {
                                                        education
                                                            .endDateController
                                                            .text = "present";
                                                      }
                                                    });
                                                  },
                                                  side: const BorderSide(
                                                      color: AppColors
                                                          .blueThemeColor),
                                                  activeColor:
                                                      AppColors.blueThemeColor,
                                                ),
                                                Text("Present",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: const Color(
                                                              0xffFFFFFF),
                                                        )),
                                              ],
                                            )
                                          : const SizedBox(),
                                    ],
                                  )),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    SizedBox(
                      height: Get.height * .02,
                    ),
                    CommonWidgets.textFieldHeading(context, "Language"),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    LanguageSelector(
                      selectedLanguageList: languageList,
                      languageList: viewLanguageController
                          .viewLanguageData.value.languages,
                    ),
                    Obx(() => seekerCreateProfileController
                            .languageErrorMessage.value.isEmpty
                        ? const SizedBox()
                        : Center(
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  seekerCreateProfileController
                                      .languageErrorMessage.value,
                                  style: const TextStyle(color: Colors.red),
                                )))),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Text("Appreciation",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: Get.height * .001,
                    ),
                    CommonWidgets.divider(),
                    SizedBox(
                      height: Get.height * .001,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: appreciationData.length,
                      itemBuilder: (context, index) {
                        final appreciation = appreciationData[index];
                        awardNameController = appreciation.textController1;
                        achievementController = appreciation.textController2;
                        return Column(
                          children: [
                            addMoreFieldAppreciation(
                              index: index,
                              awardController: appreciation.textController1,
                              achievementController:
                                  appreciation.textController2,
                              onFieldSubmitted: (value) {
                                if (!value) {
                                  if (appreciationList.isNotEmpty) {
                                    appreciationList[index]["award_name"] =
                                        appreciation.textController1.text;
                                    appreciationList[index]["achievement"] =
                                        appreciation.textController2.text;
                                  }
                                }
                              },
                              remove: () {
                                setState(() {
                                  appreciationData.removeAt(index);
                                  if (index < appreciationList.length) {
                                    appreciationList.removeAt(index);
                                  }
                                  print(appreciationList);
                                });
                              },
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            index == appreciationData.length - 1
                                ? addMoreField(onTap: () {
                                    _addAppreciation();
                                    if (appreciationList.length < index + 1) {
                                      appreciationList.add({
                                        "award_name":
                                            appreciation.textController1.text,
                                        "achievement":
                                            appreciation.textController2.text,
                                      });
                                    } else if (appreciationList.length ==
                                        index + 1) {
                                      appreciationList[index] = {
                                        "award_name":
                                            appreciation.textController1.text,
                                        "achievement":
                                            appreciation.textController2.text,
                                      };
                                    }
                                    print(appreciationList);
                                  })
                                : const SizedBox(
                                    height: 15,
                                  ),
                          ],
                        );
                      },
                    ),

                    ///////////////Appreciation//////////////////
                    SizedBox(
                      height: Get.height * .015,
                    ),
                    Text(
                      "Document Type",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    Container(
                      height: Get.height * 0.076,
                      decoration: BoxDecoration(
                        color: const Color(0xff373737),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.06),
                          isExpanded: true,
                          value: DocumentType,
                          hint: Text(
                            "Select Type",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: const Color(0xffCFCFCF)),
                          ),
                          items: selectDocumentType.map((document) {
                            return DropdownMenuItem(
                              value: document,
                              child: Text(document,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != DocumentType) {
                              setState(() {
                                DocumentType = value;
                                seekerCreateProfileController
                                    .documentErrorMessage.value = "";
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .033,
                    ),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(20),
                      dashPattern: [5, 5],
                      color: const Color(0xffCFCFCF),
                      strokeWidth: 0.7,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (DocumentType == null) {
                                seekerCreateProfileController
                                        .documentErrorMessage.value =
                                    "Please select document type first";
                              } else {
                                if (_documentTypeFilePath.isNotEmpty) {
                                  // _openDocumentTypeFilePicker();
                                  OpenFile.open(_documentTypeFilePath);
                                } else {
                                  _openDocumentTypeFilePicker();
                                }
                              }
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
                                    _documentTypeFilePath == ''
                                        ? Image.asset(
                                            "assets/images/icon_upload_cv.png",
                                            width: Get.width * .07,
                                            height: Get.height * .06,
                                          )
                                        :
                                        //     : Image.asset(
                                        //   "assets/images/icon_uploded_cv.png",
                                        //   width: Get.width * .07,
                                        //   height: Get.height * .06,
                                        // ),
                                        SizedBox(width: Get.width * .0),
                                    if (_documentTypeFilePath.isNotEmpty)
                                      SizedBox(
                                        width: Get.width * .6,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(width: Get.width * .02),
                                            Flexible(
                                              child: Text(
                                                "File uploaded: ${_documentTypeFilePath.split('/').last}",
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
                                      )
                                    else
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 4),
                                        child: Text(
                                          "Upload File",
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
                          Positioned(
                              right: 5,
                              top: 1,
                              child: _documentTypeFilePath.isEmpty
                                  ? const SizedBox()
                                  : IconButton(
                                      onPressed: () {
                                        if (DocumentType == null) {
                                          seekerCreateProfileController
                                                  .documentErrorMessage.value =
                                              "Please select document type first";
                                        } else {
                                          _openDocumentTypeFilePicker();
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Obx(() => seekerCreateProfileController
                            .documentErrorMessage.value.isEmpty
                        ? const SizedBox()
                        : Center(
                            child: Text(
                            seekerCreateProfileController
                                .documentErrorMessage.value,
                            style: const TextStyle(color: Colors.red),
                          ))),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Text("Upload CV",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    Text(
                      "Add your CV/Resume to apply for a job",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffCFCFCF)),
                    ),
                    SizedBox(
                      height: Get.height * .03,
                    ),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(20),
                      dashPattern: const [5, 5],
                      color: const Color(0xffCFCFCF),
                      strokeWidth: 0.7,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_filePath.isNotEmpty) {
                                // _openFilePicker();
                                OpenFile.open(_filePath);
                              } else {
                                _openFilePicker();
                              }
                            },
                            child: Container(
                              height: Get.height * .15,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _filePath == ''
                                        ? Image.asset(
                                            "assets/images/icon_upload_cv.png",
                                            width: Get.width * .07,
                                            height: Get.height * .06,
                                          )
                                        : _filePath.contains(".pdf") ? Image.asset(
                                            "assets/images/icon_uploded_cv.png",
                                            width: Get.width * .07,
                                            height: Get.height * .06,
                                          ) : Image.asset(
                                      "assets/images/icon_document_uploded.png",
                                      width: Get.width * .07,
                                      height: Get.height * .06,
                                    ),
                                    SizedBox(width: Get.width * .04),
                                    if (_filePath.isNotEmpty)
                                      SizedBox(
                                        width: Get.width * .6,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(width: Get.width * .02),
                                            Flexible(
                                              child: Text(
                                                "File uploaded: ${_filePath.split('/').last}",
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
                                      )
                                    else
                                      Text(
                                        "Upload CV/Resume",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              right: 5,
                              top: 1,
                              child: _filePath.isEmpty
                                  ? const SizedBox()
                                  : IconButton(
                                      onPressed: () {
                                        _openFilePicker();
                                        print("Tapped edit");
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    Obx(() => seekerCreateProfileController
                            .cvErrorMessage.value.isEmpty
                        ? const SizedBox()
                        : Center(
                            child: Text(
                            seekerCreateProfileController.cvErrorMessage.value,
                            style: const TextStyle(color: Colors.red),
                          ))),
                    SizedBox(
                      height: Get.height * .07,
                    ),
                    Obx(
                      () => Center(
                        child: MyButton(
                            title: "CONTINUE",
                            loading: seekerCreateProfileController.loading.value,
                            onTap1: () {
                              if (educationLevelController.text.isNotEmpty &&
                                  institutionNameController.text.isNotEmpty &&
                                  startDateEducation != null &&
                                  startDateEducation.toString().isNotEmpty) {
                                educationList.add({
                                  "education_level":
                                      educationLevelController.text,
                                  "institution_name":
                                      institutionNameController.text,
                                  "education_start_date":
                                      "${startDateEducation?.year.toString().padLeft(4, '0')}-${startDateEducation?.month.toString().padLeft(2, '0')}-${startDateEducation?.day.toString().padLeft(2, '0')}",
                                  "education_end_date": educationPresent ==
                                              true ||
                                          endDateEducation == null ||
                                          endDateEducation.toString().isEmpty
                                      ? "present"
                                      : "${endDateEducation?.year.toString().padLeft(4, '0')}-${endDateEducation?.month.toString().padLeft(2, '0')}-${endDateEducation?.day.toString().padLeft(2, '0')}",
                                });
                              }
                              if (awardNameController.text.isNotEmpty &&
                                  achievementController.text.isNotEmpty) {
                                appreciationList.add({
                                  "award_name": awardNameController.text,
                                  "achievement": achievementController.text
                                });
                                print(appreciationList);
                              }
                              if (jobTitleController.text.isNotEmpty &&
                                  companyNameController.text.isNotEmpty &&
                                  startDateExperience != null &&
                                  startDateExperience.toString().isNotEmpty) {
                                workExperienceList.add({
                                  "work_exp_job": jobTitleController.text,
                                  "company_name": companyNameController.text,
                                  "job_start_date":
                                      "${startDateExperience?.year.toString().padLeft(4, '0')}-${startDateExperience?.month.toString().padLeft(2, '0')}-${startDateExperience?.day.toString().padLeft(2, '0')}",
                                  "job_end_date": experiencePresent == true ||
                                          endDateExperience == null ||
                                          endDateExperience.toString().isEmpty
                                      ? "present"
                                      : "${endDateExperience?.year.toString().padLeft(4, '0')}-${endDateExperience?.month.toString().padLeft(2, '0')}-${endDateExperience?.day.toString().padLeft(2, '0')}",
                                });
                              }
                              debugPrint(workExperienceList.toString());
                              debugPrint(educationList.toString());
                              if (introFormKey.currentState!.validate()) {
                                  var formattedAboutText = CommonFunctions.changeToHTML(aboutMeController.text ?? "");
                                  if(seekerCreateProfileController.loading.value) {} else {
                                    seekerCreateProfileController
                                      .createProfileApi( videoFilePath ,
                                          imgFile?.path,
                                          _filePath,
                                          _documentTypeFilePath,
                                          nameController.text,
                                          locationController.text,
                                          phoneNumber,
                                          formattedAboutText,
                                          workExperienceList,
                                          educationList,
                                          LanguageSelectorState.languages,
                                          appreciationList,
                                          DocumentType,
                                          fresher ? 1 : null);
                                  }
                              } else {
                                scrollController.animateTo(0,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.easeOut);
                              }

                              // seekerCreateProfileController.selectStartDateExperienceErrorMessage.value = "" ;
                              // seekerCreateProfileController.selectStartDateEducationErrorMessage.value = "" ;
                              // seekerCreateProfileController.imageErrorMessage.value = "" ;
                              // seekerCreateProfileController
                              //     .languageErrorMessage.value = "";
                              // seekerCreateProfileController
                              //     .documentErrorMessage.value = "";
                              // seekerCreateProfileController.cvErrorMessage.value = "";
                              // print(LanguageSelectorState.languages);
                              // print(
                              //     "this is submit value ======= ${seekerCreateProfileController.submitted}");
                              //
                              // if (imgFile?.path == null) {
                              //   seekerCreateProfileController.imageErrorMessage
                              //       .value = "Please select profile image";
                              //   scrollController.animateTo(0,
                              //       duration: const Duration(milliseconds: 100),
                              //       curve: Curves.easeOut);
                              // } else if (!fresher) {
                              //   if (introFormKey.currentState!.validate() &&
                              //       experienceForm.currentState!.validate() ) {
                              //     if (endDateExperience == null) {
                              //       seekerCreateProfileController
                              //           .selectStartDateExperienceErrorMessage
                              //           .value = 'Select end date';
                              //     }
                              //    else if (educationForm.currentState!.validate()) {
                              //       if (endDateEducation == null) {
                              //         seekerCreateProfileController
                              //             .selectStartDateEducationErrorMessage
                              //             .value = 'Select end date';
                              //       }
                              //
                              //       else
                              //       if (LanguageSelectorState.languages.isEmpty) {
                              //         seekerCreateProfileController
                              //             .languageErrorMessage
                              //             .value = "Please select a language";
                              //       } else if (_documentTypeFilePath.isEmpty) {
                              //         seekerCreateProfileController
                              //             .documentErrorMessage
                              //             .value = "Please upload a document";
                              //       } else if (_filePath.isEmpty) {
                              //         seekerCreateProfileController
                              //             .cvErrorMessage.value =
                              //         "Please upload a CV";
                              //       } else {
                              //         if (seekerCreateProfileController
                              //             .submitted.value ==
                              //             false) {
                              //           if (awardNameController.text.isNotEmpty &&
                              //               achievementController.text.isNotEmpty) {
                              //             appreciationList.add({
                              //               "award_name": awardNameController.text,
                              //               "achievement": achievementController
                              //                   .text
                              //             });
                              //             print(appreciationList);
                              //           }
                              //           if (jobTitleController.text.isNotEmpty &&
                              //               companyNameController.text.isNotEmpty) {
                              //             workExperienceList.add({
                              //               "work_exp_job": jobTitleController.text,
                              //               "company_name": companyNameController
                              //                   .text,
                              //               "job_start_date":
                              //               startDateExperience.toString(),
                              //               "job_end_date": endDateExperience
                              //                   .toString()
                              //             });
                              //           }
                              //           print(workExperienceList);
                              //
                              //           if (educationLevelController.text
                              //               .isNotEmpty &&
                              //               institutionNameController.text
                              //                   .isNotEmpty) {
                              //             educationList.add({
                              //               "education_level":
                              //               educationLevelController.text,
                              //               "institution_name":
                              //               institutionNameController.text,
                              //               // "field_of_study": education.textController3.text,
                              //               "education_start_date":
                              //               startDateEducation.toString(),
                              //               "education_end_date":
                              //               endDateEducation.toString()
                              //             });
                              //             print(educationList);
                              //           }
                              //         }
                              //       }
                              //       seekerCreateProfileController.createProfileApi(
                              //           imgFile!.path,
                              //           _filePath,
                              //           _documentTypeFilePath,
                              //           nameController.text,
                              //           locationController.text,
                              //           aboutMeController.text,
                              //           workExperienceList,
                              //           educationList,
                              //           LanguageSelectorState.languages,
                              //           appreciationList,
                              //           DocumentType,
                              //           null);
                              //     }
                              //   }
                              // } else {
                              //   if (introFormKey.currentState!.validate() &&
                              //       educationForm.currentState!.validate()) {
                              //     if(endDateEducation == null) {
                              //       seekerCreateProfileController
                              //           .selectStartDateEducationErrorMessage
                              //           .value = 'Select end date';
                              //     }
                              //   else if (LanguageSelectorState.languages.isEmpty) {
                              //       seekerCreateProfileController.languageErrorMessage
                              //           .value = "Please select a language";
                              //     } else if (_documentTypeFilePath.isEmpty) {
                              //       seekerCreateProfileController.documentErrorMessage
                              //           .value = "Please upload a document";
                              //     } else if (_filePath.isEmpty) {
                              //       seekerCreateProfileController
                              //           .cvErrorMessage.value = "Please upload a CV";
                              //     } else {
                              //       if (seekerCreateProfileController
                              //               .submitted.value ==
                              //           false) {
                              //         if (educationLevelController.text.isNotEmpty &&
                              //             institutionNameController.text.isNotEmpty) {
                              //           educationList.add({
                              //             "education_level":
                              //                 educationLevelController.text,
                              //             "institution_name":
                              //                 institutionNameController.text,
                              //             "education_start_date":
                              //                 startDateEducation.toString(),
                              //             "education_end_date":
                              //                 endDateEducation.toString()
                              //           });
                              //           print(educationList);
                              //         }
                              //         if (awardNameController.text.isNotEmpty &&
                              //             achievementController.text.isNotEmpty) {
                              //           appreciationList.add({
                              //             "award_name": awardNameController.text,
                              //             "achievement": achievementController.text
                              //           });
                              //           print(appreciationList);
                              //         }
                              //       }
                              //       seekerCreateProfileController.createProfileApi(
                              //           imgFile!.path,
                              //           _filePath,
                              //           _documentTypeFilePath,
                              //           nameController.text,
                              //           locationController.text,
                              //           aboutMeController.text,
                              //           workExperienceList,
                              //           educationList,
                              //           LanguageSelectorState.languages,
                              //           appreciationList,
                              //           DocumentType,
                              //           1);
                              //     }
                              //   }
                              //   seekerCreateProfileController.submitted(true);
                              // }
                            }),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .09,
                    ),
                  ],
                ),
              ),
            ),
          ));
      }
    });
  }

  Future<void> _openVideoPickerDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          title: Center(
            child: Text(
              'Please choose video',
              style: Theme.of(context)
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
                      Get.back() ;
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

  Future<void> _openImagePickerDialog() {
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
                        _pickImage(ImageSource.camera);
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
                        _pickImage(ImageSource.gallery);
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

  final imgPicker = ImagePicker();
  final imageCropper = ImageCropper();
  Future<void> _pickImage(abc) async {
    final pickedImage = await ImagePicker().pickImage(source: abc);

    if (pickedImage != null) {
      final croppedImage = await imageCropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: const CropAspectRatio(
            ratioX: 1.5, ratioY: 2), // Adjust aspect ratio as needed
        compressQuality: 60,
        uiSettings: [
          AndroidUiSettings(
            hideBottomControls: true,
              toolbarTitle: 'Cropper',
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
        imgFile = File(croppedImage!.path);
        print(imgFile);
        Get.back();
      });
    }
  }

  addMoreField({required Function() onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Image.asset(
                "assets/images/icon_add_more.png",
                height: Get.height * .035,
              ),
              SizedBox(
                  width: Get.width *
                      .04), // Add spacing between the checkbox and the label
              Text(
                "Add More",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xffFFFFFF)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        )
      ],
    );
  }

  addMoreFieldExperience(
      {required TextEditingController jobController,
      required TextEditingController companyController,
      required Function(bool) onFieldSubmitted,
      required Function() remove,
      int? index}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      index == 0
          ? const SizedBox()
          : Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: remove,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Remove",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      width: Get.width * .02,
                    ),
                    Icon(
                      Icons.remove_circle,
                    ),
                  ],
                ),
              ),
            ),
      index == 0
          ? SizedBox(
              height: Get.height * 0.01,
            )
          : const SizedBox(),
      CommonWidgets.textFieldHeading(context, "Work experience"),
      SizedBox(
        height: Get.height * .01,
      ),
      CommonWidgets.textField(context, jobController, "Enter job title",
          onFieldSubmitted: onFieldSubmitted),
      SizedBox(
        height: Get.height * .03,
      ),
      Align(
        alignment: Alignment.topLeft,
        child: CommonWidgets.textFieldHeading(context, "Company Name"),
      ),
      SizedBox(
        height: Get.height * .01,
      ),
      CommonWidgets.textField(context, companyController, "Enter company name",
          onFieldSubmitted: onFieldSubmitted),
      SizedBox(
        height: Get.height * .04,
      ),
    ]);
  }

  addMoreFieldEducation(
      {required TextEditingController educationLevelController,
      required TextEditingController institutionNameController,
      required Function(bool) onFieldSubmitted,
      required Function() remove,
      int? index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // CommonWidgets.textFieldHeading(context, "Education"),
            index == 0
                ? const SizedBox()
                : Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: remove,
                      child: Row(
                        children: [
                          Text(
                            "Remove",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            width: Get.width * .02,
                          ),
                          Icon(Icons.remove_circle),
                        ],
                      ),
                    ),
                  ),
            // index == 0
            //     ? const SizedBox()
            //     : IconButton(
            //   icon: const Icon(Icons.remove_circle),
            //   onPressed: remove,
            // ),
          ],
        ),
        index == 0
            ? SizedBox(
                height: Get.height * 0.01,
              )
            : const SizedBox(),
        CommonWidgets.textFieldHeading(context, "Level of education"),
        SizedBox(
          height: Get.height * .01,
        ),
        CommonWidgets.textField(
            context, educationLevelController, "Enter level of education",
            onFieldSubmitted: (value) {}),
        SizedBox(
          height: Get.height * .04,
        ),
        CommonWidgets.textFieldHeading(context, "Institution name"),
        SizedBox(
          height: Get.height * .01,
        ),
        CommonWidgets.textField(
            context, institutionNameController, "Enter institution name",
            onFieldSubmitted: (value) {}),
        SizedBox(
          height: Get.height * .04,
        ),
      ],
    );
  }

  addMoreFieldAppreciation(
      {required TextEditingController awardController,
      required TextEditingController achievementController,
      required Function(bool) onFieldSubmitted,
      required Function() remove,
      int? index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            index == 0
                ? const SizedBox()
                : Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: remove,
                      child: Row(
                        children: [
                          Text(
                            "Remove",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            width: Get.width * .02,
                          ),
                          Icon(Icons.remove_circle),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
        CommonWidgets.textFieldHeading(context, "Award name"),
        SizedBox(
          height: Get.height * 0.01,
        ),
        CommonWidgets.textField(context, awardController, "Enter award name",
            onFieldSubmitted: (value) {}),
        SizedBox(height: Get.height * .04),
        Align(
          alignment: Alignment.topLeft,
          child: CommonWidgets.textFieldHeading(context, "Achievement"),
        ),
        SizedBox(height: Get.height * .01),
        CommonWidgets.textField(
            context, achievementController, "Enter your achievements",
            onFieldSubmitted: (value) {}),
      ],
    );
  }

  void _addExperience() {
    setState(() {
      experienceData.add(ExperienceData());
    });
  }

  void _addEducation() {
    setState(() {
      educationData.add(EducationData());
    });
  }

  void _addAppreciation() {
    setState(() {
      appreciationData.add(AppreciationData());
    });
  }

  Future<void> _selectDate(
      BuildContext context,
      DateTime? firstDate,
      // DateTime? selectedDate ,
      int step,
      TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        step == 1
            ? startDateExperience = picked
            : step == 2
                ? endDateExperience = picked
                : step == 3
                    ? startDateEducation = picked
                    : endDateEducation = picked;
        controller.text =
            "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
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
      if (kDebugMode) {
        print(response.statusCode);
      }
      final parse = jsonDecode(response.body);
      if (parse['status'] == "OK") {
        setState(() {
          SearchPlaceModel searchPlaceModel = SearchPlaceModel.fromJson(parse);
          searchPlace = searchPlaceModel.predictions!;
          if (kDebugMode) {
            print(searchPlace.length);
          }
        });
      }
    } catch (err) {}
  }

  Future<void> _getLatLang() async {
    final query = locationController.text;
    locations = await locationFromAddress(query);

    setState(() {
      var first = locations.first;
      lat = first.latitude;
      long = first.longitude;
      if (kDebugMode) {
        print("*****lat ${lat} : ${long}**********long");
      }
    });
  }

  Future<void> _startRecording(ImageSource source) async {
    final video = await ImagePicker().pickVideo(source: source,maxDuration: const Duration(seconds: 15)) ;
    if(video != null) {
      // final trimmedVideoPath = await trimVideo(video.path, duration: 15);
      await compressVideo(video.path);
    }
  }

  // Future<String> trimVideo(String videoPath, {required int duration}) async {
  //   final flutterFFmpeg = FFmpegKit();
  //
  //   // Output path for the trimmed video
  //   final outputFilePath = '/path/to/output/trimmed_video.mp4';
  //
  //   // Execute FFmpeg command to trim the video
  //   await flutterFFmpeg.(
  //       '-i $videoPath -ss 0 -t $duration -c copy $outputFilePath');
  //
  //   return outputFilePath;
  // }

  Future<void> compressVideo(String inputPath) async {
    CommonFunctions.showLoadingDialog(context, "Uploading") ;
    final MediaInfo? info = await VideoCompress.compressVideo(
      inputPath,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
    );

    if (kDebugMode) {
      print('Compressed video path: ${info?.path}');
    }
    if(info?.path != null && info?.path?.length != 0 ) {
      setState(() {
        videoFilePath = info!.path! ;
        if (kDebugMode) {
          print("this is file size ================== ${info.filesize}") ;
        }
      });
      Get.back() ;
    }
  }
}
