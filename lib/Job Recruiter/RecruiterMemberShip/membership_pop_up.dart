import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_colors.dart';
import '../../widgets/my_button.dart';

class MembershipRecruiter extends StatefulWidget {
  const MembershipRecruiter({super.key});

  @override
  State<MembershipRecruiter> createState() => _MembershipRecruiterState();
}

class _MembershipRecruiterState extends State<MembershipRecruiter> {
  bool membercheck = false;
  List<bool> isSelected = [false, false, false];

  int selectedPlanIndex = 0; // Index of the selected plan

  final List<Map<String, dynamic>> plans = [
    {"months": 12, "price": 70, "discount": 0},
    {"months": 6, "price": 100, "discount": 36},
    {"months": 1, "price": 190, "discount": 0},
  ];

  void _showPlanDetails(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isSelected = index == selectedPlanIndex;

        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.black,
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: isSelected
                        ? LinearGradient(
                      colors: [Color(0xFF56B8F6), Color(0xFF4D6FED)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                        : null,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          plans[index]["months"].toString(),
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        SizedBox(height: 14),
                        Text(
                          "Months",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "\$${plans[index]["price"]}/mo",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                        if (plans[index]["discount"] > 0) SizedBox(height: 10),
                        if (plans[index]["discount"] > 0)
                          Text(
                            "Save ${plans[index]["discount"]}%",
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Close"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Center(
          child: Center(
            child:
            MyButton(
              title: 'Boost Your Profile',
              onTap1: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return
                      AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        //*********** you can't definle any value because this is auto value padding adde **********
                        insetPadding: EdgeInsets.symmetric(horizontal: 0),
                        content:
                        SingleChildScrollView(
                          child:
                          Column(
                            children: [
                              Container(

                                child: Column(
                                  children: [
                                    SizedBox(height: Get.height * 0.035),
                                    Container(
                                      padding:EdgeInsets.all(17),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60.0),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF56B8F6),
                                            Color(0xFF4D6FED),
                                          ],
                                          begin: Alignment.topCenter, // Start from the top center
                                          end: Alignment.bottomCenter, // End at the bottom center
                                        ),
                                      ),
                                      child: Image.asset('assets/images/membership.png',scale: 1.7,),
                                    ),
                                    SizedBox(height: Get.height * 0.02),
                                    Text(
                                        "Membership",
                                        style: Get.theme.textTheme.labelMedium
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    Text(
                                        "Send as Message as you want",
                                        style: Get.theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400,color: AppColors.white)
                                    ),
                                    SizedBox(height: Get.height * 0.05),
                                  ],
                                ),
                              ),

                              Row(
                                children: List.generate(plans.length, (index) {
                                  bool isSelected = index == selectedPlanIndex;

                                  return Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedPlanIndex = index;
                                        });

                                        _showPlanDetails(index); // Open the dialog with updated data
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isSelected ? Colors.blue : Colors.black,
                                          borderRadius: BorderRadius.circular(10.0),
                                          gradient: isSelected
                                              ? LinearGradient(
                                            colors: [Color(0xFF56B8F6), Color(0xFF4D6FED)],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          )
                                              : null,
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              SizedBox(height: 20),
                                              Text(
                                                plans[index]["months"].toString(),
                                                style: TextStyle(fontSize: 25, color: Colors.white),
                                              ),
                                              SizedBox(height: 14),
                                              Text(
                                                "Months",
                                                style: TextStyle(fontSize: 15, color: Colors.white),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "\$${plans[index]["price"]}/mo",
                                                style: TextStyle(fontSize: 13, color: Colors.white),
                                              ),
                                              if (plans[index]["discount"] > 0) SizedBox(height: 10),
                                              if (plans[index]["discount"] > 0)
                                                Text(
                                                  "Save ${plans[index]["discount"]}%",
                                                  style: TextStyle(fontSize: 11, color: Colors.white),
                                                ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),

                              SizedBox(
                                  height: Get.height * 0.04),
                              Center(
                                child: MyButton(
                                  title: "CONTINUE",
                                  onTap1: () {
                                    // Get.to(() => LocationPopUp());
                                  },
                                ),
                              ),
                              SizedBox(height: Get.height * 0.02),
                            ],
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                      );
                  },
                );
              },
            ),
          ),
        )
    );
  }
}
