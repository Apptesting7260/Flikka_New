import 'dart:convert';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import '../../controllers/HelpSectionController/HelpSectionController.dart';
import '../../models/SearchPlaceModel/SearchPlaceModel.dart';
import '../../utils/Constants.dart';
import '../../widgets/app_colors.dart';
import 'package:http/http.dart' as http;

class HelpSection extends StatefulWidget {
  const HelpSection({super.key});

  @override
  State<HelpSection> createState() => _HelpSectionState();
}

class _HelpSectionState extends State<HelpSection> {

  HelpSectionControoler helpSectionControolerInstanse = Get.put(HelpSectionControoler()) ;

  var _formKey = GlobalKey<FormState>() ;

  TextEditingController locationController = TextEditingController();
  List<Location> locations = [] ;
  List<Predictions> searchPlace = [];
  void searchAutocomplete(String query) async {
    print("calling");
    Uri uri = Uri.https(
        "maps.googleapis.com",
        "maps/api/place/autocomplete/json",
        {"input": query, "key": Constants.googleAPiKey , "types" : "locality"});
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
  double? lat;
  double? long;

  final List<String> bankItems = [
    'INDIA','UK', 'USA', 'GERMANY',
  ];
  String? bankValues;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 75,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset('assets/images/icon_back_blue.png')),
            ),
            elevation: 0,
            title: Text("Help",style: Get.theme.textTheme.displayLarge),

          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Get.width*.042),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height*.04,) ,
                  Text("Submit a request",style: Theme.of(context).textTheme.displaySmall,),
                  SizedBox(height: Get.height*.01,) ,
                  Text("Email Address",style: Theme.of(context).textTheme.titleSmall,),
                  SizedBox(height: Get.height*.01,) ,
                  TextFormField(
                    controller: helpSectionControolerInstanse.emailController.value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white,fontSize: 15),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.textFieldFilledColor,
                      hintText: 'Enter your email address',
                      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff929292)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: BorderSide.none,
                      ),

                    ),
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Email is required" ;
                      }
                    },
                  ),
                  SizedBox(height: Get.height*.01,) ,
                  Text("Email Address (if applicable, please use the email address connected to your FREE NOW account)",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height*.04,) ,
                  Text("What country does your question/issue apply to?:",style: Theme.of(context).textTheme.titleSmall,),
                  SizedBox(height: Get.height*.01,) ,
                  TextFormField(
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13,color: AppColors.white),
                    // validator: (value) {
                    //   if(value!.isEmpty){
                    //     return "Please enter the location" ;
                    //   }
                    // },
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
                      fillColor: AppColors.textFieldFilledColor,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(33),
                          borderSide: BorderSide.none
                      ),
                      hintText: 'Enter location',
                      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff929292)),
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
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.white),
                            ),
                          )),
                    ),
                  ),
                  // Center(
                  //   child:
                  //   DropdownButtonHideUnderline(
                  //     child: DropdownButton2<String>(
                  //       isExpanded: true,
                  //       hint:  Row(
                  //         children: [
                  //           const SizedBox(
                  //             width: 4,
                  //           ),
                  //           Expanded(
                  //             child: Text(
                  //              '----' ,
                  //               style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                  //               overflow: TextOverflow.ellipsis,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       items: bankItems
                  //           .map((String item) => DropdownMenuItem<String>(
                  //         value: item,
                  //         child: Text(
                  //           item,
                  //           style: Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),
                  //           overflow: TextOverflow.ellipsis,
                  //         ),
                  //       )).toList(),
                  //       value: bankValues,
                  //       // value: SaveBankDetailsControllerInstanse.bankName.value,
                  //       onChanged: (String? value) {
                  //         setState(() {
                  //           bankValues = value ;
                  //
                  //         });
                  //       },
                  //       buttonStyleData: ButtonStyleData(
                  //         height: Get.height*0.078,
                  //         width: double.infinity,
                  //         padding: const EdgeInsets.only(left: 14, right: 14),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(35),
                  //
                  //           color: Color(0xff353535),
                  //         ),
                  //         elevation: 2,
                  //       ),
                  //       iconStyleData:  IconStyleData(
                  //         icon: Image.asset('assets/images/arrowdown.png'),
                  //         iconSize: 14,
                  //         iconEnabledColor: Colors.yellow,
                  //         iconDisabledColor: Colors.grey,
                  //       ),
                  //       dropdownStyleData: DropdownStyleData(
                  //         maxHeight: Get.height*0.35,
                  //         width: Get.width*0.902,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(14),
                  //           color: Color(0xff353535),
                  //         ),
                  //         offset: const Offset(5, 0),
                  //         scrollbarTheme: ScrollbarThemeData(
                  //           radius:  Radius.circular(40),
                  //           thickness: MaterialStateProperty.all<double>(6),
                  //           thumbVisibility: MaterialStateProperty.all<bool>(true),
                  //         ),
                  //       ),
                  //       menuItemStyleData: const MenuItemStyleData(
                  //         height: 40,
                  //         padding: EdgeInsets.only(left: 14, right: 14),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: Get.height*.04,) ,
                  Text("Topic",style: Theme.of(context).textTheme.titleSmall,),
                  SizedBox(height: Get.height*.01,) ,
                  TextFormField(
                    controller: helpSectionControolerInstanse.topicController.value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white,fontSize: 15),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.textFieldFilledColor,
                      hintText: 'topic',
                      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff929292)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: BorderSide.none,
                      ),

                    ),
                  ),
                  SizedBox(height: Get.height*.04,) ,
                  Text("Subject",style: Theme.of(context).textTheme.titleSmall,),
                  SizedBox(height: Get.height*.01,) ,
                  TextFormField(
                    controller: helpSectionControolerInstanse.subjectController.value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white,fontSize: 15),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.textFieldFilledColor,
                      hintText: 'Subject',
                      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff929292)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: BorderSide.none,
                      ),

                    ),
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "Subject is required" ;
                      }
                    },
                  ),
                  SizedBox(height: Get.height*.01,) ,
                  Text("Enter an email address to forward your request to. The forwarding is completely free and based on your consent. You can withdraw your consent at any time.",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height*.04,) ,
                  Text("How can we help?",style: Theme.of(context).textTheme.titleSmall,),
                  SizedBox(height: Get.height*.01,) ,
                  TextFormField(
                    controller: helpSectionControolerInstanse.questionController.value,
                    maxLines: 5,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white,fontSize: 15),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.textFieldFilledColor,
                      hintText: 'Subject',
                      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xff929292)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide.none,
                      ),

                    ),
                    validator: (value) {
                      if(value!.isEmpty) {
                        return "How can help required" ;
                      }
                    },
                  ),
                  SizedBox(height: Get.height*.01,) ,
                  Text("No detail is too small - we want to hear everything!",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),),
                  SizedBox(height: Get.height*.05,) ,
                  Center(
                    child: Obx(() =>
                     MyButton(
                       loading: helpSectionControolerInstanse.loading.value,
                       title: "SUBMIT", onTap1: () {
                         if(_formKey.currentState!.validate()) {
                           helpSectionControolerInstanse.helpSectionApi(
                               context,
                               helpSectionControolerInstanse.emailController.value.text,
                               locationController.text,
                               helpSectionControolerInstanse.topicController.value.text,
                               helpSectionControolerInstanse.subjectController.value.text,
                               helpSectionControolerInstanse.questionController.value.text) ;
                         }
                      },),
                    ),
                  ),
                  SizedBox(height: Get.height*.05,) ,
                ],
              ),
            ),
          ),
        ));
  }
}
