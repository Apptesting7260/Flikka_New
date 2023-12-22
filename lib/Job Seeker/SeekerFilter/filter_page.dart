import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/Job%20Seeker/SeekerBottomNavigationBar/tab_bar.dart';
import 'package:flikka/controllers/SeekerJobFilterController/SeekerJobFilterController.dart';
import 'package:flikka/utils/RangeSlider.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import '../../controllers/CompaniesListController/CompaniesListController.dart';
import '../../controllers/SeekerChoosePositionGetController/SeekerChoosePositionGetController.dart';
import '../../controllers/SeekerGetAllSkillsController/SeekerGetAllSkillsController.dart';
import '../../controllers/ViewLanguageController/ViewLanguageController.dart';
import '../../data/response/status.dart';
import '../../models/SearchPlaceModel/SearchPlaceModel.dart';
import '../../res/components/general_expection.dart';
import '../../res/components/internet_exception_widget.dart';
import '../../res/components/request_timeout_widget.dart';
import '../../res/components/server_error_widget.dart';
import '../../res/components/unauthorised_request_widget.dart';
import '../../utils/Constants.dart';

class FilterPage extends StatefulWidget {
  final bool? fromMap ;
  const FilterPage({super.key, this.fromMap});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  final List<String> itemsC = [
    'Social Marketing','Programming','Health Finance','Content Manager'
  ];
  String? positionName;
  dynamic positionId ;

  final List<String> itemsDate = ['past month','past week','past 24 hours','all'];
  String? dateValue;


  final List<String> typeOfWorkplaceItems = [
    'On-site','Remote','Hybrid'
  ];
  String? workplaceType;
  
  final List<String> itemQualification = [
    'Bachelor degree','Master degree','12th pass', 'Diploma', 'Doctoral degree', '10th pass', 'M.phil'
  ];
  String? qualificationType;

  final List<String> employmentTypeItems = [
    'Full-Time','Part-Time','Contract','Temporary', 'Internship', 'Fresher' ,
  ];
  String? employmentType;

  String? skillsValue ;
  dynamic skillsId ;
  String? languageName ;
  dynamic languageId ;

  CompaniesListController companiesListController = Get.put(CompaniesListController()) ;
  SeekerChoosePositionGetController positionController = Get.put(SeekerChoosePositionGetController());
  SeekerGetAllSkillsController skillsController = Get.put(SeekerGetAllSkillsController()) ;
  ViewLanguageController viewLanguageController = Get.put(ViewLanguageController()) ;
  SeekerJobFilterController jobFilterController = Get.put(SeekerJobFilterController()) ;
  TextEditingController companyController = TextEditingController() ;
  TextEditingController locationController = TextEditingController() ;
  TextEditingController jobTitleController = TextEditingController() ;


  List<Location> locations = [];
  double? lat;
  double? long;
  List<Predictions> searchPlace = [];

  dynamic minSalary ;
  dynamic maxSalary ;

