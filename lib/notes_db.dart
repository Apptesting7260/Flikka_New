// //
// // import 'package:flikka/data/response/status.dart';
// // import 'package:flikka/models/GetJobsListingModel/GetJobsListingModel.dart';
// // import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:get/get.dart';
// // import 'package:get_storage/get_storage.dart';
// //
// // final box3 = GetStorage();
// //
// // class GetJobsListingController extends GetxController {
// //
// //   final _api = SeekerRepository();
// //   final rxRequestStatus = Status.COMPLETED.obs ;
// //   final getJobsListing = GetJobsListingModel().obs ;
// //   RxString error = ''.obs;
// //
// //   void setRxRequestStatus(Status value) => rxRequestStatus.value = value ;
// //   void seekerGetJobs(GetJobsListingModel value) => getJobsListing.value = value ;
// //   void setError(String value) => error.value = value ;
// //   RxList<SeekerJobsData>? filteredList = <SeekerJobsData>[].obs ;
// //
// //   void seekerGetAllJobsApi(){
// //     if (kDebugMode) {
// //       print("called get jobs list step 1") ;
// //     }
// //     if (box3.hasData('seekrprofiledata')) {
// //       // Use cached data if available
// //       final cachedData = box3.read('seekrprofiledata');
// //       seekerGetJobs(GetJobsListingModel.fromJson(cachedData));
// //       print("called get jobs list step local dataR") ;
// //
// //       setRxRequestStatus(Status.COMPLETED);
// //     } else {
// //     setRxRequestStatus(Status.LOADING);
// //     _api.getJobsListingApi().then((value){
// //       box3.write('seekrprofiledata',value);
// //
// //       if (kDebugMode) {
// //         print("called get jobs list step 2") ;
// //       }
// //       setRxRequestStatus(Status.COMPLETED);
// //       seekerGetJobs(value);
// //       if (kDebugMode) {
// //         print("called get jobs list step 3") ;
// //       }
// //
// //       if (kDebugMode) {
// //         print(value) ;
// //       }
// //     }).onError((error, stackTrace){
// //       setError(error.toString());
// //       if (kDebugMode) {
// //         print(error.toString());
// //         print(stackTrace.toString());
// //       }
// //       setRxRequestStatus(Status.ERROR);
// //     });
// //   }}
//
// //   void refreshJobsApi(){
// //     setRxRequestStatus(Status.LOADING);
// //
// //     _api.getJobsListingApi().then((value){
// //       seekerGetJobs(value);
// //       box3.write('seekrprofiledata',value);
// //
// //       if (kDebugMode) {
// //         print("this is length ===== ${getJobsListing.value.jobs?.length}") ;
// //         print(value);
// //       }
// //     }).onError((error, stackTrace){
// //       setError(error.toString());
// //       if (kDebugMode) {
// //         print(error.toString());
// //         print(stackTrace.toString());
// //       }
// //     });
// //   }
// //
// //   filterJobs (String query) {
// //     if(getJobsListing.value.jobs != null) {
// //       filteredList?.value =  getJobsListing.value.jobs!.where((e) {
// //         if(e.recruiterDetails != null && e.jobLocation != null) {
// //           if(e.jobLocation!.toLowerCase().contains(query.toLowerCase()) ||
// //               e.recruiterDetails!.companyName!.toLowerCase().contains(query.toLowerCase())) {
// //             if (kDebugMode) {
// //               print(filteredList?.length) ;
// //             }
// //             return true;
// //           }else{
// //             return false ;
// //           }
// //         }else{
// //           return false ;
// //         }
// //       }
// //       ).toList() ;
// //     }
// //   }
// // }
//
//
//
// import 'dart:convert';
// import 'package:flikka/data/response/status.dart';
// import 'package:flikka/models/GetJobsListingModel/GetJobsListingModel.dart';
// import 'package:flikka/repository/SeekerDetailsRepository/SeekerRepository.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// var map;
// class GetJobsListingController extends GetxController {
//
//   final _api = SeekerRepository();
//   final rxRequestStatus = Status.LOADING.obs ;
//   final getJobsListing = GetJobsListingModel().obs ;
//   RxString error = ''.obs;
//   final box3 = GetStorage();
//
//   void setRxRequestStatus(Status value) => rxRequestStatus.value = value ;
//   void seekerGetJobs(GetJobsListingModel value) => getJobsListing.value = value ;
//   void setError(String value) => error.value = value ;
//   RxList<SeekerJobsData>? filteredList = <SeekerJobsData>[].obs ;
//
//   void seekerGetAllJobsApi() {
//     if (kDebugMode) {
//       print("called get jobs list step 1");
//     }
//
//     // Set loading status
//
//     DatabaseHelper.getDataz().then((cachedData) {
//       // DatabaseHelper.printData();
//       var jobsData;
//       print("called get jobs list step 4"); for (var data in cachedData) {
//         if (data.containsKey('Jobs')) {
//           jobsData = data['Jobs'];
//           print(jobsData);
//           // Process the jobsData as needed
//         }
//       }
//
//       print("data for local------------- $jobsData");
//
//
//       if (jobsData!=null) {
//
//         print(cachedData);
//
//         // Use cached data if available
//         // final Map<String, dynamic>? jsonData =  cachedData;
//         print("doing");
//         // GetJobsListingModel.fromJson(jobsData);
//         print("notdoing");
//         seekerGetJobs(GetJobsListingModel.fromJson(jsonDecode(jobsData)));
//
//         //
//         // seekerGetJobs(map);
//         setRxRequestStatus(Status.COMPLETED);
//         print("called get jobs list local data");
//
//       }
//
//       else {
//         // Handle error or unexpected data format
//         setRxRequestStatus(Status.LOADING);
//         DatabaseHelper.dropTable();
//
//
//         // Fetch data from API
//         _api.getJobsListingApi().then((value) async {
//
//           print("called get jobs list step 5");
//
//           try {
//             // Write fetched data to database
//             seekerGetJobs(value);
//             final getJobsListingModel =value;
//             final dataToInsert = getJobsListingModel.toJson();
//             await DatabaseHelper.insertData(true,dataToInsert);
//             setRxRequestStatus(Status.COMPLETED);
//
//             // DatabaseHelper.insertData({'data': value});
//             DatabaseHelper.printData();
//
//             if (kDebugMode) {
//               print("called get jobs list step 2");
//               print(value);
//             }
//
//
//             // print("local data ${cachedData}") ;
//
//             // Set completed status
//             setRxRequestStatus(Status.COMPLETED);
//
//             // Process fetched data
//
//             if (kDebugMode) {
//               print("called get jobs list step 3");
//             }
//           } catch (error) {
//             // Handle errors during writing to database
//             setError("Error writing data to database: $error");
//
//             if (kDebugMode) {
//               print("Error writing data to database: $error");
//             }
//
//             setRxRequestStatus(Status.ERROR);
//           }
//         }).catchError((error) {
//           // Handle errors during API call
//           setError(error.toString());
//
//           if (kDebugMode) {
//             print(error.toString());
//           }
//
//           setRxRequestStatus(Status.ERROR);
//         });
//       }
//     });
//   }
//
//
// //
// //   void seekerGetAllJobsApi(){
// //     if (kDebugMode) {
// //       print("called get jobs list step 1") ;
// //     }
// //     if (box3.hasData('seekrprofiledata')) {
// //       // Use cached data if available
// //       final cachedData = box3.read('seekrprofiledata');
// //       seekerGetJobs(GetJobsListingModel.fromJson(cachedData));
// //       print("called get jobs list step local dataR") ;
// // print("${getJobsListing.value.jobs?.length}");
// //       setRxRequestStatus(Status.COMPLETED);
// //     } else {
// //       setRxRequestStatus(Status.LOADING);
// //       _api.getJobsListingApi().then((value){
// //         box3.write('seekrprofiledata',value);
// //
// //         if (kDebugMode) {
// //           print("called get jobs list step 2") ;
// //         }
// //         setRxRequestStatus(Status.COMPLETED);
// //         seekerGetJobs(value);
// //         if (kDebugMode) {
// //           print("called get jobs list step 3") ;
// //         }
// //         seekerGetJobs(value);
// //
// //         if (kDebugMode) {
// //           print(value) ;
// //         }
// //       }).onError((error, stackTrace){
// //         setError(error.toString());
// //         if (kDebugMode) {
// //           print(error.toString());
// //           print(stackTrace.toString());
// //         }
// //         setRxRequestStatus(Status.ERROR);
// //       });
// //     }}
//
//
//   void refreshJobsApi(){
//     setRxRequestStatus(Status.LOADING);
//
//     _api.getJobsListingApi().then((value) async {
//       seekerGetJobs(value);
//       DatabaseHelper.dropTable();
//       box3.write('seekrprofiledata',value);
//
//       setRxRequestStatus(Status.COMPLETED);
//       final getJobsListingModel =value;
//       final dataToInsert = getJobsListingModel.toJson();
//       await DatabaseHelper.insertData(true,dataToInsert);
//
//       if (kDebugMode) {
//         print("this is length ===== ${getJobsListing.value.jobs?.length}") ;
//         print(value);
//       }
//     }).onError((error, stackTrace){
//       setError(error.toString());
//       if (kDebugMode) {
//         print(error.toString());
//         print(stackTrace.toString());
//       }
//     });
//   }
//   void filterJobs(String query) {
//     if (getJobsListing.value != null && getJobsListing.value!.jobs != null) {
//       try {
//         filteredList?.value = getJobsListing.value!.jobs!.where((e) {
//           if (e.recruiterDetails != null && e.jobLocation != null) {
//             return e.jobLocation!.toLowerCase().contains(query.toLowerCase()) ||
//                 e.recruiterDetails!.companyName!.toLowerCase().contains(query.toLowerCase());
//           }
//           return false;
//         }).toList();
//
//         if (kDebugMode) {
//           print("Filtered list length: ${filteredList?.length}");
//         }
//       } catch (e) {
//         print("Error filtering jobs: $e");
//       }
//     }
//   }
//
//
// // filterJobs (String query) {
// //   if(getJobsListing.value.jobs != null) {
// //     filteredList?.value =  getJobsListing.value.jobs!.where((e) {
// //       if(e.recruiterDetails != null && e.jobLocation != null) {
// //         if(e.jobLocation!.toLowerCase().contains(query.toLowerCase()) ||
// //             e.recruiterDetails!.companyName!.toLowerCase().contains(query.toLowerCase())) {
// //           if (kDebugMode) {
// //             print(filteredList?.length) ;
// //           }
// //           return true;
// //         }else{
// //           return false ;
// //         }
// //       }else{
// //         return false ;
// //       }
// //     }
// //     ).toList() ;
// //   }
// // }
// }
//
// class DatabaseHelper {
//   static Database? _database;
//   static const String tableName = 'jobs';
//
//   static Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await initDatabase();
//     return _database!;
//   }
//
//   static Future<Database> initDatabase() async {
//     final directory = await getDatabasesPath();
//     final path = join(directory, 'your_database_name.db');
//     return await openDatabase(
//         path, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
//   }
//
//   static Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $tableName (
//         id INTEGER PRIMARY KEY,
//         status INTEGER,
//         Jobs TEXT
//       )
//     ''');
//   }
//
//   static Future<void> _onUpgrade(Database db, int oldVersion,
//       int newVersion) async {
//     // Handle database migration here if needed
//     // For simplicity, we can drop and recreate the table
//     await db.execute('DROP TABLE IF EXISTS $tableName');
//     await _onCreate(db, newVersion);
//   }
//
//   static Future<void> insertData(bool status, Map<String, dynamic> jobs) async {
//     try {
//       final db = await database;
//       await db.rawInsert(
//           'INSERT INTO $tableName (status, Jobs) VALUES (?, ?)',
//           [status ? 1 : 0, jsonEncode(jobs)]);
//       print("data insert in local database");
//     } catch (e) {
//       print("Error inserting data: $e");
//     }
//   }
//
//   static Future<List<Map<String, dynamic>>> getData() async {
//     final db = await database;
//     return await db.query(tableName);
//   }
//
//   static Future<List<Map<String, dynamic>>> getDataz() async {
//     try {
//       final db = await database;
//       List<Map<String, dynamic>> result = await db.query(tableName);
//       print("$result=======result");
//       return result;
//     } catch (e) {
//       print("Error getting data: $e");
//       return [];
//     }
//   }
//
// // Function to print the retrieved data
//   static void printData() async {
//     List<Map<String, dynamic>> data = await getDataz();
//     if (data.isNotEmpty) {
//       print("Retrieved data from local database:");
//       for (var row in data) {
//         bool status = row['status'] == 1 ? true : false;
//         Map<String, dynamic> jobs = jsonDecode(row['Jobs']);
//         var finaljob=jobs;
//         // print("$jobs-----------------------------------------");
//         map= {
//           "Status: $status, Jobs: $jobs"
//
//         };
//         print("------$map------");
//         // print("Status: $status, Jobs: $jobs");
//       }
//     } else {
//       print("No data found in the local database.");
//     }
//   }
//
//   static Future<void> dropTable() async {
//     final db = await database;
//     await db.execute('DROP TABLE IF EXISTS $tableName');
//   }
//
// }
//
// // class DatabaseHelper {
// //   static Database? _database;
// //   static const String tableName = 'jobs';
// //   static Future<Database> get database async {
// //     if (_database != null) {
// //       return _database!;
// //     }
// //     _database = await initDatabase();
// //     return _database!;
// //   }
// //
// //   static Future<Database> initDatabase() async {
// //     final directory = await getApplicationDocumentsDirectory();
// //     final path = join(directory.path, 'your_database_name.db');
// //     return await openDatabase(path, version: 1, onCreate: _onCreate);
// //   }
// //
// //   static Future<void> _onCreate(Database db, int version) async {
// //     await db.execute('''
// //     CREATE TABLE $tableName (
// //       id INTEGER PRIMARY KEY,
// //       status INTEGER,
// //       Jobs TEXT
// //     )
// //   ''');
// //   }
// //
// //
// //
// //   static Future<void> insertData(bool status, Map<String, dynamic> jobs) async {
// //     try {
// //       final db = await database;
// //       await db.rawInsert(
// //           'INSERT INTO $tableName (status, Jobs) VALUES (?, ?)',
// //           [status ? 1 : 0, jsonEncode(jobs)]);
// //     } catch (e) {
// //       print("Error inserting data: $e");
// //     }
// //   }
// //   static Future<Map<String, dynamic>?> getData() async {
// //     try {
// //       final db = await database;
// //       final List<Map<String, dynamic>> result = await db.rawQuery('$tableName');
// //       if (result.isNotEmpty) {
// //         print(" getting data: ${result.first}");
// //         return result.first;
// //       }
// //     } catch (e) {
// //       print("Error getting data: $e");
// //     }
// //     return null;
// //   }
// //
// //
// // // static Future<void> insertData(Map<String, dynamic> data) async {
// //   //   final db = await database;
// //   //   await db.insert('jobs', data);
// //   // }
// //   //
// //   // static Future<Map<String, dynamic>?> getData() async {
// //   //   final db = await database;
// //   //   final List<Map<String, dynamic>> result = await db.query('jobs');
// //   //   if (result.isNotEmpty) {
// //   //     return result.first;
// //   //   }
// //   //   return null;
// //   // }
// // }
