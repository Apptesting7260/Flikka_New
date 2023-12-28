import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flikka/Payment_Methods/wallet.dart';
import 'package:flikka/controllers/EditAboutController/EditAboutController.dart';
import 'package:flikka/controllers/EditSeekerAppreciationController/EditSeekerAppreciationController.dart';
import 'package:flikka/controllers/EditSeekerLanguageController/EditSeekerLanguageController.dart';
import 'package:flikka/controllers/EditSeekerPofileController/EditSeekerProfileController.dart';
import 'package:flikka/controllers/EditSeekerResumeController/EditSeekerResumeController.dart';
import 'package:flikka/controllers/EditSeekerSoftSkillsController/EditSeekerSoftSkillsController.dart';
import 'package:flikka/controllers/EditSeekerWorkExperience/EditSeekerWorkExperience.dart';
import 'package:flikka/controllers/SeekerChoosePositionGetController/SeekerChoosePositionGetController.dart';
import 'package:flikka/controllers/SeekerGetAllSkillsController/SeekerGetAllSkillsController.dart';
import 'package:flikka/controllers/SeekerUpdateVideoController/SeekerUpdateVideoController.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flikka/data/response/status.dart';
import 'package:flikka/models/ViewSeekerProfileModel/ViewSeekerProfileModel.dart';
import 'package:flikka/utils/CommonFunctions.dart';
import 'package:flikka/utils/RangeSlider.dart';
import 'package:flikka/utils/VideoPlayerScreen.dart';
import 'package:flikka/utils/utils.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart' as i;
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:open_file/open_file.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_trimmer/video_trimmer.dart';
import '../../../controllers/AvtarImageController/AvtarImageController.dart';
import '../../../controllers/AvtarImageListController/AvtarImageListController.dart';
import '../../../controllers/EditMobileNumberController.dart';
import '../../../controllers/ViewLanguageController/ViewLanguageController.dart';
import '../../../models/SearchPlaceModel/SearchPlaceModel.dart';
import '../../../models/SeekerGetAllSkillsModel/SeekerGetAllSkillsModel.dart';
import '../../../res/components/general_expection.dart';
import '../../../res/components/internet_exception_widget.dart';
import '../../../utils/CommonWidgets.dart';
import '../../../utils/Constants.dart';
import '../../../utils/MultiSelectField.dart';
import 'package:http/http.dart' as http;


