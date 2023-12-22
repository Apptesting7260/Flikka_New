// import 'package:flikka/Job%20Recruiter/metting_list/metting_list_tabbar.dart';
// import 'package:flikka/widgets/my_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:table_calendar_null_safe/table_calendar_null_safe.dart';
//
// class CalendarScreen extends StatefulWidget {
//   @override
//   _CalendarScreenState createState() => _CalendarScreenState();
// }
//
// class _CalendarScreenState extends State<CalendarScreen> {
//   CalendarController _calendarController = CalendarController();
//   FixedExtentScrollController _hourController = FixedExtentScrollController();
//   FixedExtentScrollController _minuteController = FixedExtentScrollController();
//
//
//   @override
//   void initState() {
//     super.initState();
//     _calendarController = CalendarController();
//     _hourController = FixedExtentScrollController();
//     _minuteController = FixedExtentScrollController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 12,top: 15),
//           child: GestureDetector(
//             onTap: () {
//               Get.back();
//             },
//               child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.055,)),
//         ),
//       title: Padding(
//         padding: const EdgeInsets.only(top: 15.0),
//         child: Text("Schedule Meeting",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
//       ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding:  EdgeInsets.symmetric(horizontal: 18.0),
//           child: Column(
//             children: [
//               SizedBox(height: Get.height*.04,),
//
//               Container(
//                 height: Get.height*.56,
//                 decoration: BoxDecoration(
//                   color: Color(0xff353535),
//                   borderRadius: BorderRadius.circular(24.0),
//                 ),
//                  // padding: EdgeInsets.all(8.0),
//                  // margin: EdgeInsets.all(25.0),
//                 child: Column(
//                   children: [
//                     SizedBox(height: Get.height*.025,),
//                    Padding(
//                      padding: EdgeInsets.symmetric(horizontal: 15),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: [
//                          Text("Pick Date",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),),
//                          Icon(Icons.keyboard_arrow_down,color: Colors.white,size: 30,)
//                        ],
//                      ),
//                    ),
//                     Divider(
//                       height: 35,
//                       color: Color(0xffFFFFFF),
//                       thickness: .1,
//                       indent : 15,
//                       endIndent : 20,
//                     ),
//                     TableCalendar(
//                       initialSelectedDay: DateTime.now(),
//                       calendarController: _calendarController,
//                       builders: CalendarBuilders(
//                         selectedDayBuilder: (context, date, _) {
//                           return Container(
//                             height: 10,
//                             width: 10,
//                            margin: EdgeInsets.all(5),
//                            decoration: BoxDecoration(
//                              gradient: LinearGradient(
//                                  colors: [
//                                    Color(0xff56B8F6 ),
//                                    Color(0xff4D6FED)],
//                                  end: Alignment.topCenter,
//                                  begin: Alignment.bottomCenter),
//                              shape: BoxShape.circle
//                            ),
//                             child: Center(
//                               child: Text(
//                                 date.day.toString(),
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           );
//                         },
//                         todayDayBuilder: (context, date, _) {
//                           return Center(
//                             child: Text(
//                               date.day.toString(),
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           );
//                         },
//                       ),
//                       calendarStyle: CalendarStyle(
//                         outsideDaysVisible: false,
//                         weekendStyle: TextStyle(color: Colors.white),
//                         holidayStyle: TextStyle(color: Colors.white),
//                         weekdayStyle: TextStyle(color: Colors.white),
//                         outsideWeekendStyle: TextStyle(color: Colors.white),
//                         outsideHolidayStyle: TextStyle(color: Colors.white),
//                       ),
//                       daysOfWeekStyle: DaysOfWeekStyle(
//                         weekendStyle: TextStyle(color: Colors.white),
//                         weekdayStyle: TextStyle(color: Colors.white),
//                       ),
//                       headerStyle: HeaderStyle(
//                         formatButtonVisible: false,
//                         titleTextStyle:
//                         TextStyle(color: Colors.white, fontSize: 16),
//                         leftChevronIcon: Icon(
//                           Icons.arrow_left,
//                           color: Colors.white,
//                         ),
//                         rightChevronIcon: Icon(
//                           Icons.arrow_right,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: Get.height*.035,),
//               Container(
//                 decoration: BoxDecoration(
//                     color: Color(0xff353535),
//                     borderRadius: BorderRadius.circular(20)),
//                 // color: Colors.black,
//                 height: Get.height*.29,
//                 // width: MediaQuery.of(context).size.width * .75,
//                 child: Column(
//                   children: [
//                     SizedBox(height: Get.height*.02,),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 15),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Pick Time",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),),
//                           Icon(Icons.keyboard_arrow_down,color: Colors.white,size: 30,)
//                         ],
//                       ),
//                     ),
//                     Divider(
//                       height: 40,
//                       color: Color(0xffFFFFFF),
//                       thickness: .1,
//                       indent : 15,
//                       endIndent : 20,
//                     ),
//                     SizedBox(height: Get.height*.01,),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 30),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             width: 20,
//                           ),
//                           _buildSelectionContainer(),
//                           _buildHourPicker(),
//                           _buildSelectionContainer(),
//                           _buildHourMinText('Hour'),
//                           Spacer(),
//                           _buildSelectionContainer(),
//                           // SizedBox(
//                           //   width: 10,
//                           // ),
//                           // _buildSelectionContainer(),
//                           _buildMinutePicker(),
//                           _buildSelectionContainer(),
//                           _buildHourMinText('Min'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//               ),
//               SizedBox(height: Get.height*.04,),
//               MyButton(title: "SAVE", onTap1: () {
//                     Get.to(()=>MettingListTabbar());
//               },),
//               SizedBox(height: Get.height*.1,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHourMinText(String x) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Text(
//         x,
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//   }
//
//   Widget _buildSelectionContainer() {
//     return Container(
//       width: 5,
//       height: 70,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(40), // Set border radius to 40
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Color(0xFF56B8F6), // Gradient start color
//             Color(0xFF4D6FED), // Gradient end color
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHourPicker() {
//     const int numberOfHours = 12;
//     const int infiniteItemsCount =
//     100000; // Large number to give infinite scroll illusion
//
//     return Container(
//       width: 50,
//       height: 120,
//       color: Color(0xff353535),
//       child: ListWheelScrollView(
//         controller: FixedExtentScrollController(
//             initialItem: infiniteItemsCount ~/ 2), // Start in the middle
//         itemExtent: 50,
//         perspective: 0.01,
//         onSelectedItemChanged: (index) {
//           // Do something with the current hour if needed
//           int currentHour = (index % numberOfHours) + 1;
//           print('Selected Hour: $currentHour');
//         },
//         children: List.generate(infiniteItemsCount, (index) {
//           int hourValue = (index % numberOfHours) + 1; // Loop from 1 to 12
//           return Center(
//             child: Text(
//               '$hourValue',
//               style: TextStyle(color: Colors.white, fontSize: 22),
//             ),
//           );
//         }),
//       ),
//     );
//   }
//
//   Widget _buildMinutePicker() {
//     const int numberOfMinutes = 60;
//     const int infiniteItemsCount =
//     100000; // Large number to give infinite scroll illusion
//
//     return Container(
//       width: 60,
//       height: 120,
//       color: Color(0xff353535),
//       child: ListWheelScrollView(
//         controller: FixedExtentScrollController(
//             initialItem: infiniteItemsCount ~/ 2), // Start in the middle
//         itemExtent: 50,
//         perspective: 0.01,
//         onSelectedItemChanged: (index) {
//           // Do something with the current minute if needed
//           int currentMinute = index % numberOfMinutes;
//           print('Selected Minute: ${currentMinute.toString().padLeft(2, '0')}');
//         },
//         children: List.generate(infiniteItemsCount, (index) {
//           int minuteValue = index % numberOfMinutes; // Loop from 00 to 59
//           return Center(
//             child: Text(
//               minuteValue.toString().padLeft(2, '0'),
//               style: TextStyle(color: Colors.white, fontSize: 22),
//             ),
//           );
//         }),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _calendarController.dispose();
//     _hourController.dispose();
//     _minuteController.dispose();
//     super.dispose();
//   }
// }
