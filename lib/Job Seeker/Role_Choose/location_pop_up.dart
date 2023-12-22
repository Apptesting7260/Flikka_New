import 'package:flikka/utils/Constants.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'import_cv.dart';

class LocationPopUp extends StatefulWidget {
 final int role ;
  const LocationPopUp({Key? key, required this.role}) : super(key: key);

  @override
  State<LocationPopUp> createState() => _LocationPopUpState();
}

class _LocationPopUpState extends State<LocationPopUp> {
  int  role=0;
  String address = "" ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body:Padding(
            padding:  EdgeInsets.symmetric(horizontal: Get.width*.05),
            child: Center(
              child: Container(
                height: Get.height*.4,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Color(0xff353535),
                    borderRadius: BorderRadius.circular(22)
                ),
                child: Column(
                  children: [
                    SizedBox(height: Get.height*.06,),
                    Image.asset("assets/images/location_icon.png",height: Get.height*.09,color: AppColors.blueThemeColor,),
                    SizedBox(height: Get.height*.01,),
                    Text("Welcome!",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
                    SizedBox(height: Get.height*.01,),
                    Text("Know your location",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                    SizedBox(height: Get.height*.03,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width*.06),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 56,
                            width: Get.width*.37,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(() =>  ImportCv(role: widget.role,));
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff353535),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  side: BorderSide(color: Color(0xff8E8E8E))
                              ), child: Text("BLOCK",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700,color: Color(0xff8E8E8E)),),
                            ),
                          ),
                          SizedBox(
                            height: 56,
                            width: Get.width*.37,
                            child: ElevatedButton(
                              onPressed: () async {
                                var status = await Permission.location.request();
                                LocationPermission permission = await Geolocator.checkPermission();
                                if (permission == LocationPermission.denied) {
                                  permission = await Geolocator.requestPermission();
                                  if (permission == LocationPermission.denied) {
                                    // Permissions are denied, next steps are up to you.
                                    return;
                                  }
                                }

                                if (permission == LocationPermission.whileInUse || permission == LocationPermission.always ) {
                                  // Get the location
                                  await _getLocation();
                                  // Navigate to the next screen
                                  Get.to(() => ImportCv(role: widget.role,));
                                } else {
                                  // Handle the case when location permission is denied
                                  // You can show a message or take other actions here
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff353535),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  side: BorderSide(color: Color(0xff8E8E8E))
                              ), child: Text("ALLOW",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700,color: Color(0xff8E8E8E)),),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle case when location services are not enabled
      return;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle case when location permission is denied
        return;
      }
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition();
    double latitude = position.latitude;
    double longitude = position.longitude;

    // Now you can use the latitude and longitude as needed
    print("Latitude: $latitude, Longitude: $longitude");

    List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude, longitude);

    if (placemarks.isNotEmpty) {
      Placemark addressPlacemark = placemarks.first;
      String locality = addressPlacemark.locality ?? '';
      String administrativeArea = addressPlacemark.administrativeArea ?? '';
      String country = addressPlacemark.country ?? '';

      // Combine the address components into a single string
      Constants.address = "$locality,$administrativeArea,$country";

      // Now you can use the full address as needed
      print("Address: ${placemarks.first}");
      print("Address: ${Constants.address}");
    } else {
      // Handle the case when no address is found
    }
  }
}