class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  AvtarImageController avtarImageController = Get.put(AvtarImageController()) ;

  SeekerChoosePositionGetController seekerChoosePositionGetController = Get.put(SeekerChoosePositionGetController());

  Key myIntlPhoneFieldKey = GlobalKey();
  String? phoneNumber;
  var phoneController = TextEditingController();

  //////refresh//////
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    await seekerProfileController.viewSeekerProfileApi();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await seekerProfileController.viewSeekerProfileApi();
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  /////refresh/////

  Future<void> _openImagePickerDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          title: Center(
            child: Text(
              'Please choose image',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                width: Get.width * .25,
                height: Get.height * .05,
                title: "Camera", onTap1: () {
                _pickImage(i.ImageSource.camera);
              },),
              const SizedBox(width: 10,),
              MyButton(
                width: Get.width * .25,
                height: Get.height * .05,
                title: "Gallery", onTap1: () {
                _pickImage(i.ImageSource.gallery);
              },),
            ],
          ),
        );
      },
    );
  }

  File? imageFile;
  String resumePath = '';
  String documentPath = '';
  final imgPicker = i.ImagePicker();
  final imageCropper = ImageCropper();

  Future<void> _pickImage(abc) async {
    final pickedImage = await i.ImagePicker().pickImage(source: abc);

    if (pickedImage != null) {
      final croppedImage = await imageCropper.cropImage(
        sourcePath: pickedImage.path,

        aspectRatio: const CropAspectRatio(ratioX: 1.5, ratioY: 2), // Adjust aspect ratio as needed
        compressQuality: 60,
        // maxHeight: 400, // Set your maximum height
        // maxWidth: 800,  // Set your maximum width
          uiSettings: [
          AndroidUiSettings(
          toolbarTitle: 'Cropper',
          hideBottomControls: true,
          toolbarColor: AppColors.blueThemeColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
          IOSUiSettings(title: 'Cropper', aspectRatioLockEnabled: true),
            WebUiSettings(
              context: context,
              presentStyle: CropperPresentStyle.dialog,
              boundary: const CroppieBoundary(
                width: 520,
                height: 520,
              ),
              viewPort:
              const CroppieViewPort(width: 400, height: 400, type: 'circle'),
              enableExif: false,
              enableZoom: false,
              showZoomer: false,
            )
    ],// Adjust compression quality as needed
      );
      setState(() {
        imageFile = File(croppedImage!.path);
        editSeekerProfileController.profileApi(
            imageFile?.path, "", "", "", context);
        print(imageFile);
        Get.back();
      });
    }
  }

  String uri = '';

  EditAboutController editAboutController = Get.put(EditAboutController());
  EditSeekerLanguageController editSeekerLanguageController = Get.put(EditSeekerLanguageController()) ;
  EditSeekerProfileController editSeekerProfileController = Get.put(EditSeekerProfileController());
  EditSeekerExperienceController editSeekerExperienceController = Get.put(EditSeekerExperienceController()) ;
  EditSeekerAppreciationController editSeekerAppreciationController = Get.put(EditSeekerAppreciationController()) ;
  EditSeekerResumeController editSeekerResumeController = Get.put(EditSeekerResumeController()) ;
  EditSeekerSoftSkillsController editSeekerSoftSkillsController = Get.put(EditSeekerSoftSkillsController()) ;
  ViewLanguageController viewLanguageController = Get.put(ViewLanguageController()) ;
  SeekerGetAllSkillsController skillsController = Get.put(SeekerGetAllSkillsController()) ;
  SeekerGetAllSkillsController seekerGetAllSkillsController = Get.put(SeekerGetAllSkillsController()) ;
  EditMobileNumberControllerSeeker editMobileNumberController = Get.put(EditMobileNumberControllerSeeker()) ;

  final seekerGetAllSkillsData =  SeekerGetAllSkillsModel().obs ;
  String _documentTypeFilePath = '';
  var DocumentType;
  final List selectDocumentType = [
    'passport',
    'id_card',
  ];

  skillSection(
      List? list ,
      int number
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List selectedChooseSkillsIndices = [];
        selectedChooseSkillsIndices = list ?? [] ;
        print(list) ;
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StatefulBuilder(
              builder: (context , setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(number == 1 ? "Soft Skills" :
                    number == 2 ? "Passion" :
                    number == 3 ? "Industry Preference" :
                    number == 4 ? "Strengths" :
                    number == 5 ? "When can i start working?" : "Availability", style: Theme.of(context).textTheme.displaySmall,),
                    SizedBox(
                      height: Get.height * 0.4,
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 65),
                        itemCount: number == 1 ? skillsController.seekerGetAllSkillsData.value.softSkill?.length :
                        number == 2 ? skillsController.seekerGetAllSkillsData.value.passion?.length :
                        number == 3 ? skillsController.seekerGetAllSkillsData.value.industry?.length :
                        number == 4 ? skillsController.seekerGetAllSkillsData.value.strengths?.length :
                        number == 5 ? skillsController.seekerGetAllSkillsData.value.startWork?.length :
                            skillsController.seekerGetAllSkillsData.value.availabity?.length ,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var data ;
                          if(number == 1) {
                            data = skillsController.seekerGetAllSkillsData.value.softSkill?[index] ;
                          } else if(number == 2) {
                            data = skillsController.seekerGetAllSkillsData.value.passion?[index] ;
                          } else if (number == 3) {
                            data = skillsController.seekerGetAllSkillsData.value.industry?[index] ;
                          } else if (number == 4) {
                            data = skillsController.seekerGetAllSkillsData.value.strengths?[index] ;
                          } else if (number == 5) {
                            data = skillsController.seekerGetAllSkillsData.value.startWork?[index] ;
                          } else if (number == 6) {
                            data = skillsController.seekerGetAllSkillsData.value.availabity?[index] ;
                          }
                          final isSelected = selectedChooseSkillsIndices
                              .contains("${data?.id.toString()}");

                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * .02,
                                vertical: Get.height * .01),
                            child: GestureDetector(
                              onTap: () {
                                if (number == 5) {
                                  setState(() {
                                    if (selectedChooseSkillsIndices
                                        .contains("${data?.id.toString()}")) {
                                      selectedChooseSkillsIndices
                                          .remove("${data?.id.toString()}");
                                    } else {
                                      selectedChooseSkillsIndices.clear() ;
                                      selectedChooseSkillsIndices
                                          .add("${data?.id.toString()}");
                                    }
                                    print(index);
                                  });
                                } else {
                                setState(() {
                                  if (selectedChooseSkillsIndices.contains("${data?.id.toString()}")) {
                                    selectedChooseSkillsIndices.remove("${data?.id.toString()}");
                                  } else {
                                    selectedChooseSkillsIndices.add("${data?.id.toString()}");
                                  }
                                  print(index);
                                });}
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    border: Border.all(color: isSelected ? AppColors.blueThemeColor : const Color(0xffFFFFFF))
                                ),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: Get.width * .02,),
                                    Stack(alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: Get.width * .06,
                                          height: Get.height * .05,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.blueThemeColor
                                          ),
                                          child: const Icon(Icons.check,
                                            color: Color(0xffFFFFFF), size: 15,),),
                                        if (!selectedChooseSkillsIndices.contains("${data?.id.toString()}"))
                                          Center(
                                            child: Container(width: Get.width * .05,
                                              height: Get.width * .05,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,),
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(width: Get.width * .02,),
                                    Expanded(
                                        child: Text(
                                          number == 1 ? "${data?.skills}":
                                        number == 2 ? "${data?.passion}" :
                                        number == 3 ? "${data?.industryPreferences}" :
                                        number == 4 ? "${data?.strengths}" :
                                        number == 5 ? "${data?.startWork}" : "${data?.availabity}",
                                    overflow: TextOverflow.ellipsis,  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500,
                                        color: isSelected ? AppColors.blueThemeColor : const Color(0xffFFFFFF)),))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },),
                    ),
                    SizedBox(height: Get.height *0.02,) ,
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyButton(
                          width: 100,
                          height: 40,
                          onTap1: () {
                            Navigator.of(context).pop();
                          }, title: 'Cancel',
                        ),
                        const SizedBox(width: 20,),
                        Obx(() =>
                            MyButton(
                              width: 100,
                              height: 40,
                              loading: editSeekerSoftSkillsController.loading.value,
                              onTap1: () {
                                editSeekerSoftSkillsController.skillsApi(selectedChooseSkillsIndices , number) ;
                              },
                              title: 'Submit',
                            ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02,),
                  ],
                );
              }
            ),
          ),
        );
      },
    );
  }

  aboutSection(String? about) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        editAboutController.loading.value = false;
        TextEditingController aboutSectionController = TextEditingController();
        aboutSectionController.text = about ?? "";
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.02,),
                CommonWidgets.textFieldHeading(context, "About Me"),
                SizedBox(height: Get.height * 0.01,),
                TextField(
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                  onChanged: (String value) {},
                  controller: aboutSectionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xff373737),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: BorderSide.none
                    ),
                    hintText: 'Enter about',
                    hintStyle: Theme
                        .of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.white, fontSize: 12),
                  ),
                ),
                SizedBox(height: Get.height * 0.02,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      width: 100,
                      height: 40,
                      onTap1: () {
                        Navigator.of(context).pop();
                      }, title: 'Cancel',
                    ),
                    const SizedBox(width: 20,),
                    Obx(() =>
                        MyButton(
                          width: 100,
                          height: 40,
                          loading: editAboutController.loading.value,
                          onTap1: () {
                            var aboutText = CommonFunctions.changeToHTML(aboutSectionController.text ?? "") ;
                            editAboutController.aboutApi(aboutText, context);
                          },
                          title: 'Submit',
                        ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02,),
              ],
            ),
          ),
        );
      },
    );
  }

  ////mobile number////
  mobileNumberSection(String? mobile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        editMobileNumberController.loading.value = false;
        TextEditingController mobileNumberSectionController = TextEditingController();
        var phone = mobile ;
        bool validPhone = true ;
        Country? selectedCountry ;
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StatefulBuilder(
              builder: (context , setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.02,),
                    CommonWidgets.textFieldHeading(context, "Phone number"),
                    SizedBox(height: Get.height * 0.01,),
                    IntlPhoneField(
                      flagsButtonPadding: const EdgeInsets.only(bottom: 3),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: myIntlPhoneFieldKey,
                      controller: mobileNumberSectionController,
                      // initialValue: '+44',
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
                            borderSide:  BorderSide.none,
                        ),
                      ),
                      languageCode: "en",
                      onChanged: (PhoneNumber value) {
                        if(!value.isValidNumber()) {
                          validPhone = false ;
                        } else {
                          validPhone = true ;
                        } if(value.countryCode == "+44") {
                          validPhone = RegExp(r'^\+44\d{10}$').hasMatch(value.completeNumber);
                        }

                          phone = value.completeNumber;
                          debugPrint("this is ========= $validPhone");

                          setState(() {});
                      },
                      onCountryChanged: (country) {
                        setState(() {
                          selectedCountry = country ;
                        });
                        print('Country changed to: ${country.name}');
                        print(country.dialCode + phoneController.text);
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyButton(
                          width: 100,
                          height: 40,
                          onTap1: () {
                            Navigator.of(context).pop();
                          }, title: 'Cancel',
                        ),
                        const SizedBox(width: 20,),
                        Obx(() =>
                            MyButton(
                              width: 100,
                              height: 40,
                              loading: editMobileNumberController.loading.value,
                              onTap1: () {
                                debugPrint("this is on tap ========= $validPhone");
                                if(validPhone) {
                                  editMobileNumberController.mobileNumberApi(phone ?? "", context) ;
                                }
                              },
                              title: 'Submit',
                            ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02,),
                  ],
                );
              }
            ),
          ),
        );
      },
    );
  }
  ////mobile number////


  introSection(String? name,
      String? location,
      String? positions,
      var id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        editSeekerProfileController.loading.value = false;
        TextEditingController nameController = TextEditingController();
        TextEditingController locationController = TextEditingController();
        var positionId;
        nameController.text = name ?? "";
        locationController.text = location ?? "";
        positionId = id;
        var selectedPosition;
        List<Location> locations = [] ;
        double? lat;
        double? long;
        List<Predictions> searchPlace = [];
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
          final query = locationController.text;
          locations = await locationFromAddress(query);

          setState(() {
          var first = locations.first;
          lat = first.latitude;
          long = first.longitude;
          print("*****lat ${lat} : ${long}**********long");
          });
        }
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Obx(() =>
                  Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                    child: seekerChoosePositionGetController.refreshLoading.value ?
                    const CircularProgressIndicator()
                        : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Get.height * 0.02,),
                            CommonWidgets.textFieldHeading(context, "Full Name"),
                            SizedBox(height: Get.height * 0.01,),
                            TextField(
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                              onChanged: (String value) {
                              },
                              controller: nameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xff373737),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(33),
                                  borderSide: BorderSide.none
                                ),
                                hintText: 'Enter name',
                                hintStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                    color: AppColors.white, fontSize: 12),
                              ),
                            ),
                            SizedBox(height: Get.height * 0.02,),
                            CommonWidgets.textFieldHeading(context, "Location"),
                            SizedBox(height: Get.height * 0.01,),
                            TextField(
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                              onChanged: (value) {
                                setState(() {
                                  if (locationController.text.isEmpty) {
                                  }
                                });
                                searchAutocomplete(value);
                              },
                              controller: locationController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xff373737),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(33),
                                    borderSide: BorderSide.none
                                ),
                                hintText: 'Enter location',
                                hintStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                    color: AppColors.white, fontSize: 12),
                              ),
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
                                          locationController.text = searchPlace[index].description ?? "";
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
                            Flexible(child: SizedBox(height: Get.height * 0.02,)),
                            CommonWidgets.textFieldHeading(context, "Position"),
                            SizedBox(height: Get.height * 0.01,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                                color: Color(0xff373737),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  padding: EdgeInsets.symmetric(horizontal: Get.width*.04,vertical: Get.height*.01),
                                  isExpanded: true,
                                  value: selectedPosition,
                                  hint: Text(
                                    positions == null || positions.length == 0 ? "Select Position" : positions,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                        color: const Color(0xffCFCFCF)),
                                  ),
                                  items: seekerChoosePositionGetController
                                      .seekerChoosePositionGetList.value.data?.map((
                                      document) {
                                    return DropdownMenuItem(
                                      value: document.positions,
                                      child: Text("${document.positions}",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyMedium),
                                      onTap: () {
                                        setState(() {
                                          positionId = document.id;
                                          print(positionId);
                                          selectedPosition = document.positions!;
                                        });
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    // setState(() {
                                    //   selectedPosition = value.toString();
                                    // });
                                  },
                                ),
                              ),
                            ),
                            Flexible(child: SizedBox(height: Get.height * .02,)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyButton(
                                  width: 100,
                                  height: 40,
                                  onTap1: () {
                                    Navigator.of(context).pop();
                                  }, title: 'Cancel',
                                ),
                                const SizedBox(width: 20,),
                                Obx(() =>
                                    MyButton(
                                      width: 100,
                                      height: 40,
                                      loading: editSeekerProfileController.loading.value,
                                      onTap1: () {
                                        editSeekerProfileController.profileApi(null, nameController.text, locationController.text, positionId, context);
                                      },
                                      title: 'Submit',
                                    ),
                                ),
                              ],
                            ),
                            Flexible(child: SizedBox(height: Get.height * 0.02,)),
                          ],
                        ),
                      ),
                    ),
                  ),
              );
            }
        );

      },
    );
  }

  //********************* for workexperience *************
  TextEditingController workexperienceController = TextEditingController();

  workExperienceSection(
      bool experience ,
      String? job ,
      String? company ,
      String? startDate ,
      String? endDate ,
      int index ,
  {
    bool? add
  }
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final key = GlobalKey<FormState>() ;
        final startDateKey = GlobalKey<FormState>() ;
        final endDateKey = GlobalKey<FormState>() ;
        TextEditingController jobTitleOrEducationLevelController = TextEditingController();
        TextEditingController companyOrInstituteController = TextEditingController();
        _startDateController.text = startDate ?? "" ;
        _endDateController.text = endDate ?? "" ;
        companyOrInstituteController.text = company ?? "" ;
        jobTitleOrEducationLevelController.text = job ?? "" ;
        bool present  = _endDateController.text == "present" ? true : false;
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StatefulBuilder(
              builder: (context , setState) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: Get.height* 0.02,) ,
                            CommonWidgets.textFieldHeading(context,experience ? "Work Experience" : "Level of education"),
                            SizedBox(height: Get.height* 0.01,) ,
                            TextFormField(
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                              onChanged: (String value) {

                              },
                              controller: jobTitleOrEducationLevelController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xff373737),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(33),
                                    borderSide: BorderSide.none
                                ),
                                hintText: experience ?  'Enter job title' : "Enter education level",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.white, fontSize: 12),
                              ),
                              validator: (value) {
                                if(value == null || value.isEmpty) {
                                  return 'Please fill this field' ;
                                }
                              },
                            ),
                            SizedBox(height: Get.height* 0.02,) ,
                            CommonWidgets.textFieldHeading(context,experience ? "Company Name" : "Institution name"),
                            SizedBox(height: Get.height* 0.01,) ,
                            TextFormField(
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                              onChanged: (String value) {},
                              controller: companyOrInstituteController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xff373737),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(33),
                                    borderSide: BorderSide.none
                                ),
                                hintText: experience ? 'Enter company name' : 'Enter institute name',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.white, fontSize: 12),
                              ),
                              validator: (value) {
                                if(value == null || value.isEmpty) {
                                  return 'Please fill this field' ;
                                }
                              },
                            ),
                            SizedBox(height: Get.height* 0.02,),
                          ],
                        ),
                      ) ,
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment
                            .start,
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
                                  Form(
                                    key: startDateKey,
                                    child: TextFormField(
                                      controller: _startDateController,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                          color: Color(0xffCFCFCF),
                                          fontSize: 12,
                                          fontWeight: FontWeight
                                              .w400),
                                      onTap: () => _selectDate(true,context,"") ,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        errorStyle: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight
                                                .w300,
                                            fontSize: 12),
                                        constraints: const BoxConstraints(
                                          //maxWidth: Get.width * 0.41,
                                        ),
                                        filled: true,
                                        fillColor: const Color(
                                            0xff373737),
                                        hintText: "Select date",
                                        contentPadding: EdgeInsets
                                            .symmetric(
                                            vertical: Get.height *
                                                .027,
                                            horizontal: Get.width *
                                                .06),
                                        hintStyle: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                            color: Color(0xffCFCFCF),
                                            fontSize: 12,
                                            fontWeight: FontWeight
                                                .w400),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(35),
                                            borderSide: BorderSide
                                                .none),
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
                                  Form(key : endDateKey,
                                    child: TextFormField(
                                      controller: _endDateController,
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: const Color(0xffCFCFCF), fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                      onTap: () {
                                        if(!present) {
                                          if (startDateKey.currentState!.validate()) {
                                            _selectDate(false, context, _startDateController.text);
                                          }
                                        }
                                      },
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xff373737),
                                        hintText: "Select date",
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: Get.height * .027,
                                            horizontal: Get.width * .06),
                                        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: const Color(0xffCFCFCF),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(35),
                                            borderSide: BorderSide.none
                                        ),
                                        suffixIcon: const Icon(
                                          Icons.calendar_month,
                                          size: 13,
                                        ),
                                      ),
                                      validator: (value) {
                                        if(value == null || value.isEmpty) {
                                          return 'Select end date' ;
                                        }
                                      },
                                    ),
                                  ),
                                Row(
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)),
                                      value: present,
                                      onChanged: (val) {
                                        setState(() {
                                          present = val!;
                                          if(present){
                                            _endDateController.text = "present" ;
                                          }else {
                                            _endDateController.text = "" ;
                                          }
                                        });
                                      },
                                      side: BorderSide(color: AppColors.blueThemeColor),
                                      activeColor: AppColors.blueThemeColor,
                                    ),
                                    Text( "Present",
                                        style:  Theme.of(context).textTheme.labelLarge?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xffFFFFFF),
                                        )),
                                  ],
                                )
                                ],
                              )),
                        ],
                      ),
                      SizedBox(height: Get.height*.02,) ,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                            width: 100,
                            height: 40,
                            onTap1: () {
                              Navigator.of(context).pop();
                            }, title: 'Cancel',
                          ),
                          const SizedBox(width: 20,) ,
                          Obx( () =>
                           MyButton(
                              width: 100,
                              height: 40,
                              loading: editSeekerExperienceController.loading.value,
                              onTap1: () {
                                if(_endDateController.text.isEmpty ) {

                                }
                                if(key.currentState!.validate() && startDateKey.currentState!.validate() &&
                                    endDateKey.currentState!.validate()) {
                                  if (experience == true) {
                                    WorkExpJob experienceData = WorkExpJob() ;
                                    if (add == true) {
                                      experienceData.workExpJob = jobTitleOrEducationLevelController.text ;
                                      experienceData.companyName = companyOrInstituteController.text ;
                                      experienceData.jobStartDate = _startDateController.text ;
                                      experienceData.jobEndDate = present ? "present" : _endDateController.text ;
                                      debugPrint("this is experience ${experienceData.companyName}") ;
                                      seekerProfileController.viewSeekerData.value.workExpJob?.add(experienceData);
                                      debugPrint("this is experience list ${seekerProfileController.viewSeekerData.value.workExpJob}") ;
                                      editSeekerExperienceController.workApi(true, seekerProfileController.viewSeekerData.value.workExpJob, context);
                                    } else {
                                      seekerProfileController.viewSeekerData.value.workExpJob?[index].workExpJob = jobTitleOrEducationLevelController.text;
                                      seekerProfileController.viewSeekerData.value.workExpJob?[index].companyName = companyOrInstituteController.text;
                                      seekerProfileController.viewSeekerData.value.workExpJob?[index].jobStartDate = _startDateController.text;
                                      seekerProfileController.viewSeekerData.value.workExpJob?[index].jobEndDate =  present ? "present" : _endDateController.text;
                                      editSeekerExperienceController.workApi(true, seekerProfileController.viewSeekerData.value.workExpJob, context);
                                    }
                                  } else {
                                    EducationLevel educationData = EducationLevel() ;
                                    if (add == true) {
                                      educationData.educationLevel = jobTitleOrEducationLevelController.text ;
                                      educationData.institutionName = companyOrInstituteController.text ;
                                      educationData.educationStartDate = _startDateController.text ;
                                      educationData.educationEndDate =  present ? "present" : _endDateController.text ;
                                      seekerProfileController.viewSeekerData.value.educationLevel?.add(educationData) ;
                                      editSeekerExperienceController.workApi(false, seekerProfileController.viewSeekerData.value.educationLevel, context);
                                    } else {
                                      seekerProfileController.viewSeekerData.value.educationLevel?[index].educationLevel = jobTitleOrEducationLevelController.text;
                                      seekerProfileController.viewSeekerData.value.educationLevel?[index].institutionName = companyOrInstituteController.text;
                                      seekerProfileController.viewSeekerData.value.educationLevel?[index].educationStartDate = _startDateController.text;
                                      seekerProfileController.viewSeekerData.value.educationLevel?[index].educationEndDate =  present ? "present" : _endDateController.text;
                                      editSeekerExperienceController.workApi(false, seekerProfileController.viewSeekerData.value.educationLevel, context);
                                    }
                                  }
                                }
                              }, title: 'Submit',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height* 0.02,) ,
                    ],
                  ),
                );
              }
            ),
          ),
        );
      },
    );
  }

  //********************* for education *************
  TextEditingController educationController = TextEditingController();

  //********************* for skill *************
  TextEditingController skillController = TextEditingController();

  salarySection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        RangePicker.maxValue = double.tryParse("${seekerProfileController.viewSeekerData.value.seekerDetails?.maxSalary}") ?? 10000.0 ;
        RangePicker.minValue = double.tryParse("${seekerProfileController.viewSeekerData.value.seekerDetails?.minSalary}") ?? 5000.0 ;
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StatefulBuilder(
                builder: (context , setState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: Get.height *0.01,) ,
                      Text("Salary expectation", style: Theme.of(context).textTheme.displaySmall,),
                      SizedBox(height: Get.height *0.01,) ,
                      SizedBox(
                        height: Get.height*.12,
                          child: RangePicker(maxSalary: double.tryParse('100000'),)),
                      SizedBox(height: Get.height *0.02,) ,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                            width: 100,
                            height: 40,
                            onTap1: () {
                              Navigator.of(context).pop();
                            }, title: 'Cancel',
                          ),
                          const SizedBox(width: 20,),
                          Obx(() =>
                              MyButton(
                                width: 100,
                                height: 40,
                                loading: editSeekerSoftSkillsController.salaryLoading.value,
                                onTap1: () {
                                  editSeekerSoftSkillsController.salaryApi(RangePicker.minValue , RangePicker.maxValue) ;
                                },
                                title: 'Submit',
                              ),
                            // Text("Salary expectation", style: Theme.of(context).textTheme.displaySmall,),
                            // RangePicker(maxSalary: double.tryParse(seekerGetAllSkillsController.seekerGetAllSkillsData.value.salaryExpectation![0].salaryExpectation.toString()),),
                            // SizedBox(height: Get.height *0.02,) ,
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height *0.02,) ,
                    ],
                  );

                }
            ),
          ),
        );
      },
    );
  }

  //********************* for language *************
  TextEditingController languageController = TextEditingController();

   language (List<SeekerLanguages>? list ) {
    showDialog(
      //barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
      List? selectedLanguages =   list?.map((e) => e.languages).toList() ;
      List? selectedIdList = list?.map((e) => e.id.toString()).toList() ;
      debugPrint(selectedIdList.toString()) ;
      debugPrint(selectedLanguages.toString()) ;
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.02,),
                CommonWidgets.textFieldHeading(context, "Language"),
                SizedBox(height: Get.height * 0.01,),
                LanguageSelector(languageList: viewLanguageController.viewLanguageData.value.languages,selectedLanguageList: selectedLanguages , selectedLanguageId: selectedIdList ?? [], ),
                SizedBox(height: Get.height * 0.02,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      width: 100,
                      height: 40,
                      onTap1: () {
                        Navigator.of(context).pop();
                      }, title: 'Cancel',
                    ),
                    const SizedBox(width: 20,),
                    Obx(() =>
                        MyButton(
                          width: 100,
                          height: 40,
                          loading: editSeekerLanguageController.loading.value,
                          onTap1: () {
                            editSeekerLanguageController.languageApi(LanguageSelectorState.languages) ;
                          },
                          title: 'Submit',
                        ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02,),
              ],
            ),
          ),
        );
      },
    );
  }

   document () {
    showDialog(
      //barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        dynamic documentType ;
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StatefulBuilder(
              builder: (context , setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Document Type",
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall,
                    ),
                    SizedBox(height: Get.height * .01,),
                    Container(
                      height: Get.height * 0.076,
                      decoration: BoxDecoration(
                        color: Color(0xff373737),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.06),
                          isExpanded: true,
                          value: documentType,
                          hint: Text(
                            "Select Type",
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                color: const Color(0xffCFCFCF)),
                          ),
                          items: selectDocumentType.map((document) {
                            return DropdownMenuItem(
                              value: document,
                              child: Text(document,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != documentType) {
                              setState(() {
                                documentType = value.toString();
                                debugPrint(documentType) ;
                                editSeekerResumeController.errorMessage.value = "";
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * .033,),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(20),
                      dashPattern: [5, 5],
                      color: const Color(0xffCFCFCF),
                      strokeWidth: 0.7,
                      child: Obx( () =>
                         Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (documentType == null) {
                                  editSeekerResumeController.errorMessage.value = "Please select document type first";
                                } else {
                                  if (editSeekerResumeController.documentPath.value.isNotEmpty) {
                                    // _openDocumentTypeFilePicker();
                                    OpenFile.open(_documentTypeFilePath);
                                  } else {
                                    setState((){
                                      _openFilePicker(false, documentType);
                                      debugPrint(documentType) ;
                                    }) ;

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
                                  child: Obx( () => Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        editSeekerResumeController.documentPath.value == ''
                                            ? Image.asset(
                                          "assets/images/icon_upload_cv.png",
                                          width: Get.width * .07,
                                          height: Get.height * .06,
                                        ) :
                                        SizedBox(width: Get.width * .0),
                                        if (editSeekerResumeController.documentPath.value.isNotEmpty)
                                          SizedBox(
                                            width: Get.width * .6,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                    width: Get.width * .02),
                                                Flexible(
                                                  child: Obx( () =>
                                                     Text(
                                                      "File uploaded: ${editSeekerResumeController.documentPath.value
                                                          .split('/')
                                                          .last}",
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .labelLarge
                                                          ?.copyWith(
                                                          fontWeight: FontWeight
                                                              .w400),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        else
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 8.0, top: 4),
                                            child: Text(
                                              "Upload File",
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                  fontWeight: FontWeight
                                                      .w400),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                right: 5,
                                top: 1,
                                child: editSeekerResumeController.documentPath.value.isEmpty ?
                                const SizedBox() :
                                IconButton(
                                    onPressed: () {
                                      if (documentType == null) {
                                        editSeekerResumeController.errorMessage.value =
                                        "Please select document type first";
                                      } else {
                                        _openFilePicker(false,documentType);
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * .02,),
                    Obx(() =>
                    editSeekerResumeController.errorMessage.value.isEmpty
                        ? const SizedBox()
                        : Center(
                        child: Text(editSeekerResumeController.errorMessage.value,
                          style: const TextStyle(color: Colors.red),
                        ))),
                    SizedBox(height: Get.height*.02,) ,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyButton(
                          width: 100,
                          height: 40,
                          onTap1: () {
                            Navigator.of(context).pop();
                          }, title: 'Cancel',
                        ),
                        const SizedBox(width: 20,) ,
                        Obx( () =>
                            MyButton(
                              width: 100,
                              height: 40,
                              loading: editSeekerResumeController.loading.value,
                              onTap1: () {
                                editSeekerResumeController.fileApi(_documentTypeFilePath, false, documentType);
                              }, title: 'Submit',
                            ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height* 0.02,) ,
                  ],
                );
              }
            ),
          ),
        );
      },
    );
  }

   resume () {
     showDialog(context: context,
         builder: (BuildContext context) {
       return Dialog(
         shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(22)),
         insetPadding: const EdgeInsets.symmetric(horizontal: 20),
         child: StatefulBuilder(
           builder: (context , setState) {
             return Padding(
               padding: EdgeInsets.symmetric( vertical: Get.height * .02 , horizontal: Get.width *.04),
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   // SizedBox(height: Get.height * .02,),
                   DottedBorder(
                     borderType: BorderType.RRect,
                     radius: const Radius.circular(20),
                     dashPattern: [5, 5],
                     color: const Color(0xffCFCFCF),
                     strokeWidth: 0.7,
                     child: Obx( () =>
                         Stack(
                           clipBehavior: Clip.none,
                           children: [
                             GestureDetector(
                               onTap: () {
                                 if(editSeekerResumeController.resumePath.value.isNotEmpty) {
                                   OpenFile.open(resumePath) ;
                                 } else {
                                   _openFilePicker(true, "");
                                 }
                               },
                               child: Container(
                                 height: Get.height * .15,
                                 width: Get.width,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(22),
                                 ),
                                 child: Center(
                                   child: Obx( () =>
                                      Row(
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         editSeekerResumeController.resumePath.value == "" ?
                                         Image.asset(
                                           "assets/images/icon_upload_cv.png",
                                           width: Get.width * .07,
                                           height: Get.height * .06,
                                         ) :
                                         SizedBox(width: Get.width * .0),
                                           if( editSeekerResumeController.resumePath.value.isNotEmpty )
                                           SizedBox(
                                             width: Get.width * .6,
                                             child: Row(
                                               mainAxisSize: MainAxisSize.min,
                                               children: [
                                                 SizedBox(
                                                     width: Get.width * .02),
                                                 Flexible(
                                                   child: Obx( () =>
                                                       Text(
                                                         "File uploaded: ${editSeekerResumeController.resumePath.value.split('/').last}",
                                                         overflow: TextOverflow
                                                             .ellipsis,
                                                         style: Theme
                                                             .of(context)
                                                             .textTheme
                                                             .labelLarge
                                                             ?.copyWith(
                                                             fontWeight: FontWeight
                                                                 .w400),
                                                       ),
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           )
                                         else
                                           Padding(
                                             padding:
                                             const EdgeInsets.only(
                                                 left: 8.0, top: 4),
                                             child: Text(
                                               "Upload File",
                                               style: Theme
                                                   .of(context)
                                                   .textTheme
                                                   .labelLarge
                                                   ?.copyWith(
                                                   fontWeight: FontWeight
                                                       .w400),
                                             ),
                                           ),
                                       ],
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                             Positioned(
                                 right: 5,
                                 top: 1,
                                 child: editSeekerResumeController.resumePath.value.isEmpty ?
                                 const SizedBox() :
                                 IconButton(
                                     onPressed: () {
                                         _openFilePicker(true,"");
                                     },
                                     icon: const Icon(
                                       Icons.edit,
                                       color: Colors.white,
                                     ))),
                           ],
                         ),
                     ),
                   ),
               SizedBox(height: Get.height * .02,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   MyButton(
                     width: 100,
                     height: 40,
                     onTap1: () {
                       Navigator.of(context).pop();
                     }, title: 'Cancel',
                   ),
                   const SizedBox(width: 20,) ,
                   Obx( () =>
                       MyButton(
                         width: 100,
                         height: 40,
                         loading: editSeekerResumeController.loading.value,
                         onTap1: () {
                           editSeekerResumeController.fileApi(resumePath, true,"");
                         }, title: 'Submit',
                       ),
                   ),
                 ],
               ),
               // SizedBox(height: Get.height * .02,),
                 ],
               ),
             );
           }
         ),
       ) ;
     }) ;
  }

  //********************* for appreciation *************
  TextEditingController appreciationController = TextEditingController();

  appreciation(
      int index ,
      String? award ,
      String? achievement ,
      {
        bool? add
      }
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final key = GlobalKey<FormState>() ;
        TextEditingController awardController = TextEditingController() ;
        TextEditingController achievementController = TextEditingController() ;
        awardController.text = award ?? "" ;
        achievementController.text = achievement ?? "" ;
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height* 0.02,) ,
                  CommonWidgets.textFieldHeading(context, "Award name"),
                  SizedBox(height: Get.height* 0.01,) ,
                  TextFormField(
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                    onChanged: (String value) {},
                    controller: awardController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xff373737),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(33),
                          borderSide: BorderSide.none
                      ),
                      hintText: "Enter award name",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.white, fontSize: 12),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please fill this field' ;
                      }
                    },
                  ),
                  SizedBox(height: Get.height* 0.02,) ,
                  CommonWidgets.textFieldHeading(context, "Achievement"),
                  SizedBox(height: Get.height* 0.01,) ,
                  TextFormField(
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13),
                    onChanged: (String value) {},
                    controller: achievementController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xff373737),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(33),
                          borderSide: BorderSide.none
                      ),
                      hintText: 'Enter achievement',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.white, fontSize: 12),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please fill this field' ;
                      }
                    },
                  ),
                  SizedBox(height: Get.height*.02,) ,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        width: 100,
                        height: 40,
                        onTap1: () {
                          Navigator.of(context).pop();
                        }, title: 'Cancel',
                      ),
                      const SizedBox(width: 20,) ,
                      Obx( () =>
                          MyButton(
                            width: 100,
                            height: 40,
                            loading: editSeekerAppreciationController.loading.value,
                            onTap1: () {
                              if(key.currentState!.validate()) {
                                List list = [] ;
                                Appreciation appreciationData = Appreciation() ;
                                if (add == true) {
                                  appreciationData.achievement = achievementController.text ;
                                  appreciationData.awardName = awardController.text ;
                                  print(appreciationData) ;
                                  // seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation?.add(appreciationData) ;
                                  list = seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation ?? [] ;
                                  list.add(appreciationData) ;
                                  debugPrint("this is ,,,,,======================= $list") ;
                                  editSeekerAppreciationController.appreciationApi(list, context);
                                } else {
                                  seekerProfileController.viewSeekerData.value
                                      .seekerDetails?.appreciation?[index]
                                      .awardName = awardController.text;
                                  seekerProfileController.viewSeekerData.value
                                      .seekerDetails?.appreciation?[index]
                                      .achievement = achievementController.text;
                                  editSeekerAppreciationController.appreciationApi(
                                      seekerProfileController.viewSeekerData.value
                                          .seekerDetails?.appreciation, context);
                                }
                              }
                            }, title: 'Submit',
                          ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height* 0.02,) ,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool isWork = false;
  bool isEducation = false;
  bool isAppreciation = false;
  bool isResume = false;

  ViewSeekerProfileController seekerProfileController = Get.put( ViewSeekerProfileController());
  SeekerUpdateVideoController updateVideoController = Get.put(SeekerUpdateVideoController()) ;

  AvtarImageListController avtarController = Get.put(AvtarImageListController()) ;

  Future<void> _openAvtarImageListDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          title: Center(
            child: Text(
              'Please choose avtar',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          content:  SizedBox(
            height: Get.height*.6,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: avtarController.avtarImageList.value.avtarImages?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          CommonFunctions.confirmationDialog(context, message: "Do you want to upload this avtar",
                              onTap: () async {
                            CommonFunctions.showLoadingDialog(context, "uploading...") ;
                            var result = await avtarImageController.avtarImageApiData(context, avtarController.avtarImageList.value.avtarImages?[index].avtarName) ;
                              Get.back() ;
                              Get.back() ;
                              if(result == true) {
                                Get.back() ;
                                Get.back() ;
                              }
                              },);
                        },
                        child: CachedNetworkImage(
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            imageBuilder: (context, imageProvider) => Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: imageProvider,fit: BoxFit.cover)
                              ),
                            ),
                            imageUrl: avtarController.avtarImageList.value.avtarImages?[index].avtarLink ?? ""),
                      ),
                      SizedBox(height: Get.height*.01,),
                    ],
                  ) ;
                },),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // seekerProfileController.viewSeekerProfileApi();
    // viewLanguageController.viewLanguageApi() ;
    // skillsController.seekerGetAllSkillsApi() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (seekerProfileController.rxRequestStatus.value) {
        case Status.LOADING :
          return const Scaffold(body: Center(child: CircularProgressIndicator()),);

        case Status.ERROR:
          if (seekerProfileController.error.value == 'No internet') {
            return InterNetExceptionWidget(
              onPress: () {
                seekerProfileController.viewSeekerProfileApi();
                viewLanguageController.viewLanguageApi() ;
                skillsController.seekerGetAllSkillsApi() ;
              },
            );
          } else {
            return Scaffold(body: GeneralExceptionWidget(
                onPress: () {
                  seekerProfileController.viewSeekerProfileApi();
                  viewLanguageController.viewLanguageApi() ;
                  skillsController.seekerGetAllSkillsApi() ;
                }));
          }
        case Status.COMPLETED:
          return
            SafeArea(
              child: Obx( () => viewLanguageController.loading.value ?
                 const Center(child: CircularProgressIndicator(),)
              :  Scaffold(
                  body: SmartRefresher(
                    controller: _refreshController,
                    onLoading: _onLoading,
                    onRefresh: _onRefresh,
                    child: Stack(
                      children: [
                        Obx( () => editSeekerProfileController.loadingImage.value ?
                        Container( height: Get.height * 0.55,
                            alignment: Alignment.center,
                            child:const CircularProgressIndicator()) :
                        GestureDetector(
                          onTap: () {
                            CommonFunctions.confirmationDialog(context, message: "Do you want to upload avtar", onTap: () {
                              _openAvtarImageListDialog() ;
                            },);

                          },
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: Get.height * 0.5,
                            width: Get.width,
                            placeholder: (context, url) => const Center(child:CircularProgressIndicator()),
                            imageUrl:  "${seekerProfileController.viewSeekerData.value.seekerInfo?.profileImg}" ,),
                        ),
                        ) ,
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Get.height * .02,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Get.offAll(const TabScreen(index: 0)) ;
                                      },
                                      child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.055,)) ,
                                  Container(
                                    decoration: const BoxDecoration(
                                        color: AppColors.black,
                                        shape: BoxShape.circle
                                    ),
                                    child: CircularPercentIndicator(
                                      percent: seekerProfileController.viewSeekerData.value.completeProfile != null ? seekerProfileController.viewSeekerData.value.completeProfile / 100 : 0,
                                      lineWidth: 3,
                                      center: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${seekerProfileController.viewSeekerData.value.completeProfile}%",
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "Profile",
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                color: AppColors.white,
                                                fontSize: 8,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      progressColor: AppColors.blueThemeColor,
                                      backgroundColor: AppColors
                                          .ratingcommentfillcolor,
                                      radius: 25, // Background color
                                    ),
                                  ),
                                ],
                              ) ,
                              SizedBox(height: Get.height * .25,),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Get.to(() => const Wallet());
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 42,
                                        width: 42,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.blueThemeColor
                                        ),
                                        child: Image.asset("assets/images/wallet_icon.png", height: 18,),
                                      )),
                                  SizedBox(width: Get.width * .04,),
                                  GestureDetector(
                                    onTap: () {
                                      _openImagePickerDialog();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 42,
                                      width: 42,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.blueThemeColor
                                      ),
                                      child: Image.asset(
                                        "assets/images/camera.png",
                                        height: 18,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.width * .04,),
                                  GestureDetector(
                                    onTap: () {
                                      if(seekerProfileController.viewSeekerData.value.seekerInfo?.video == null ||
                                          seekerProfileController.viewSeekerData.value.seekerInfo?.video?.length == 0) {
                                        CommonFunctions.confirmationDialog(context, message: "Do you want to upload video", onTap: () {
                                          Get.back() ;
                                          _openVideoPickerDialogUserProfile() ;
                                        },);
                                      } else {
                                        CommonFunctions.doubleButtonDialog(context,
                                            message: "Upload or play introduction video",
                                            onTap1: () {
                                              Get.back() ;
                                              Get.to(() => VideoPlayerScreen(videoPath: seekerProfileController.viewSeekerData.value.seekerInfo!.video!));
                                            },
                                            onTap2: () {
                                              Get.back() ;
                                              _openVideoPickerDialogUserProfile() ;
                                            },
                                            title1: "Play",
                                            title2: "Edit") ;
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 42,
                                      width: 42,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.blueThemeColor
                                      ),
                                      child: Image.asset( seekerProfileController.viewSeekerData.value.seekerInfo?.video == null ||
                                          seekerProfileController.viewSeekerData.value.seekerInfo?.video?.length == 0 ? "assets/images/icon_video_upload.png"
                                       : "assets/images/icon_video.png",
                                        height: 18,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        DraggableScrollableSheet(
                          initialChildSize: 0.5, // half screen
                          minChildSize: 0.5, // half screen
                          maxChildSize: 1, // full screen
                          builder: (BuildContext context, ScrollController scrollController) {
                            return
                              Container(decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(35),
                                  topLeft: Radius.circular(35),
                                ),
                              ),
                                child: ListView(
                                  controller: scrollController,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(24),
                                        decoration: const BoxDecoration(
                                            color: AppColors.black,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                topRight: Radius.circular(25))
                                        ),
                                        //height: Get.height,
                                        //width: Get.width,
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(width: Get.width * 0.6,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "${seekerProfileController.viewSeekerData.value.seekerInfo?.fullname}",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: Theme.of(context).textTheme.displayLarge,
                                                        softWrap: true,
                                                      ),
                                                      Text(
                                                          seekerProfileController.viewSeekerData.value.seekerDetails?.positions ?? "No positions" ,
                                                          style: Theme.of(context).textTheme.bodySmall
                                                              ?.copyWith(color: const Color(0xffCFCFCF), fontWeight: FontWeight.w600)
                                                      ),
                                                      SizedBox(height: Get.height * .003,),
                                                      Text(
                                                        "${seekerProfileController.viewSeekerData.value.seekerInfo?.location ?? "No location"}",overflow: TextOverflow.ellipsis,
                                                        style: Theme
                                                            .of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                            color: AppColors
                                                                .ratingcommenttextcolor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      introSection(
                                                          seekerProfileController.viewSeekerData.value.seekerInfo?.fullname,
                                                          seekerProfileController.viewSeekerData.value.seekerInfo?.location,
                                                          seekerProfileController.viewSeekerData.value.seekerDetails?.positions,
                                                          seekerProfileController.viewSeekerData.value.seekerDetails?.position
                                                      );
                                                      seekerChoosePositionGetController.seekerGetPositionApi(true);
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/icon_edit.png",
                                                      height: 18,))
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.04,),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                        child: Image.asset('assets/images/icon_phone_call.png',height: Get.height*.03,)),
                                                    SizedBox(width: Get.width * 0.02,),
                                                    Text('Phone Number', style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white),),

                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    mobileNumberSection(seekerProfileController.viewSeekerData.value.seekerInfo?.phone ?? "") ;
                                                  },
                                                  child: Image.asset(
                                                    "assets/images/icon_edit_phone_number.png",
                                                    height: 18,),
                                                )
                                              ],
                                            ),
                                            CommonWidgets.divider() ,
                                            // SizedBox(height: Get.height * 0.04,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                seekerProfileController.viewSeekerData.value.seekerInfo?.phone == null ||
                                                    seekerProfileController.viewSeekerData.value.seekerInfo?.phone?.length == 0 ?
                                                Text("No phone number", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                                Text(seekerProfileController.viewSeekerData.value.seekerInfo?.phone ??"No Data",style: Theme.of(context).textTheme.bodyLarge!
                                                    .copyWith(color: AppColors.ratingcommenttextcolor),)
                                                // Text("Verify",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700,color: AppColors.blueThemeColor),)
                                              ],
                                            ) ,
                                            SizedBox(height: Get.height*.045,) ,
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                        child: Image.asset('assets/images/about.png',height: Get.height*.03,)),
                                                    SizedBox(width: Get.width * 0.02,),
                                                    Text('About me', style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white),),
                                                  ],
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      aboutSection(CommonFunctions.parseHtmlAndAddNewline(seekerProfileController.viewSeekerData.value.seekerInfo?.aboutMe ?? ""));
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/icon_edit.png",
                                                      height: 18,))
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.01,),
                                            const Divider(
                                              thickness: 0.2,
                                              color: AppColors.white,
                                            ),
                                            SizedBox(height: Get.height * 0.01,),
                                            seekerProfileController.viewSeekerData.value.seekerInfo?.aboutMe == null ||
                                                CommonFunctions.parseHTML(seekerProfileController.viewSeekerData.value.seekerInfo?.aboutMe)?.trim().length == 0 ?
                                            Text("No about", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                            HtmlWidget(seekerProfileController.viewSeekerData.value.seekerInfo?.aboutMe ?? 'No Data', textStyle: Theme.of(context).textTheme.bodyLarge!
                                                .copyWith(color: AppColors.ratingcommenttextcolor),),
                                            SizedBox(height: Get.height * 0.045,),
                                            Row(mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    InkWell(

                                                        child: Image.asset(
                                                          'assets/images/icon_work_experience_.png',height: Get.height*.03,)),
                                                    SizedBox(
                                                      width: Get.width * 0.02,),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          top: 4.0),
                                                      child: Text('Work experience',
                                                        style: Get.theme.textTheme
                                                            .labelMedium!.copyWith(
                                                            color: AppColors
                                                                .white),),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      workExperienceSection(true,"","","","",0,add: true);
                                                    },
                                                    child: Image.asset(
                                                      'assets/images/icon_add_more.png',height: Get.height*.04,))
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.02,),
                                            const Divider(
                                              thickness: 0.2,
                                              color: AppColors.white,
                                            ),
                                            seekerProfileController.viewSeekerData.value.workExpJob == null ||
                                                seekerProfileController.viewSeekerData.value.workExpJob?.length == 0 ?
                                            const Text('Fresher')
                                                : ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: seekerProfileController.viewSeekerData.value.workExpJob?.length,
                                                itemBuilder: (context, index) {
                                                  var data = seekerProfileController.viewSeekerData.value.workExpJob?[index];
                                                  var endDate ;
                                                  var startDate ;
                                                  startDate = DateTime.parse("${data?.jobStartDate}") ;
                                                  startDate = "${startDate.month.toString().padLeft(2,"0")}-${startDate.day.toString().padLeft(2,"0")}-${startDate.year.toString().padLeft(4,"0")}" ;
                                                  if(data?.present == true) {
                                                    endDate = "Present" ;
                                                  }else {
                                                    endDate = DateTime.parse("${data?.jobEndDate}") ;
                                                    endDate = "${endDate.month.toString().padLeft(2,"0")}-${endDate.day.toString().padLeft(2,"0")}-${endDate.year.toString().padLeft(4,"0")}" ;
                                                  }
                                                  // if(data?.present == false) {
                                                  //  DateTime.parse(data!.jobStartDate.toString()) ;
                                                  //  print(data?.jobStartDate) ;
                                                  //  print(data?.jobEndDate) ;
                                                  // }
                                                  return Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: Get.height * 0.02,),
                                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('${data?.workExpJob}',
                                                           overflow: TextOverflow.ellipsis, style: Get.theme.textTheme.bodyMedium!.copyWith(
                                                                color: AppColors.white, fontWeight: FontWeight.w700),),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    workExperienceSection(true,data?.workExpJob,data?.companyName , data?.jobStartDate.toString() , data?.jobEndDate.toString() ,index);
                                                                  },
                                                                  child:  Image.asset("assets/images/icon_edit.png",height: 18)),
                                                              const SizedBox(width: 16,),
                                                              InkWell(
                                                                  onTap: () {
                                                                    _openDeleteDialog(index , true) ;
                                                                  },
                                                                  child: Image.asset('assets/images/icon_delete.png',height: Get.height*.027,)),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: Get.height * 0.01,),
                                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("${data?.companyName}",
                                                           overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),),
                                                          // data?.jobEndDate == 'null' || data?.jobStartDate == 'null'
                                                          //     ? const SizedBox()
                                                          //     : data?.jobEndDate.toString().toLowerCase() == "present" ?
                                                          Text('$startDate    $endDate',
                                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),
                                                          )
                                                          //     :
                                                          // Text('${data?.jobStartDate?.month}-${data?.jobStartDate?.day}-${data?.jobStartDate?.year} - ${data?.jobEndDate?.month}-${data?.jobEndDate?.month}-${data?.jobEndDate?.year}',
                                                          //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                          //       color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),
                                                          // ),
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                }
                                            ),

                                            // ********************* for Education ***************************

                                            SizedBox(height: Get.height * 0.045,),

                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                              children: [
                                                Row(mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                        child: Image.asset('assets/images/Educationsvg.png',height: Get.height*.04,)),
                                                    SizedBox(
                                                      width: Get.width * 0.02,),

                                                    Text('Education',
                                                      style: Get.theme.textTheme
                                                          .labelMedium!.copyWith(
                                                          color: AppColors
                                                              .white),),

                                                  ],
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      workExperienceSection(false,"","","","",0,add: true);
                                                    },
                                                    child: Image.asset('assets/images/icon_add_more.png',height: Get.height*.04,))
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.02,),
                                            const Divider(thickness: 0.2, color: AppColors.white,),
                                            seekerProfileController.viewSeekerData.value.educationLevel == null ||
                                                seekerProfileController.viewSeekerData.value.educationLevel?.length == 0 ?
                                            Text("No education", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: seekerProfileController.viewSeekerData.value.educationLevel?.length,
                                                itemBuilder: (context, index) {
                                                  var data = seekerProfileController.viewSeekerData.value.educationLevel?[index];
                                                  var endDate ;
                                                  var startDate ;
                                                  startDate = DateTime.parse("${data?.educationStartDate}") ;
                                                  startDate = "${startDate.month.toString().padLeft(2,"0")}-${startDate.day.toString().padLeft(2,"0")}-${startDate.year.toString().padLeft(4,"0")}" ;
                                                  if(data?.present == true) {
                                                    endDate = "Present" ;
                                                  } else {
                                                    endDate = "${data?.educationEndDate.month.toString().padLeft(2,'0')}-${data?.educationEndDate.day.toString().padLeft(2,'0')}-${data?.educationEndDate.year.toString().padLeft(4,'0')}" ;
                                                  }
                                                  return Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: Get.height * 0.02,),
                                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('${data?.educationLevel}',
                                                            style: Get.theme.textTheme.bodyMedium!.copyWith(
                                                                color: AppColors.white, fontWeight: FontWeight.w700),),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    workExperienceSection(false,data?.educationLevel, data?.institutionName, data?.educationStartDate.toString(), data?.educationEndDate.toString(), index);
                                                                  },
                                                                  child: Image.asset("assets/images/icon_edit.png",height: 18)),

                                                              const SizedBox(width: 16,),
                                                              InkWell(
                                                                  onTap: () {
                                                                    _openDeleteDialog(index , false) ;
                                                                  },
                                                                  child: Image.asset('assets/images/icon_delete.png',height: Get.height*.027)),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: Get.height * 0.01,),
                                                      Column( crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("${data?.institutionName}",
                                                           overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),),
                                                          // data?.educationStartDate == 'null' || data?.educationEndDate == 'null'
                                                          //     ? const SizedBox()
                                                          //     : data?.educationEndDate.toString().toLowerCase() == "present" ?
                                                          Text('$startDate    $endDate',
                                                            // "${data?.educationStartDate?.month}/${data?.educationStartDate?.year} - ${data?.educationEndDate?.month}/${data?.educationEndDate?.year}",
                                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),)
                                                          //     :
                                                          // Text('${data?.educationStartDate?.month}-${data?.educationStartDate?.day}-${data?.educationStartDate?.year} - ${data?.educationEndDate?.month}-${data?.educationEndDate?.day}-${data?.educationEndDate?.year}',
                                                          //   // "${data?.educationStartDate?.month}/${data?.educationStartDate?.year} - ${data?.educationEndDate?.month}/${data?.educationEndDate?.year}",
                                                          //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                          //       color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),),
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                }
                                            ),

                                            // ********************* for Skill ***************************

                                            SizedBox(height: Get.height * 0.045,),

                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                        child: Image.asset('assets/images/skillsvg.png',height: Get.height*.03,)),
                                                    SizedBox(width: Get.width * 0.02,),
                                                    Text('Skill',
                                                      style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white),),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.02,),
                                            const Divider(
                                              thickness: 0.2,
                                              color: AppColors.white,
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.015,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Soft Skill',
                                                  style: Get.theme.textTheme
                                                      .labelMedium!.copyWith(
                                                      color: AppColors
                                                          .white),),
                                                GestureDetector(
                                                  onTap: () {
                                                    skillSection(seekerProfileController.viewSeekerData.value.seekerDetails?.skillName?.map((e) => e.id.toString()).toList() , 1) ;
                                                  },
                                                  child: Image.asset( "assets/images/icon_edit.png", height: 18,),
                                                )
                                              ],
                                            ),
                                            SizedBox( height: Get.height * 0.015,),

                                            // SizedBox(height: Get.height * 0.02,),
                                            seekerProfileController.viewSeekerData.value.seekerDetails?.skillName == null ||
                                                seekerProfileController.viewSeekerData.value.seekerDetails?.skillName?.length == 0 ?

                                            Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                            GridView.builder(gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                mainAxisExtent: 36,
                                                maxCrossAxisExtent: Get.width * 0.4,
                                                mainAxisSpacing: 8,
                                                crossAxisSpacing: 8),
                                                itemCount: seekerProfileController.viewSeekerData.value.seekerDetails?.skillName?.length,
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  var data = seekerProfileController.viewSeekerData.value.seekerDetails?.skillName?[index];
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(12),
                                                      color: AppColors.blackdown,
                                                    ),
                                                    padding: const EdgeInsets.all(
                                                        8),
                                                    child: Text('${data?.skills}',
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      style: Get.theme.textTheme
                                                          .bodySmall!.copyWith(
                                                          color: AppColors.white,
                                                          fontWeight: FontWeight
                                                              .w400),),
                                                  );
                                                }),
                                            ///////////passion////////

                                            SizedBox(height: Get.height * 0.025,),
                                            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Passion',
                                                  style: Get.theme.textTheme
                                                      .labelMedium!.copyWith(
                                                      color: AppColors
                                                          .white),),
                                                GestureDetector(
                                                  onTap: () {
                                                    skillSection(seekerProfileController.viewSeekerData.value.seekerDetails?.passionName?.map((e) => e.id.toString()).toList() , 2) ;
                                                  },
                                                  child: Image.asset(
                                                    "assets/images/icon_edit.png",
                                                    height: 18,),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.015,),
                                            seekerProfileController.viewSeekerData.value.seekerDetails?.passionName ==
                                                null ||
                                                seekerProfileController.viewSeekerData.value.seekerDetails?.passionName?.length == 0 ?

                                            Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                            GridView.builder(gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                mainAxisExtent: 36,
                                                maxCrossAxisExtent: Get.width * 0.4,
                                                mainAxisSpacing: 8,
                                                crossAxisSpacing: 8),
                                                itemCount: seekerProfileController.viewSeekerData.value.seekerDetails?.passionName?.length,
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  var data = seekerProfileController.viewSeekerData.value.seekerDetails?.passionName?[index];
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      color: AppColors.blackdown,),
                                                    padding: const EdgeInsets.all(8),
                                                    child: Text('${data?.passion}',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: Get.theme.textTheme.bodySmall!.copyWith(
                                                          color: AppColors.white, fontWeight: FontWeight.w400),),
                                                  );
                                                }),
                                            //////////passion////////////

                                            ////////industry preference////////////
                                            SizedBox(height: Get.height * 0.025,),
                                            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Industry Preference',
                                                  style: Get.theme.textTheme
                                                      .labelMedium!.copyWith(
                                                      color: AppColors
                                                          .white),),
                                                GestureDetector(
                                                  onTap: () {
                                                    skillSection(seekerProfileController.viewSeekerData.value.seekerDetails?.industryPreferenceName?.map((e) => e.id.toString()).toList() , 3) ;
                                                  },
                                                  child: Image.asset( "assets/images/icon_edit.png", height: 18,),
                                                )
                                              ],
                                            ),

                                            SizedBox(
                                              height: Get.height * 0.015,),
                                            seekerProfileController.viewSeekerData.value.seekerDetails?.industryPreferenceName ==
                                                null ||
                                                seekerProfileController.viewSeekerData.value.seekerDetails?.industryPreferenceName?.length == 0 ?

                                            Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                            GridView.builder(gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                mainAxisExtent: 36,
                                                maxCrossAxisExtent: Get.width * 0.4,
                                                mainAxisSpacing: 8,
                                                crossAxisSpacing: 8),
                                                itemCount: seekerProfileController.viewSeekerData.value.seekerDetails?.industryPreferenceName?.length,
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  var data = seekerProfileController.viewSeekerData.value.seekerDetails?.industryPreferenceName?[index];
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(12),
                                                      color: AppColors.blackdown,),
                                                    padding: const EdgeInsets.all(8),
                                                    child: Text('${data?.industryPreferences}',
                                                      overflow: TextOverflow.ellipsis,
                                                      style: Get.theme.textTheme.bodySmall!.copyWith(
                                                          color: AppColors.white, fontWeight: FontWeight.w400),),
                                                  );
                                                }),
                                            ////////industry preference////////////

                                            //////////////Strengths////////
                                            SizedBox( height: Get.height * 0.025,),
                                            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Strengths',
                                                  style: Get.theme.textTheme
                                                      .labelMedium!.copyWith(
                                                      color: AppColors
                                                          .white),),
                                                GestureDetector(
                                                  onTap: () {
                                                    skillSection(seekerProfileController.viewSeekerData.value.seekerDetails?.strengthsName?.map((e) => e.id.toString()).toList() , 4) ;
                                                  },
                                                  child: Image.asset("assets/images/icon_edit.png", height: 18,),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.015,),
                                            seekerProfileController.viewSeekerData.value.seekerDetails?.strengthsName ==
                                                null ||
                                                seekerProfileController
                                                    .viewSeekerData.value
                                                    .seekerDetails?.strengthsName
                                                    ?.length == 0 ?
                                            Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                            GridView.builder(gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                mainAxisExtent: 36,
                                                maxCrossAxisExtent: Get.width * 0.4,
                                                mainAxisSpacing: 8,
                                                crossAxisSpacing: 8),
                                                itemCount: seekerProfileController
                                                    .viewSeekerData.value
                                                    .seekerDetails?.strengthsName
                                                    ?.length,
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  var data = seekerProfileController
                                                      .viewSeekerData.value
                                                      .seekerDetails
                                                      ?.strengthsName?[index];
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(12),
                                                      color: AppColors.blackdown,
                                                    ),
                                                    padding: const EdgeInsets.all(
                                                        8),
                                                    child: Text('${data?.strengths}',
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      style: Get.theme.textTheme
                                                          .bodySmall!.copyWith(
                                                          color: AppColors.white,
                                                          fontWeight: FontWeight
                                                              .w400),),
                                                  );
                                                }),
                                            //////////////Strengths////////

                                            //////////////Salary expectation////////
                                            SizedBox(height: Get.height * 0.025,),
                                            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Salary expectation',
                                                  style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white),),
                                                GestureDetector(
                                                  onTap: () {
                                                    salarySection() ;
                                                  },
                                                  child: Image.asset("assets/images/icon_edit.png", height: 18,),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.015,),
                                            seekerProfileController.viewSeekerData.value.seekerDetails?.maxSalary == null ||
                                                seekerProfileController.viewSeekerData.value.seekerDetails?.maxSalary.toString().length == 0 ?
                                            Text("No salary expectation", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(12),
                                                color: AppColors.blackdown,
                                              ),
                                              padding: const EdgeInsets.symmetric(horizontal : 20 ,vertical: 8),
                                              child: Text('${seekerProfileController.viewSeekerData.value.seekerDetails?.minSalary} - ${seekerProfileController.viewSeekerData.value.seekerDetails?.maxSalary}',
                                                overflow: TextOverflow.ellipsis,
                                                style: Get.theme.textTheme.bodySmall!.copyWith(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.w400),),
                                            ),
                                            //////////////Salary expectation////////

                                            //////////////When can i start working?////////
                                            SizedBox( height: Get.height * 0.025,),
                                            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('When can i start working?',
                                                  style: Get.theme.textTheme
                                                      .labelMedium!.copyWith(
                                                      color: AppColors
                                                          .white),),
                                                GestureDetector(
                                                  onTap: () {
                                                    skillSection(seekerProfileController.viewSeekerData.value.seekerDetails?.startWorkName?.map((e) => e.id.toString()).toList() , 5) ;
                                                  },
                                                  child: Image.asset("assets/images/icon_edit.png", height: 18,),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.015,),
                                            seekerProfileController.viewSeekerData.value.seekerDetails?.startWorkName == null ||
                                                seekerProfileController.viewSeekerData.value.seekerDetails?.startWorkName?.length == 0 ?
                                            Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                            GridView.builder(gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                mainAxisExtent: 36,
                                                maxCrossAxisExtent: Get.width * 0.4,
                                                mainAxisSpacing: 8,
                                                crossAxisSpacing: 8),
                                                itemCount: seekerProfileController
                                                    .viewSeekerData.value
                                                    .seekerDetails?.startWorkName
                                                    ?.length,
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  var data = seekerProfileController
                                                      .viewSeekerData.value
                                                      .seekerDetails
                                                      ?.startWorkName?[index];
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(12),
                                                      color: AppColors.blackdown,
                                                    ),
                                                    padding: const EdgeInsets.all(
                                                        8),
                                                    child: Text('${data?.startWork}',
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      style: Get.theme.textTheme
                                                          .bodySmall!.copyWith(
                                                          color: AppColors.white,
                                                          fontWeight: FontWeight
                                                              .w400),),
                                                  );
                                                }),
                                            //////////////When can i start working?////////


                                            //////////////Availability?////////
                                            SizedBox(height: Get.height * 0.025,),
                                            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Availability?',
                                                  style: Get.theme.textTheme
                                                      .labelMedium!.copyWith(
                                                      color: AppColors
                                                          .white),),
                                                GestureDetector(
                                                  onTap: () {
                                                    skillSection(seekerProfileController.viewSeekerData.value.seekerDetails?.availabityName?.map((e) => e.id.toString()).toList() , 6) ;
                                                  },
                                                  child: Image.asset(
                                                    "assets/images/icon_edit.png",
                                                    height: 18,),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.015,),
                                            seekerProfileController.viewSeekerData.value.seekerDetails?.availabityName ==
                                                null ||
                                                seekerProfileController.viewSeekerData.value.seekerDetails?.availabityName
                                                    ?.length == 0 ?
                                            Text("No skills", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                            GridView.builder(gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                mainAxisExtent: 36,
                                                maxCrossAxisExtent: Get.width * 0.4,
                                                mainAxisSpacing: 8,
                                                crossAxisSpacing: 8),
                                                itemCount: seekerProfileController
                                                    .viewSeekerData.value
                                                    .seekerDetails?.availabityName
                                                    ?.length,
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  var data = seekerProfileController
                                                      .viewSeekerData.value
                                                      .seekerDetails
                                                      ?.availabityName?[index];
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(12),
                                                      color: AppColors.blackdown,
                                                    ),
                                                    padding: const EdgeInsets.all(
                                                        8),
                                                    child: Text('${data?.availabity}',
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      style: Get.theme.textTheme
                                                          .bodySmall!.copyWith(
                                                          color: AppColors.white,
                                                          fontWeight: FontWeight
                                                              .w400),),
                                                  );
                                                }),
                                            //////////////Availability?////////

                                            SizedBox(height: Get.height * 0.045,),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                        child: SvgPicture.asset('assets/images/language.svg',height: Get.height*.03,)),
                                                    SizedBox(
                                                      width: Get.width * 0.02,),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          top: 2.0),
                                                      child:
                                                      Text('Language',
                                                        style: Get.theme.textTheme
                                                            .labelMedium!.copyWith(
                                                            color: AppColors
                                                                .white),),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      language(seekerProfileController.viewSeekerData.value.seekerDetails?.language );
                                                    },
                                                    child: Image.asset(
                                                      'assets/images/icon_edit.png',height: 18,))
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.02,),
                                            const Divider(
                                              thickness: 0.2,
                                              color: AppColors.white,
                                            ),
                                            SizedBox(height: Get.height * 0.02,),
                                            seekerProfileController.viewSeekerData.value.seekerDetails?.language == null ||
                                                seekerProfileController.viewSeekerData.value.seekerDetails?.language?.length == 0 ?
                                            Text("No language", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :
                                            GridView.builder(gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                mainAxisExtent: 36,
                                                maxCrossAxisExtent: Get.width * 0.4,
                                                mainAxisSpacing: 8,
                                                crossAxisSpacing: 8),
                                                itemCount: seekerProfileController.viewSeekerData.value.seekerDetails?.language?.length,
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  var data = seekerProfileController
                                                      .viewSeekerData.value
                                                      .seekerDetails
                                                      ?.language?[index];
                                                  return Container( alignment: Alignment.center,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                                                      color: AppColors.blackdown,),
                                                    padding: const EdgeInsets.all(8),
                                                    child: Text('${data?.languages}',
                                                      style: Get.theme.textTheme.bodySmall!.copyWith(
                                                          color: AppColors.white, fontWeight: FontWeight.w400),),
                                                  );
                                                }),
                                            //********************* for appreciation ***************************
                                            SizedBox(height: Get.height * 0.04,),
                                            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row( mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                        child: Image.asset( 'assets/images/appreciation.png',height: Get.height*.03,)),
                                                    SizedBox(width: Get.width * 0.02,),
                                                    Padding(padding: const EdgeInsets.only(top: 6.0),
                                                      child: Text('appreciation',
                                                        style: Get.theme.textTheme.labelMedium!.copyWith(
                                                            color: AppColors.white),),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      appreciation(0 , "", "", add: true);
                                                    },
                                                    child: Image.asset('assets/images/icon_add_more.png',height: Get.height*.04,))
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.02,),
                                            const Divider(
                                              thickness: 0.2,
                                              color: AppColors.white,
                                            ),
                                            seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation == null ||
                                                seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation?.length == 0 ?
                                            Text("No appreciation", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),)
                                                : ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation?.length,
                                                itemBuilder: (context, index) {
                                                  var data = seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation?[index];
                                                  return Column( crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: Get.height * 0.02,),
                                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('${data?.awardName}', style: Get.theme.textTheme.bodyMedium!.copyWith(
                                                              color: AppColors.white, fontWeight: FontWeight.w700),),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    appreciation(index , data?.awardName , data?.achievement);},
                                                                  child: Image.asset('assets/images/icon_edit.png',height: 18,)),
                                                              const SizedBox(width: 16,),
                                                              InkWell(
                                                                  onTap: () {
                                                                    _openAppreciationDeleteDialog(index) ;
                                                                  },
                                                                  child: Image.asset('assets/images/icon_delete.png',height: Get.height*.03,)),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: Get.height * 0.01,),
                                                      Column( crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text( "${data?.achievement}",
                                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                color: AppColors.ratingcommenttextcolor, fontWeight: FontWeight.w400),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                }
                                            ),

                                            SizedBox(height: Get.height * 0.04,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    InkWell(child: Image.asset('assets/images/resumesvg.png',height: Get.height*.03,)),
                                                    SizedBox(width: Get.width * 0.02,),
                                                    Text('Resume',
                                                      style: Get.theme.textTheme
                                                          .labelMedium!.copyWith(
                                                          color: AppColors
                                                              .white),),
                                                  ],
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      editSeekerResumeController.resumePath.value = '' ;
                                                      resume() ;
                                                    },
                                                    child: seekerProfileController.viewSeekerData
                                                        .value.seekerInfo?.resume == null || seekerProfileController
                                                        .viewSeekerData.value.seekerInfo?.resume.length == 0 ?
                                                    Image.asset('assets/images/icon_add_more.png',height: Get.height*.04,):
                                                    Image.asset('assets/images/icon_edit.png',height: 18,)
                                                )
                                              ],
                                            ),
                                            SizedBox(height: Get.height * 0.02,),
                                            const Divider(
                                              thickness: 0.2,
                                              color: AppColors.white,
                                            ),
                                            SizedBox(height: Get.height * 0.02,),
                                            seekerProfileController.viewSeekerData.value.seekerInfo?.resume == null ||
                                                seekerProfileController.viewSeekerData.value.seekerInfo?.resume.length == 0 ?
                                            Text("No resume", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),)
                                                : ListTile(
                                              leading: seekerProfileController.viewSeekerData.value.seekerInfo!.resume.toString().contains(".pdf") ?
                                              SvgPicture.asset('assets/images/PDF.svg') : Image.asset("assets/images/doc_icon.png") ,
                                              title: Text(
                                                'Resume',
                                                overflow: TextOverflow.ellipsis,
                                                style: Get.theme.textTheme.bodySmall!.copyWith(
                                                    color: AppColors.white, fontWeight: FontWeight.w500),),
                                              onTap: () {
                                                CommonFunctions.confirmationDialog(context, message: "Do you want to open this file",
                                                  onTap: () async {
                                                    launchUrl(Uri.parse('${seekerProfileController.viewSeekerData.value.seekerInfo?.resumeLink}')) ;
                                                    // String? directory = await getLocalDownloadDir() ;
                                                    // CommonFunctions.downloadFile( '${seekerProfileController.viewSeekerData.value.seekerInfo?.resumeLink}',
                                                    //     '${seekerProfileController.viewSeekerData.value.seekerInfo?.resume}', "$directory" ) ;
                                                    // Get.back() ;
                                                  },) ;
                                              },
                                            ),
                                            SizedBox(height: Get.height * .03,),
                                            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset("assets/images/icon_document.png",height: Get.height*.03,) ,
                                                    SizedBox(width: Get.width*.02,) ,
                                                    Text('Document', style: Get.theme.textTheme.labelMedium!.copyWith(color: AppColors.white),),
                                                  ],
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      editSeekerResumeController.documentPath.value = "" ;
                                                      document() ;

                                                    },
                                                    child: seekerProfileController.viewSeekerData.value.seekerInfo?.documentImg == null ||
                                                        seekerProfileController.viewSeekerData.value.seekerInfo?.documentImg?.length == 0 ?
                                                    Image.asset('assets/images/icon_add_more.png',height: Get.height*.04,):
                                                    Image.asset('assets/images/icon_edit.png',height: 18,)
                                                )
                                              ],
                                            ),
                                            SizedBox(height: Get.height*.015,) ,
                                            const Divider(thickness: 0.2, color: AppColors.white,),
                                            seekerProfileController.viewSeekerData.value.seekerInfo?.documentImg == null ||
                                                seekerProfileController.viewSeekerData.value.seekerInfo?.documentImg?.length == 0 ?
                                            Text("No document", style: Get.theme.textTheme.bodyLarge!.copyWith(color: const Color(0xffCFCFCF)),) :

                                            ListTile(
                                              title: Text('Document',
                                              overflow: TextOverflow.ellipsis,
                                              style: Get.theme.textTheme.bodySmall!.copyWith(
                                                  color: AppColors.white, fontWeight: FontWeight.w500),),
                                                onTap: () {
                                          CommonFunctions.confirmationDialog(context, message: "Do you want to open this file",
                                            onTap: () async {
                                              launchUrl(Uri.parse('${seekerProfileController.viewSeekerData.value.seekerInfo?.documentLink}')) ;
                                              // String? directory = await getLocalDownloadDir() ;
                                              // CommonFunctions.downloadFile( '${seekerProfileController.viewSeekerData.value.seekerInfo?.resumeLink}',
                                              //     '${seekerProfileController.viewSeekerData.value.seekerInfo?.resume}', "$directory" ) ;
                                              // Get.back() ;
                                              Get.back() ;
                                            },) ;
                                        },
                                                leading:  seekerProfileController.viewSeekerData.value.seekerInfo!.documentImg.toString().contains(".pdf" )  ? SvgPicture.asset('assets/images/PDF.svg') :
                                               Image.network("${seekerProfileController.viewSeekerData.value.seekerInfo?.documentLink}", fit: BoxFit.cover, height: Get.height*.1, ),
                                            )   ,
                                            // title: Text("${seekerProfileController.viewSeekerData.value.seekerInfo?.documentImg}",
                                            //   style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.white, fontWeight: FontWeight.w500),),),
                                            SizedBox(height: Get.height * 0.02,),
                                            // Center(
                                            //   child: MyButton(
                                            //     title: "Boost Your Profile",
                                            //     onTap1: () {
                                            //       showDialog(
                                            //         barrierDismissible: false,
                                            //         context: context,
                                            //         builder: (
                                            //             BuildContext context) {
                                            //           return AlertDialog(
                                            //             content: SingleChildScrollView(
                                            //               child: Column(
                                            //                 children: [
                                            //                   Align(alignment: Alignment.topRight,
                                            //                       child: GestureDetector(
                                            //                           onTap: () { Get.back();},
                                            //                           child: Image.asset("assets/images/closeiconondrawer.png",
                                            //                             height: Get.height * .027,))),
                                            //                   SizedBox( height: Get.height * 0.035 ),
                                            //                   Container(padding: const EdgeInsets.all(17),
                                            //                     decoration: BoxDecoration(
                                            //                         borderRadius: BorderRadius.circular( 60.0),
                                            //                         color: AppColors.blueThemeColor
                                            //                     ),
                                            //                     child: Image.asset('assets/images/boost.png', scale: 3.4,),
                                            //                   ),
                                            //                   SizedBox(height: Get.height * 0.02),
                                            //                   Text("Boost your profile", style: Get.theme.textTheme.labelMedium),
                                            //                   SizedBox(height: Get.height * 0.01),
                                            //                   Text("Lorem Ipsum is simply dummy text",
                                            //                       style: Get.theme.textTheme.bodySmall!.copyWith(
                                            //                           fontWeight: FontWeight.w400, color: AppColors.white)),
                                            //                   SizedBox(height: Get.height * 0.05),
                                            //                   Container( decoration: BoxDecoration(
                                            //                       borderRadius: BorderRadius.circular(10.0),
                                            //                       color: AppColors.blueThemeColor
                                            //                   ),
                                            //                     height: Get.height * 0.21,
                                            //                     width: Get.width * 0.32,
                                            //                     child: Center(
                                            //                       child: Column(
                                            //                         children: [
                                            //                           SizedBox(height: Get.height * 0.035),
                                            //                           Text("1", style: Get.theme.textTheme.displaySmall!.copyWith(
                                            //                               fontSize: 25, color: AppColors.white)),
                                            //                           SizedBox(height: Get.height * 0.014),
                                            //                           Text("month", style: Get.theme.textTheme.titleSmall!.copyWith(
                                            //                               fontSize: 15, color: AppColors.white)),
                                            //                           SizedBox(height: Get.height * 0.01),
                                            //                           Text("\$100", style: Get.theme.textTheme.bodyMedium!.copyWith(
                                            //                               fontSize: 13, color: AppColors.white)),
                                            //                           SizedBox(height: Get.height * 0.01),
                                            //                           Text("Save 36%", style: Get.theme.textTheme.titleSmall!.copyWith(
                                            //                               fontSize: 11, color: AppColors.white)),
                                            //                         ],
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                   SizedBox(height: Get.height * 0.035),
                                            //                   Center(
                                            //                     child: MyButton(width: Get.width * .7,
                                            //                       title: "BOOST ME",
                                            //                       onTap1: () {},),
                                            //                   )
                                            //                 ],
                                            //               ),
                                            //             ),
                                            //             shape: RoundedRectangleBorder(
                                            //                 borderRadius: BorderRadius
                                            //                     .circular(15)
                                            //             ),
                                            //           );
                                            //         },
                                            //       );
                                            //     },),
                                            // ),
                                            // SizedBox(height: Get.height * .02,),
                                          ],
                                        )
                                    ),

                                  ],
                                ),
                              );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
      }
    });
  }


  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  Future<void> _selectDate(
      bool start ,
      BuildContext context,
      String firstDate
      ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: start ? DateTime(1990) : DateTime.parse(firstDate),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (picked != null ) {
      setState(() {
     start ?   _startDateController.text = "${picked.year.toString().padLeft(4,"0")}-${picked.month.toString().padLeft(2,"0")}-${picked.day.toString().padLeft(2,"0")}" :
        _endDateController.text = "${picked.year.toString().padLeft(4,"0")}-${picked.month.toString().padLeft(2,"0")}-${picked.day.toString().padLeft(2,"0")}";
     print(_startDateController.text) ;
      });
    }
  }

  Future<void> _openDeleteDialog( int index, bool isExperience) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          title: Center(
            child: Text('Are you sure you want to delete',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,fontSize: 13),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx( () =>
                   MyButton(
                      width: Get.width*.25,
                      height: Get.height*.05,
                      loading: editSeekerExperienceController.loading.value,
                      title: "Yes",
                      onTap1: () {
                        if(!isExperience){
                      seekerProfileController
                          .viewSeekerData.value.educationLevel?.removeAt(index) ;
                      editSeekerExperienceController.workApi(false, seekerProfileController.viewSeekerData.value.educationLevel, context);
                        }else {
                          seekerProfileController.viewSeekerData.value.workExpJob?.removeAt(index);
                          editSeekerExperienceController.workApi(true, seekerProfileController.viewSeekerData.value.workExpJob, context);
                        }

                    },),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyButton(
                    width: Get.width*.25,
                    height: Get.height*.05,
                    title: "No",
                    onTap1: () { Get.back() ;},)
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openAppreciationDeleteDialog( int index,) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          title: Center(
            child: Text(
              'Are you sure you want to delete',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,fontSize: 13),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx( () =>
                      MyButton(
                        width: Get.width*.25,
                        height: Get.height*.05,
                        loading: editSeekerAppreciationController.loading.value,
                        title: "Yes",
                        onTap1: () {
                            seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation?.removeAt(index);
                            editSeekerAppreciationController.appreciationApi(
                              seekerProfileController.viewSeekerData.value.seekerDetails?.appreciation ,context);
                        },),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyButton(
                    width: Get.width*.25,
                    height: Get.height*.05,
                    title: "No",
                    onTap1: () { Get.back() ;},)
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openFilePicker(bool resume , String? documentType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: resume ?  ['pdf', 'doc' ,'docx'] : ['jpg','jpeg','png','heic','pdf'],
      allowMultiple: false,
    );

    if(result != null) {
      if (resume) {
        if (result.files.single.path!.toLowerCase().endsWith('.pdf') ||
            result.files.single.path!.toLowerCase().endsWith('.doc') ||
            result.files.single.path!.toLowerCase().endsWith('.docx') ) {
          setState(() {
            editSeekerResumeController.resumePath.value = result.files.single.path!;
            resumePath = result.files.single.path!;
          });
          print(resumePath);
        } else {
          if (resumePath.isEmpty) {
            Utils.toastMessage('Please pick a file') ;
          } else {
            Utils.toastMessage('Only pdf file is allowed') ;
          }
        }
      }
      else {
        setState(() {
          debugPrint("this is document==============$documentType==========") ;
          editSeekerResumeController.documentPath.value = result.files.single.path!;
          _documentTypeFilePath = result.files.single.path!;
        });
      }
    }
    else {
      // User canceled the picker
    }
  }

  String videoFilePath = '';

  Future<void> _openVideoPickerDialogUserProfile() {
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
                      _startRecording(i.ImageSource.camera);
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
                      _startRecording(i.ImageSource.gallery);
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

  Future<void> _startRecording(i.ImageSource source) async {
    final video = await i.ImagePicker().pickVideo(
        source: source,
        maxDuration: const Duration(seconds: 15)) ;
    if(video != null) {
      await trimVideo(video.path);
    }
  }

  Future<String?> trimVideo(String path) async {
    CommonFunctions.showLoadingDialog(context, "Uploading...") ;
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
            updateVideoController.updateVideo(context,videoFilePath) ;
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
  //     updateVideoController.updateVideo(context,videoFilePath) ;
  //   }
  // }
}