  @override
  void initState() {
    // companiesListController.getCompaniesApi() ;
    // skillsController.seekerGetAllSkillsApi() ;
    // viewLanguageController.viewLanguageApi() ;
    // RangePicker.minValue = 5000.0 ;
    // RangePicker.maxValue = 10000.0 ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('called') ;
    return Obx(() {
      switch (companiesListController.rxRequestStatus.value ) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()),
          );

        case Status.ERROR:
          if (companiesListController.error.value == 'No internet') {
            return Scaffold(body: InterNetExceptionWidget(
              onPress: () {
                companiesListController.getCompaniesApi() ;
              },
            ),);
          } else {
            return Scaffold(body: GeneralExceptionWidget(onPress: () {
              companiesListController.getCompaniesApi() ;
            }),);
          }
        case Status.COMPLETED:
          return Obx(() {
            switch (skillsController.rxRequestStatus.value) {
              case Status.LOADING:
                return const Scaffold(
                  body: Center(
                      child: CircularProgressIndicator()),
                );

              case Status.ERROR:
                if (skillsController.error.value == 'No internet') {
                  return Scaffold(body: InterNetExceptionWidget(
                    onPress: () {
                      skillsController.seekerGetAllSkillsApi();
                    },
                  ),);
                } else {
                  return Scaffold(body: GeneralExceptionWidget(onPress: () {
                    skillsController.seekerGetAllSkillsApi();
                  }),);
                }
              case Status.COMPLETED:
                return Obx(() {
                  switch (viewLanguageController.rxRequestStatus.value) {
                    case Status.LOADING:
                      return const Scaffold(
                        body: Center(
                            child: CircularProgressIndicator()),);
                    case Status.ERROR:
                      if (viewLanguageController.error.value == 'No internet') {
                        return Scaffold(body: InterNetExceptionWidget(
                          onPress: () {
                            viewLanguageController.viewLanguageApi();
                          },
                        ),);
                      } else {
                        return Scaffold(body: GeneralExceptionWidget(
                            onPress: () {
                              viewLanguageController.viewLanguageApi();
                            }),);
                      }
                    case Status.COMPLETED:
                      return Scaffold(
                        appBar: AppBar(
                          leading: IconButton(onPressed: () {
                            Get.back();
                          },
                              icon: Image.asset(
                                "assets/images/icon_back_blue.png",)),
                          title: Text("Filter", style: Theme
                              .of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),),
                          toolbarHeight: 70,
                        ),
                        body: SingleChildScrollView(
                          // physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height * 0.03,),
                              //*************** category *************
                              Text('Job Title', style: Get.theme.textTheme
                                  .titleSmall),
                              SizedBox(height: Get.height * 0.01,),
                              TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.text,
                                controller: jobTitleController,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please Enter your address';
                                //   }
                                // },
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
                                    hintText: "Enter job title",
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
                                    hintStyle: Theme
                                        .of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                        color: const Color(0xffCFCFCF)),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: Get.width * .06,
                                        vertical: Get.height * .027)),
                              ),
                              // Container(
                              //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              //   // height: Get.height * .07,
                              //   width: Get.width,
                              //   decoration: BoxDecoration(
                              //       color: AppColors.textFieldFilledColor,
                              //       borderRadius: BorderRadius.circular(30)
                              //   ),
                              //   child: Center(
                              //     child:
                              //     DropdownButtonHideUnderline(
                              //       child: DropdownButton2(
                              //         style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w300),
                              //         isExpanded: true,
                              //         hint: Text(
                              //           'Select position',
                              //           style: Get.theme.textTheme.bodyMedium?.copyWith(
                              //               fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),
                              //           overflow: TextOverflow.ellipsis,
                              //         ),
                              //         items: positionController.seekerChoosePositionGetList.value.data?.map((item) =>
                              //             DropdownMenuItem(
                              //               value: item.positions,
                              //               child: Text(item.positions ?? '',
                              //                 style: Get.theme.textTheme.bodyLarge!
                              //                     .copyWith(color: AppColors.white),
                              //                 overflow: TextOverflow.ellipsis,
                              //               ),
                              //               onTap: () {
                              //                 setState(() {
                              //                   positionName = item.positions ;
                              //                   positionId = item.id ;
                              //                 });
                              //               },
                              //             )).toList(),
                              //         value: positionName,
                              //         onChanged: (String? value) {
                              //             positionName = value;
                              //         },
                              //         dropdownStyleData: DropdownStyleData(
                              //           decoration: BoxDecoration(
                              //             borderRadius: BorderRadius.circular(14),
                              //             color: const Color(0xff353535),
                              //           ),
                              //           offset: const Offset(5, 0),
                              //           scrollbarTheme: ScrollbarThemeData(
                              //             radius: const Radius.circular(40),
                              //             thickness: MaterialStateProperty.all<double>(6),
                              //             thumbVisibility: MaterialStateProperty.all<bool>(
                              //                 true),
                              //           ),
                              //         ),
                              //         menuItemStyleData: const MenuItemStyleData(
                              //           height: 40,
                              //           // padding: EdgeInsets.only(right: 15),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: Get.height * 0.03,),
                              Text('Location',
                                  style: Get.theme.textTheme.titleSmall),
                              SizedBox(height: Get.height * 0.01,),
                              TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.text,
                                controller: locationController,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium,
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
                                    hintStyle: Theme
                                        .of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                        color: const Color(0xffCFCFCF)),
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
                                      itemBuilder: (context, index) =>
                                          ListTile(
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
                                              searchPlace[index].description ??
                                                  "",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          )),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.03,),
                              Text('Company Name', style: Get.theme.textTheme
                                  .titleSmall),
                              SizedBox(height: Get.height * 0.01,),
                              TextFormField(
                                controller: companyController,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                    color: AppColors.white, fontSize: 15),
                                onChanged: (query) {
                                  if (query.isEmpty) {
                                    companiesListController.showCompanies(
                                        false);
                                  } else {
                                    companiesListController.showCompanies(true);
                                  }
                                  companiesListController.filterList(query);
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 18),
                                  filled: true,
                                  fillColor: AppColors.textFieldFilledColor,
                                  hintText: 'Search Company',
                                  hintStyle: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                      color: const Color(0xffCFCFCF)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(33)
                                  ),

                                ),
                              ),
                              Obx(() =>
                              companiesListController.showCompanies.value ?
                              Column(
                                children: [
                                  ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: companiesListController.companies
                                        ?.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var data = companiesListController
                                          .companies?[index];
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              companiesListController
                                                  .showCompanies(
                                                  false);
                                              companyController.text =
                                                  data?.companyName ?? '';
                                            },
                                            child: ListTile(
                                              leading: SizedBox(width: 70,
                                                child: CachedNetworkImage(
                                                  imageUrl: '${data
                                                      ?.profileImg}',
                                                  fit: BoxFit.cover,
                                                  imageBuilder: (context,
                                                      imageProvider) =>
                                                      Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape
                                                                .circle,
                                                            image: DecorationImage(
                                                              image: imageProvider,
                                                              fit: BoxFit
                                                                  .cover,)
                                                        ),
                                                      ),
                                                  placeholder: (context, url) =>
                                                  const Center(
                                                    child: CircularProgressIndicator(),),
                                                ),
                                              ),
                                              title: Text(
                                                  data?.companyName ?? "",
                                                  style: Get.theme.textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                      color: AppColors.white)),
                                              subtitle: Text(
                                                  data?.companyLocation ?? "",
                                                  style: Get.theme.textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                      color: const Color(
                                                          0xffCFCFCF))),
                                            ),
                                          ),
                                          const Divider(
                                            height: 40,
                                            color: Color(0xff414141),
                                            thickness: 1,
                                            indent: 15,
                                            endIndent: 15,
                                          ),
                                        ],
                                      );
                                    },),
                                ],
                              )
                                  : const SizedBox(),
                              ),
                              SizedBox(height: Get.height * 0.03,),
                              Text('Salary Expectation',
                                  style: Get.theme.textTheme
                                      .titleSmall),
                              SizedBox(height: Get.height * 0.01,),
                              SizedBox(height: Get.height * .1,
                                  child:Column(
                                    children: [
                                      Flexible(
                                        child: RangeSlider(
                                          activeColor: AppColors.blueThemeColor,
                                          values: RangeValues(minSalary ?? 0, maxSalary ?? 0),
                                          onChanged: (RangeValues values) {
                                            setState(() {
                                             minSalary = values.start;
                                              maxSalary = values.end;
                                            });
                                          },
                                          min: 0.0,
                                          max: 100000,
                                          divisions: 100,
                                        ),
                                      ),
                                      minSalary == null || maxSalary == null ?
                                      const Text('Selected Range: 0 - 0')
                                     : Text('Selected Range: ${minSalary.toInt()} - ${maxSalary.toInt()}'),
                                    ],
                                  ),),
                              SizedBox(height: Get.height * 0.05,),
                              SizedBox(
                                  height: Get.height * .06,
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      dropDown(hint: "Date Posted",
                                          items: itemsDate,
                                          value: dateValue,
                                          onChanged: (val) {
                                            setState(() {
                                              dateValue = val.toString();
                                            });
                                          }),
                                      dropDown(hint: "Type of Workplace",
                                          items: typeOfWorkplaceItems,
                                          value: workplaceType,
                                          onChanged: (val) {
                                            setState(() {
                                              workplaceType = val.toString();
                                            });
                                          }),
                                      dropDown(hint: "Employment Type",
                                          items: employmentTypeItems,
                                          value: employmentType,
                                          onChanged: (val) {
                                            setState(() {
                                              employmentType = val.toString();
                                            });
                                          }),
                                      dropDown(hint: "Qualification",
                                          items: itemQualification,
                                          value: qualificationType,
                                          onChanged: (val) {
                                            setState(() {
                                              qualificationType =
                                                  val.toString();
                                            });
                                          }),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            right: 10),
                                        decoration: BoxDecoration(
                                            color: AppColors
                                                .textFieldFilledColor,
                                            borderRadius: BorderRadius.circular(
                                                25)
                                        ),
                                        width: Get.width * .35,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                fontWeight: FontWeight.w300),
                                            isExpanded: true,
                                            hint: Text("Skills",
                                              style: Get.theme.textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                  fontWeight: FontWeight.w400),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            items: skillsController
                                                .seekerGetAllSkillsData.value
                                                .softSkill?.map((item) =>
                                                DropdownMenuItem(
                                                  onTap: () {
                                                    setState(() {
                                                      skillsId = item.id;
                                                      skillsValue = item.skills;
                                                    });
                                                  },
                                                  value: item.skills,
                                                  child: Text("${item.skills}",
                                                    style: Get.theme.textTheme
                                                        .bodyLarge!.copyWith(
                                                        color: AppColors.white),
                                                    overflow: TextOverflow
                                                        .ellipsis,),)).toList(),
                                            value: skillsValue,
                                            onChanged: (val) {},
                                            dropdownStyleData: DropdownStyleData(
                                              maxHeight: Get.height * 0.35,
                                              // width: Get.width*0.902,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    14),
                                                color: const Color(0xff353535),
                                              ),
                                              offset: const Offset(5, 0),
                                              scrollbarTheme: ScrollbarThemeData(
                                                radius: const Radius.circular(
                                                    40),
                                                thickness: MaterialStateProperty
                                                    .all<
                                                    double>(
                                                    6),
                                                thumbVisibility: MaterialStateProperty
                                                    .all<
                                                    bool>(true),
                                              ),
                                            ),
                                            menuItemStyleData: const MenuItemStyleData(
                                              height: 40,
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            right: 10),
                                        decoration: BoxDecoration(
                                            color: AppColors
                                                .textFieldFilledColor,
                                            borderRadius: BorderRadius.circular(
                                                25)
                                        ),
                                        width: Get.width * .35,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                fontWeight: FontWeight.w300),
                                            isExpanded: true,
                                            hint: Text("Job language",
                                              style: Get.theme.textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                  fontWeight: FontWeight.w400),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            items: viewLanguageController
                                                .viewLanguageData.value
                                                .languages
                                                ?.map((item) =>
                                                DropdownMenuItem(
                                                  onTap: () {
                                                    setState(() {
                                                      languageId = item.id;
                                                      languageName =
                                                          item.languages;
                                                    });
                                                  },
                                                  value: item.languages,
                                                  child: Text(
                                                    "${item.languages}",
                                                    style: Get.theme.textTheme
                                                        .bodyLarge!.copyWith(
                                                        color: AppColors.white),
                                                    overflow: TextOverflow
                                                        .ellipsis,),)).toList(),
                                            value: languageName,
                                            onChanged: (val) {},
                                            dropdownStyleData: DropdownStyleData(
                                              maxHeight: Get.height * 0.35,
                                              // width: Get.width*0.902,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    14),
                                                color: const Color(0xff353535),
                                              ),
                                              offset: const Offset(5, 0),
                                              scrollbarTheme: ScrollbarThemeData(
                                                radius: const Radius.circular(
                                                    40),
                                                thickness: MaterialStateProperty
                                                    .all<
                                                    double>(
                                                    6),
                                                thumbVisibility: MaterialStateProperty
                                                    .all<
                                                    bool>(true),
                                              ),
                                            ),
                                            menuItemStyleData: const MenuItemStyleData(
                                              height: 40,
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              SizedBox(height: Get.height * 0.04,),
                              SizedBox(
                                height: Get.height * .24,
                                child: ListView.builder(
                                  itemCount: 10,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        height: Get.height * .1,
                                        width: Get.width * .7,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                15),
                                            color: AppColors
                                                .textFieldFilledColor
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              const SizedBox(height: 18),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 45,
                                                    width: 45,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(
                                                            10),
                                                        image: const DecorationImage(
                                                            image: AssetImage(
                                                                "assets/images/icon_marketing.png"))
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12,),
                                                  Text(
                                                    "Marketing Intern",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .titleSmall,)
                                                ],
                                              ),
                                              SizedBox(
                                                height: Get.height * .02,),
                                              RichText(text: TextSpan(
                                                  text: "£145k-£200k",
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .headlineSmall
                                                      ?.copyWith(
                                                      fontWeight: FontWeight
                                                          .w700,
                                                      color: AppColors
                                                          .blueThemeColor),
                                                  children: [
                                                    TextSpan(text: "/yr",
                                                        style: Theme
                                                            .of(context)
                                                            .textTheme
                                                            .headlineSmall
                                                            ?.copyWith(
                                                            fontWeight: FontWeight
                                                                .w700,
                                                            color: AppColors
                                                                .white))
                                                  ]
                                              ),),
                                              // SizedBox(height: Get.height*.02,),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/icon_location_filter.png",
                                                    height: Get.height * .05,),
                                                  SizedBox(
                                                    width: Get.width * .02,),
                                                  Text("California, USA",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                        color: AppColors
                                                            .graySilverColor),)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },),
                              ),
                              SizedBox(height: Get.height * 0.04,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyButton(title: "RESET",
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                          fontWeight: FontWeight.w700),
                                      textColor: AppColors.blueThemeColor,
                                      height: Get.height * .07,
                                      width: Get.width * .35,
                                      bgColor: AppColors.white,
                                      onTap1: () {
                                        jobFilterController.reset(true);
                                        Get.back();
                                      }),
                                  SizedBox(width: Get.width * .025,),
                                  Obx(() =>
                                      MyButton(
                                        loading: jobFilterController.loading.value,
                                        height: Get.height * .07,
                                        width: Get.width * .35,
                                        title: "APPLY",
                                        onTap1: () {
                                          if(!jobFilterController.loading.value) {
                                            jobFilterController.filterJob( widget.fromMap,context, jobTitleController.text,
                                                locationController.text, companyController.text, dateValue, workplaceType,
                                              minSalary, maxSalary, employmentType,
                                                qualificationType, skillsId, languageId);
                                          }
                                        },),
                                  )
                                ],
                              ),
                              SizedBox(height: Get.height * .1,)
                            ],
                          ),
                        ),
                      );
                  }
                }
                );
            }
          }
          );

      }
    }
    );
  }

  dropDown ( {
    required String hint ,
    required List<String> items ,
    dynamic value ,
  Function(Object?)? onChanged
}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: AppColors.textFieldFilledColor,
        borderRadius: BorderRadius.circular(25)
      ),
      width: Get.width * .35,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2 (
          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w300),
          isExpanded: true,
          hint: Text(hint,
            style: Get.theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
            overflow: TextOverflow.ellipsis,
          ),
          items: items.map((item) => DropdownMenuItem(
            value: item,
            child: Text(item,
              style: Get.theme.textTheme.bodyLarge!.copyWith(color: AppColors.white),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              setState(() {
                value = item ;
                print(value) ;
              });
            },
          )).toList(),
          value: value,
          onChanged: onChanged ,
          dropdownStyleData: DropdownStyleData(
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
            padding: EdgeInsets.only(left: 10, right: 5),
          ),
        ),
      ),
    ) ;
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
}
