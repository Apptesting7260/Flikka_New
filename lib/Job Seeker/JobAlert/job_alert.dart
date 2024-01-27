import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../../controllers/SeekerChoosePositionGetController/SeekerChoosePositionGetController.dart';
import '../../controllers/SetJobAlertController/SetJobAlertController.dart';
import '../../models/SearchPlaceModel/SearchPlaceModel.dart';
import '../../utils/Constants.dart';
import '../../utils/utils.dart';

class SetJobAlert extends StatefulWidget {
  const SetJobAlert({super.key});

  @override
  State<SetJobAlert> createState() => _SetJobAlertState();
}

class _SetJobAlertState extends State<SetJobAlert> {

  SeekerChoosePositionGetController seekerChoosePositionGetControllerInstanse = Get.put(SeekerChoosePositionGetController());
  SetJobAlertController alertController = Get.put(SetJobAlertController()) ;

    String positions = "";
    String location = "";
  TextEditingController locationController = TextEditingController();

  var selectedPosition;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark
          ),
                toolbarHeight: 45,
                backgroundColor: AppColors.white,
                leading: GestureDetector(
                  onTap: () {
                    Get.back() ;
                  },
                  child: Image.asset(
                      "assets/images/icon_back_blue.png",
                    ),
                ),
                title: Text("Create job alert",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700,color: AppColors.black),),
              ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height*.05,),
            Text("Job position",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.black),),
            SizedBox(height: Get.height*.01,),
            Container(
              padding: EdgeInsets.symmetric(vertical: Get.height*.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(33),
                color: AppColors.homeGrey,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.black),
                  // padding: EdgeInsets.symmetric(horizontal: Get.width*.04,vertical: Get.height*.005),
                  isExpanded: true,
                  value: selectedPosition,
                  hint: Text(
                    positions.length == 0 ? "Select job Position" : positions,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                        color: AppColors.black,fontWeight: FontWeight.w400,fontSize: 16),
                  ),
                  items: seekerChoosePositionGetControllerInstanse.seekerChoosePositionGetList.value.data?.map((document) {
                    return DropdownMenuItem(
                      value: document.positions,
                      child: Text("${document.positions}", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.black)),
                      onTap: () {
                        setState(() {
                          positions = document.id.toString();
                          print(positions);
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
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: AppColors.homeGrey,
                        borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.arrow_drop_down_outlined,color: Colors.black,size: 25,),
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height*.03,),
            Text("City",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.black),),
            SizedBox(height: Get.height*.01,),
            TextField(
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13,color: AppColors.black),
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
                fillColor: AppColors.homeGrey,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(33),
                    borderSide: BorderSide.none
                ),
                hintText: 'Enter location',
                hintStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                  color: AppColors.black,fontWeight: FontWeight.w400,fontSize: 16),
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.black),
                      ),
                    )),
              ),
            ),
            SizedBox(height: Get.height*.03,),
            Obx(() =>  Center(
              child: MyButton(
                width:Get.width*.77,
                loading: alertController.loading.value,
                title: "SUBMIT",
                onTap1: () {
                  if(positions.isEmpty){
                    Utils.showMessageDialog(context, "Select position to get job alerts") ;
                  } else {
                    if (!alertController.loading.value) {
                      alertController.setJobAlert(
                          context, positions,locationController.text);
                    }
                  }
                },
              ),
            ),) ,
          ],
        ),
      ),
    );
  }
}
