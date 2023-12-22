// import 'dart:async';
//
// import 'package:flikka/widgets/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class GoogleMapIntegration extends StatefulWidget {
//   const GoogleMapIntegration({Key? key}) : super(key: key);
//
//   @override
//   _GoogleMapIntegrationState createState() => _GoogleMapIntegrationState();
// }
//
// class _GoogleMapIntegrationState extends State<GoogleMapIntegration> {
//   Completer<GoogleMapController> _controller = Completer();
//   static final CameraPosition _kGoogle = const CameraPosition(
//     target: LatLng(20.42796133580664, 80.885749655962),
//     zoom: 10.4746,
//   );
//
// // on below line we have created the list of markers
//   final List<Marker> _markers = <Marker>[
//     Marker(
//         markerId: MarkerId('1'),
//         position: LatLng(20.42796133580664, 75.885749655962),
//         infoWindow: InfoWindow(
//           title: 'My Position',
//         )
//     ),
//   ];
//
// // created method for getting user current location
//   Future<Position> getUserCurrentLocation() async {
//     await Geolocator.requestPermission().then((value){
//     }).onError((error, stackTrace) async {
//       await Geolocator.requestPermission();
//       print("ERROR"+error.toString());
//     });
//     return await Geolocator.getCurrentPosition();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         title: const Text("Choose Location"),
//         centerTitle: true,
//       ),
//       body: Container(
//         child: SafeArea(
//           // on below line creating google maps
//           child: GoogleMap(
//             // on below line setting camera position
//             initialCameraPosition: _kGoogle,
//             // on below line we are setting markers on the map
//             markers: Set<Marker>.of(_markers),
//             // on below line specifying map type.
//             mapType: MapType.normal,
//             // on below line setting user location enabled.
//             myLocationEnabled: true,
//             // on below line setting compass enabled.
//             compassEnabled: true,
//             // on below line specifying controller on map complete.
//             onMapCreated: (GoogleMapController controller){
//               _controller.complete(controller);
//             },
//           ),
//         ),
//       ),
//       // on pressing floating action button the camera will take to user current location
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: AppColors.black,
//         onPressed: () async{
//           getUserCurrentLocation().then((value) async {
//             print(value.latitude.toString() +" "+value.longitude.toString());
//
//             // marker added for current users location
//             _markers.add(
//                 Marker(
//                   markerId: MarkerId("2"),
//                   position: LatLng(value.latitude, value.longitude),
//                   infoWindow: InfoWindow(
//                     title: 'My Current Location',
//                   ),
//                 )
//             );
//
//             // specified current users location
//             CameraPosition cameraPosition = new CameraPosition(
//               target: LatLng(value.latitude, value.longitude),
//               zoom: 14,
//             );
//
//             final GoogleMapController controller = await _controller.future;
//             controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//             setState(() {
//             });
//           });
//         },
//         child: Icon(Icons.local_activity,color: AppColors.white,),
//       ),
//     );
//   }
// }
//
//
import 'dart:async';
import 'dart:ui';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/Job%20Seeker/marketing_page.dart';
import 'package:flikka/controllers/SeekerJobFilterController/SeekerJobFilterController.dart';
import 'package:flikka/controllers/SeekerMapJobsController/SeekerMapJobsController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Job Seeker/SeekerFilter/filter_page.dart';
import '../data/response/status.dart';
import '../res/components/general_expection.dart';
import '../res/components/internet_exception_widget.dart';
import '../res/components/request_timeout_widget.dart';

class GoogleMapIntegration extends StatefulWidget {
  final double? lat; final double? long;
  final bool? jobPageView; final bool? filtered ;
  const GoogleMapIntegration({Key? key, this.lat, this.long, this.jobPageView, this.filtered}) : super(key: key);

  @override
  GoogleMapIntegrationState createState() => GoogleMapIntegrationState();
}

class GoogleMapIntegrationState extends State<GoogleMapIntegration> {
  Completer<GoogleMapController> mapController = Completer();
  Completer<GoogleMapController> filterMapController = Completer();

  bool remote = false;

  int _selectedValue = 1;
  Set<Marker> markers = Set();

