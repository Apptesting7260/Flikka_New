
import 'package:clipboard/clipboard.dart';
import 'package:flikka/Job%20Recruiter/metting_list/metting_list_tabbar.dart';
import 'package:flikka/controllers/ScheduleInterviewController/ScheduleInterviewController.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:table_calendar_null_safe/table_calendar_null_safe.dart';

import '../../utils/CommonWidgets.dart';

class CalendarScreen extends StatefulWidget {
 final String? requestID ;
  const CalendarScreen({super.key, this.requestID});

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {

  var _formKey = GlobalKey<FormState>();

  Color button1Color = AppColors.textFieldFilledColor;
  Color button2Color = AppColors.blueThemeColor;
  CalendarController _calendarController = CalendarController();
  TextEditingController interViewLinkController = TextEditingController();

  FixedExtentScrollController _hourController = FixedExtentScrollController();
  FixedExtentScrollController _minuteController = FixedExtentScrollController();

  String? selectedHour;

  String? selectedMin;

  String? selectedDate;

  ScheduleInterviewController interviewController = Get.put(
      ScheduleInterviewController());

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _hourController = FixedExtentScrollController();
    _minuteController = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12, top: 15),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset("assets/images/icon_back_blue.png",
                height: Get.height * .055,)),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text("Schedule Meeting", style: Theme
              .of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                SizedBox(height: Get.height * .04,),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff353535),
                    borderRadius: BorderRadius.circular(24.0),
                  ),

                  child: Column(
                    children: [
                      SizedBox(height: Get.height * .02,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Pick Date", style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 35,
                        color: Color(0xffFFFFFF),
                        thickness: .1,
                        indent: 15,
                        endIndent: 20,
                      ),
                      TableCalendar(
                        initialSelectedDay: DateTime.now(),
                        startDay: DateTime.now(),
                        calendarController: _calendarController,
                        builders: CalendarBuilders(
                          selectedDayBuilder: (context, date, _) {
                            return Container(
                              height: 10,
                              width: 10,
                              margin: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  color: AppColors.blueThemeColor,
                                  shape: BoxShape.circle
                              ),
                              child: Center(
                                child: Text(
                                  date.day.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                          todayDayBuilder: (context, date, _) {
                            return Center(
                              child: Text(
                                date.day.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                        calendarStyle: const CalendarStyle(
                          outsideDaysVisible: false,
                          weekendStyle: TextStyle(color: Colors.white),
                          holidayStyle: TextStyle(color: Colors.white),
                          weekdayStyle: TextStyle(color: Colors.white),
                          outsideWeekendStyle: TextStyle(color: Colors.white),
                          outsideHolidayStyle: TextStyle(color: Colors.white),
                        ),
                        daysOfWeekStyle: const DaysOfWeekStyle(
                          weekendStyle: TextStyle(color: Colors.white),
                          weekdayStyle: TextStyle(color: Colors.white),
                        ),
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleTextStyle:
                          TextStyle(color: Colors.white, fontSize: 16),
                          leftChevronIcon: Icon(
                            Icons.arrow_left,
                            color: Colors.white,
                          ),
                          rightChevronIcon: Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                          ),
                        ),
                        availableGestures: AvailableGestures.horizontalSwipe,
                        onDaySelected: (day, events, holidays) {
                          setState(() {
                            selectedDate =
                            "${day.year.toString().padLeft(4, "0")}-${day.month
                                .toString().padLeft(2, "0")}-${day.day
                                .toString().padLeft(2, "0")}";
                            debugPrint("this is selected ==== $selectedDate");
                          });
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Get.height * .035,),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff353535),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      SizedBox(height: Get.height * .02,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Pick Time", style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 40,
                        color: Color(0xffFFFFFF),
                        thickness: .1,
                        indent: 15,
                        endIndent: 20,
                      ),
                      SizedBox(height: Get.height * .01,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            _buildSelectionContainer(),
                            _buildHourPicker(),
                            _buildSelectionContainer(),
                            _buildHourMinText('Hour'),
                            const Spacer(),
                            _buildSelectionContainer(),
                            // _buildSelectionContainer(),
                            _buildMinutePicker(),
                            _buildSelectionContainer(),
                            _buildHourMinText('Min'),

                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * .01,),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * .04,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     TextButton(
                //       onPressed: () {
                //         setState(() {
                //           button1Color = AppColors.blueThemeColor;
                //           button2Color = AppColors.textFieldFilledColor;
                //         });
                //       },
                //       style: ButtonStyle(
                //         backgroundColor: MaterialStateProperty.all<Color>(button1Color),
                //         // minimumSize: MaterialStateProperty.all<Size>(Size(150.0, 50.0)),
                //       ),
                //       child: Text(
                //         'AM',
                //         style: Theme.of(context).textTheme.labelMedium,
                //       ),
                //     ),
                //     const SizedBox(width: 15,),
                //     TextButton(
                //       onPressed: () {
                //         setState(() {
                //           button1Color = AppColors.textFieldFilledColor;
                //           button2Color = AppColors.blueThemeColor;
                //         });
                //       },
                //       style: ButtonStyle(
                //         backgroundColor: MaterialStateProperty.all<Color>(button2Color),
                //         // minimumSize: MaterialStateProperty.all<Size>(Size(150.0, 50.0)),
                //       ),
                //       child:  Text(
                //         'PM',
                //         style: Theme.of(context).textTheme.labelMedium,
                //       ),
                //     ),
                //   ],
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidgets.textFieldHeading(context, "Add metting link"),
                    SizedBox(height: Get.height * .01,),
                    TextFormField(
                      controller: interviewController.interViewLinkController
                          .value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                          color: AppColors.white, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: BorderSide.none
                          ),
                          filled: true,
                          fillColor: const Color(0xff373737),
                          hintText: "Add metting link",
                          hintStyle: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.white,
                              fontWeight: FontWeight.w500),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: Get.width * .06,
                              vertical: Get.height * .027)
                      ),
                      onFieldSubmitted: (value) {

                      },
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
                    // TextFormField(style: TextStyle(color: Colors.white),
                    //   controller: interviewController.interViewLinkController.value,
                    //   decoration: const InputDecoration(
                    //     hintText: 'Add meeting link',
                    //   ),
                    //   onFieldSubmitted: (value) {
                    //
                    //   },
                    //   validator: (value) {
                    //     String pattern =
                    //         r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
                    //     RegExp regExp = new RegExp(pattern);
                    //     if (value?.length == 0) {
                    //       return 'Please enter url';
                    //     } else if (!regExp.hasMatch(value!)) {
                    //       return 'Please enter valid url';
                    //     }
                    //     return null;
                    //   },
                    //   onTap: () {
                    //     FlutterClipboard.paste().then((value) {
                    //       setState(() {
                    //         // interviewController.interViewLinkController.value.text = value;
                    //       });
                    //     });
                    //     _pasteFromClipboard() ;
                    //   },
                    // )
                  ],
                ),
                const SizedBox(height: 25,),
                Obx(() =>
                    MyButton(
                      width: Get.width * .7,
                      height: 52,
                      loading: interviewController.loading.value,
                      title: "SAVE",
                      onTap1: () {
                        if (_formKey.currentState!.validate()) {
                          selectedDate = "${_calendarController.selectedDay.year
                              .toString().padLeft(4, '0')}-${_calendarController
                              .selectedDay.month.toString().padLeft(
                              2, '0')}-${_calendarController.selectedDay.day
                              .toString().padLeft(2, '0')}";
                          selectedHour = _hourController.selectedItem.toString()
                              .padLeft(2, '0');
                          selectedMin = _minuteController.selectedItem
                              .toString().padLeft(2, '0');
                          String t = "T";
                          interviewController.scheduleInterview(
                              "$selectedDate$t$selectedHour:$selectedMin",
                              widget.requestID, interViewLinkController.text);
                        }
                      },),
                ),
                SizedBox(height: Get.height * .1,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHourMinText(String x) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        x,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSelectionContainer() {
    return Container(
      width: 5,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), // Set border radius to 40
          color: AppColors.blueThemeColor
      ),
    );
  }

  Widget _buildHourPicker() {
    const int numberOfHours = 24;
    const int infiniteItemsCount = 24; // Large number to give infinite scroll illusion

    return Container(
      width: 50,
      height: 120,
      color: const Color(0xff353535),
      child: ListWheelScrollView(
        controller: _hourController,
        itemExtent: 50,
        perspective: 0.01,
        onSelectedItemChanged: (index) {
          int currentHour = (index % numberOfHours) + 1;
          print('Selected Hour: $currentHour');
          setState(() {
            selectedHour = currentHour.toString();
          });
        },
        children: List.generate(infiniteItemsCount, (index) {
          int hourValue = (index % numberOfHours);
          return Center(
            child: Text(
              '$hourValue'.padLeft(2, '0'),
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMinutePicker() {
    const int numberOfMinutes = 60;
    const int infiniteItemsCount = 60; // Large number to give infinite scroll illusion

    return Container(
      width: 60,
      height: 120,
      color: const Color(0xff353535),
      child: ListWheelScrollView(
        controller: _minuteController,
        // Start in the middle
        itemExtent: 50,
        perspective: 0.01,
        onSelectedItemChanged: (index) {
          int currentMinute = index % numberOfMinutes;
          print('Selected Minute: ${currentMinute.toString().padLeft(2, '0')}');
          selectedMin = currentMinute.toString().padLeft(2, '0');
        },
        children: List.generate(infiniteItemsCount, (index) {
          int minuteValue = index % numberOfMinutes; // Loop from 00 to 59
          return Center(
            child: Text(
              minuteValue.toString().padLeft(2, '0'),
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _calendarController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  // Function to paste from the clipboard
  Future<void> _pasteFromClipboard() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData != null && clipboardData.text != null) {
      setState(() {
        interviewController.interViewLinkController.value.text =
        clipboardData.text!;
      });
    }
  }
}