  var selectedRadius = 10; // Default radius
 static double lat = 20.427;
 static double long = 80.885;

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      if (kDebugMode) {
        print("ERROR$error");
      }
    });
    return await Geolocator.getCurrentPosition();
  }

 bool filtered = false ;

  var radiusList = [10, 20, 30, 40, 50] ;

  final _controller = ValueNotifier<bool>(false);

  SeekerMapJobsController jobsController = Get.put(SeekerMapJobsController());
  SeekerJobFilterController filterController = Get.put(SeekerJobFilterController()) ;

  @override
  void initState() {
    getUserCurrentLocation() ;
    if(widget.filtered == true) {
      if (kDebugMode) {
        print("inside filter") ;
      }
    }
    if (widget.jobPageView != true && widget.filtered != true) {
      // jobsController.mapJobsApi();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.jobPageView == true
        ? SafeArea(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.lat ?? lat, widget.long ?? long),
                zoom: 5,
              ),
              markers: <Marker>{
                Marker(
                  markerId: const MarkerId("1"),
                  position: LatLng(widget.lat ?? lat, widget.long ?? long),
                  infoWindow: const InfoWindow(
                    title: "Job Location",
                  ),
                ),
              },
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                mapController.complete(controller);
                if (kDebugMode) {
                  print("inside 1") ;
                }
              },
            ),
          )
        : filtered ? SafeArea(
          child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
          children: [
            Stack(
             children: [
               GoogleMap(
                 initialCameraPosition:  CameraPosition(
                   target: LatLng(double.parse(jobsController.lat.value) ,double.parse(jobsController.long.value)), // Center of the UK
                   zoom: 4.0,
                 ),
                 markers: Set<Marker>.of(markers),
                 onMapCreated: (GoogleMapController controller) {
                   filterMapController.complete(controller);
                   controller.setMapStyle(getCustomMapStyle()) ;
                   markers.add( Marker(
                     markerId: const MarkerId("My location"),
                     position: LatLng(double.parse(jobsController.lat.value), double.parse(jobsController.long.value)),
                     infoWindow: const InfoWindow(
                       title: 'My Current Location',
                     ),
                   ),) ;
                   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                     target: LatLng(double.parse(jobsController.lat.value),double.parse(jobsController.long.value)), // Center of the UK
                     zoom: 4.0,
                   ),));
                   if (kDebugMode) {
                     print("inside GoogleMapController filter") ;
                   }
                   lat = double.parse(jobsController.lat.value) ;
                   long = double.parse(jobsController.long.value) ;
                   updateMap(selectedRadius) ;
                   setState(() {});
                 },
               ),
               Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                     child: GestureDetector(
                         onTap: () {
                           Get.to(() => const FilterPage(fromMap: true,))?.then((result) {
                             if (result != null) {
                               setState(() {
                                 filtered = true ;
                                 if (kDebugMode) {
                                   print("result filtered again") ;
                                   updateMap(selectedRadius) ;
                                 }
                               });
                             }
                           });
                         },
                         child: Image.asset(
                           "assets/images/icon_filter_seeker_home.png",
                           height: Get.height * .043,
                         )),
                   ),
                 ],
               ),
               Positioned(
                 right: 5,
                 top: 5,
                 child: Container(
                   padding: const EdgeInsets.symmetric(horizontal: 8,),
                   decoration: BoxDecoration(
                       color: Colors.grey.withOpacity(.6),
                       borderRadius: BorderRadius.circular(20)
                   ),
                   child: DropdownButtonHideUnderline(
                     child: DropdownButton(
                       // style: Theme.of(context).textTheme.displayLarge,
                       icon: const Icon(Icons.arrow_drop_down,color: Colors.black,),
                       dropdownColor: AppColors.black,
                       hint:  const Text("Select",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,)),
                       value: selectedRadius,
                       items: radiusList.map<DropdownMenuItem>((value) {
                         return DropdownMenuItem(
                           value: value,
                           child: Text('$value miles',
                             style: Theme.of(context).textTheme.bodySmall
                                 ?.copyWith(color: AppColors.white),
                           ),
                         );}).toList(),
                       onChanged: (newValue) {
                         setState(() {
                           selectedRadius = newValue;
                           updateMap(newValue);
                         });
                       },
                     ),
                   ),
                 ),
               ),
             ],
            ),
          ],
          
                ),
                floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.black,
          onPressed: () async {
            updateUserLocation();
          },
          child: const Icon(Icons.local_activity,
              color: AppColors.white),
                ),),
        )
   : Obx(() {
            switch (jobsController.rxRequestStatus.value) {
              case Status.LOADING:
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
                
              case Status.ERROR:
                if (jobsController.error.value == 'No internet') {
                  return Scaffold(
                    body: InterNetExceptionWidget(
                      onPress: () {
                        jobsController.mapJobsApi();
                      },
                    ),
                  );
                } else if (jobsController.error.value == 'Request Time out') {
                  return Scaffold(
                    body: RequestTimeoutWidget(onPress: () {
                      jobsController.mapJobsApi();
                    }),
                  );
                } else {
                  return Scaffold(
                    body: GeneralExceptionWidget(onPress: () {
                      jobsController.mapJobsApi();
                    }),
                  );
                }
              case Status.COMPLETED:
                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Stack(
                        children: [
                          GoogleMap(
                            minMaxZoomPreference: const MinMaxZoomPreference(6, 15),
                            initialCameraPosition:  CameraPosition(
                              target: LatLng(double.parse(jobsController.lat.value) ,double.parse(jobsController.long.value)), // Center of the UK
                              zoom: 7.0,
                            ),
                            markers: Set<Marker>.of(markers),
                            onMapCreated: (GoogleMapController controller) {
                              mapController.complete(controller);
                              controller.setMapStyle(getCustomMapStyle()) ;
                              markers.add( Marker(
                                markerId: const MarkerId("My location"),
                                position: LatLng(double.parse(jobsController.lat.value), double.parse(jobsController.long.value)),
                                infoWindow: const InfoWindow(
                                  title: 'My Current Location',
                                ),
                              ),) ;
                              controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                target: LatLng(double.parse(jobsController.lat.value),double.parse(jobsController.long.value)), // Center of the UK
                                zoom: 7.0,
                              ),));
                              updateMap(selectedRadius) ;
                              lat = double.parse(jobsController.lat.value) ;
                              long = double.parse(jobsController.long.value) ;
                              if (kDebugMode) {
                                print("inside jobs") ;
                              }
                              setState(() {});
                            },
                            // zoomControlsEnabled: ,
                          ),
                          Positioned(
                            top: 20,
                            left: 15,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 10),
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.withOpacity(.6),
                              ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Get.to(() => const FilterPage(fromMap: true,))?.then((result) {
                                          if (result != null) {
                                            setState(() {
                                              filtered = true ;
                                              if (kDebugMode) {
                                                print("result filtered") ;
                                              }
                                            });
                                          }
                                        });
                                      },
                                      child: Image.asset(
                                        "assets/images/icon_filter_seeker_home.png",
                                        height: Get.height * .043,
                                      )),
                               const SizedBox(height: 10,),
                               GestureDetector(
                                 onTap: () {
                                   setState(() {
                                     remote = !remote ;
                                       updateMap(selectedRadius) ;
                                   });
                                 },
                                 child: Container(
                                   height: 35,
                                   width: 35,
                                   decoration:  BoxDecoration(
                                     shape: BoxShape.circle,
                                     color: remote ?  AppColors.blueThemeColor : AppColors.white
                                   ),
                                 ),
                               ),
                                   Text("remote",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 10,color: AppColors.white),),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5,
                            top: 5,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8,),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.6),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                                  dropdownColor: AppColors.black,
                                  hint:  const Text("Select",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,)),
                                  value: selectedRadius,
                                  items: radiusList.map<DropdownMenuItem>((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        '$value miles',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: AppColors.white),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedRadius = newValue;
                                      updateMap(newValue);
                                      // Call the method to filter markers based on the selected radius
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      floatingActionButton: FloatingActionButton(
                        backgroundColor: AppColors.black,
                        onPressed: () async {
                          updateUserLocation();
                        },
                        child: const Icon(Icons.local_activity,
                            color: AppColors.white),
                      ),
                    );
            }
          });
  }


  void updateMap(int radius) async {
 await getUserCurrentLocation() ;
    markers.clear();
    if (kDebugMode) {
      print("called") ;
    }
    markers.add( Marker(
      markerId: const MarkerId("My location"),
      position: LatLng(double.parse(jobsController.lat.value), double.parse(jobsController.long.value)),
      infoWindow: const InfoWindow(
        title: 'My Current Location',
      ),
    ),) ;

    Position currentPosition = await Geolocator.getCurrentPosition();
    if(filtered) {
      if (kDebugMode) {
        print("called update map") ;
      }
      if (filterController.jobsData.value.jobs != null &&
          filterController.jobsData.value.jobs?.length != 0) {
        for (int i = 0; i < filterController.jobsData.value.jobs!.length; i++) {
          var data = filterController.jobsData.value.jobs?[i];
          // Calculate distance in meters using the Haversine formula
          // double distanceInMeters = Geolocator.distanceBetween(
          //   currentPosition.latitude,
          //   currentPosition.longitude,
          //   data?.lat,
          //   data?.long,
          // );
          //
          // // Convert distance to miles
          // double distanceInMiles = distanceInMeters / 1609.344;
          //
          // print("Distance from current location to center: $distanceInMiles miles");

          // Filter markers within the specified radius
          double markerDistance = Geolocator.distanceBetween(
            // currentPosition.latitude,
            lat,
            long,
            // currentPosition.longitude,
            data?.lat,
            data?.long,
          ); //
          markerDistance = markerDistance / 1609.344;
          if (kDebugMode) {
            print("this is distance $markerDistance");
          }
          if (markerDistance <= radius) {
            markers.add( Marker(
                markerId: MarkerId("${data?.id}"),
                position: LatLng(double.parse("${data?.lat}"),
                    double.parse("${data?.long}")),
                infoWindow:
                InfoWindow(title: "${data?.recruiterDetails?.companyName}"),
                icon: await getMarkerIcon("assets/images/icon_map.png", 5),
                onTap: () async {
                  debugPrint("tapped");
                  Get.to(() =>
                      MarketingIntern(jobData: data, appliedJobScreen: false));
                }));
          }
          // Trigger a rebuild to update the markers on the map
        }
      }
    } else {
      if (kDebugMode) {
        print("inside jobs controller update map") ;
        print("=================${jobsController.jobsData.value.jobs?.length}") ;
      }
      if (jobsController.jobsData.value.jobs != null &&
          jobsController.jobsData.value.jobs?.length != 0) {
        for (int i = 0; i < jobsController.jobsData.value.jobs!.length; i++) {
          var data = jobsController.jobsData.value.jobs?[i];
          if (kDebugMode) {
            print("inside loop controller update map");
          }
          // Calculate distance in meters using the Haversine formula
          // double distanceInMeters = Geolocator.distanceBetween(
          //   currentPosition.latitude,
          //   currentPosition.longitude,
          //   data?.lat,
          //   data?.long,
          // );

          // Convert distance to miles
          // double distanceInMiles = distanceInMeters / 1609.344;

          // print("Distance from current location to center: $distanceInMiles miles");

          // Filter markers within the specified radius
          double markerDistance = Geolocator.distanceBetween(
            // currentPosition.latitude,
            lat,
            long,
            // currentPosition.longitude,
            data?.lat,
            data?.long,
          );
          if (kDebugMode) {
            print("this is distance in metre $markerDistance");
          }
          markerDistance = markerDistance / 1609.344;

          if (kDebugMode) {
            print("this is distance in miles $markerDistance");
          }
          if (remote) {
            if (markerDistance <= radius && data?.typeOfWorkplace?.toLowerCase() == "remote") {
              if (kDebugMode) {
                print("object");
              }
              markers.add(Marker(
                  markerId: MarkerId("${data?.id}"),
                  position: LatLng(
                      double.parse("${data?.lat}"),
                      double.parse("${data?.long}")),
                  infoWindow:
                  InfoWindow(title: "${data?.recruiterDetails?.companyName}"),
                  icon: await getMarkerIcon("assets/images/icon_map.png", 5),
                  onTap: () async {
                    debugPrint("tapped");
                    Get.to(() =>
                        MarketingIntern(
                            jobData: data, appliedJobScreen: false));
                  }));
            }
            // Trigger a rebuild to update the markers on the map
          } else {
            if (markerDistance <= radius) {
              if (kDebugMode) {
                print("object");
              }
              markers.add(Marker(
                  markerId: MarkerId("${data?.id}"),
                  position: LatLng(
                      double.parse("${data?.lat}"),
                      double.parse("${data?.long}")),
                  infoWindow:
                  InfoWindow(title: "${data?.recruiterDetails?.companyName}"),
                  icon: await getMarkerIcon("assets/images/icon_map.png", 5),
                  onTap: () async {
                    debugPrint("tapped");
                    Get.to(() =>
                        MarketingIntern(
                            jobData: data, appliedJobScreen: false));
                  }));
            }
          }
        }
      }
    }
    setState(() {});
  }

  Future<BitmapDescriptor> getMarkerIcon(String assetName, double size) async {
    final ByteData data = await rootBundle.load(assetName);
    final Uint8List bytes = data.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(bytes, size: const Size(20, 20));
  }

  updateUserLocation() async {
    getUserCurrentLocation().then((value) async {
      if (kDebugMode) {
        print("${value.latitude} ${value.longitude}");
      }
      lat = value.latitude;
      long = value.longitude;
      // if(jobsController.jobsData.value.lat != null && jobsController.jobsData.value.long != null ) {
      //   print(jobsController.jobsData.value.lat) ;
      //   print(jobsController.jobsData.value.long) ;
      //   lat = jobsController.jobsData.value.lat ;
      //   long = jobsController.jobsData.value.long ;
      // }
      // Marker added for the current user's location
      markers.add(
        Marker(
          markerId: const MarkerId("My location"),
          position: LatLng(lat, long),
          infoWindow: const InfoWindow(
            title: 'My Current Location',
          ),
        ),
      );

      // Specified current user's location
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(lat, long),
        zoom: 4,
      );
      if(filtered) {
        final GoogleMapController controller = await filterMapController.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      }else{
        final GoogleMapController controller = await mapController.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      }
      setState(() {});
    });
  }

  String getCustomMapStyle() {
    return '''
    [
      {
        "featureType": "administrative.land_parcel",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi.business",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.icon",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "road.arterial",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
    
        ]
      },
    
        ]
      },
      {
        "featureType": "road.local",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "transit",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      }
    ]
  ''';
  }
}
