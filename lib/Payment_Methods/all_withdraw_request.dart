import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

class AllWithdrawRequest extends StatefulWidget {
  const AllWithdrawRequest({super.key});

  @override
  State<AllWithdrawRequest> createState() => _AllWithdrawRequestState();
}

class _AllWithdrawRequestState extends State<AllWithdrawRequest> {
  String? selectedValue;
  var items = [
    'Latest',
    'Latest2',
    'Latest3',
    'Latest4',
    'Latest5',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width*.03),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(height: Get.height*.1,),
                  Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset("assets/images/icon_back_blue.png",height: Get.height*.055,))),
                  SizedBox(width: Get.width*.04,),
                  Text("All Withdrawal Request",style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),),
                ],
              ),
              SizedBox(height: Get.height*.01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   const Text('Withdrawal Request', style: TextStyle(fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
                  SizedBox(width: Get.width * 0.1,),
                  const Text('Sort by', style: TextStyle(fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
                  SizedBox(width: Get.width * 0.02,),
                  Flexible(
                    child: Container(
                      height: Get.height * 0.051,
                      width: Get.width * 0.24,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(60)),
                        border: Border.all(
                            width: 1, color: Colors.white),),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Latest',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: items
                              .map((String item) =>
                              DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (String? value) {
                            setState(() {
                              selectedValue = value;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 50,
                            width: 160,
                            padding: const EdgeInsets.only(
                                left: 8, right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              color: Colors.transparent,
                            ),
                            elevation: 2,
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                            iconSize: 14,
                            iconEnabledColor: Colors.white,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: Get.height * 0.4,
                            width: Get.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Color.fromRGBO(53, 53, 53, 1),
                            ),
                            offset: const Offset(-70, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all<
                                  double>(6),
                              thumbVisibility: MaterialStateProperty.all<
                                  bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),),
                  )
                ],),
              SizedBox(height: Get.height*.02,) ,
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 13,
                itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: Get.height*.13,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Color(0xff353535),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width*.05),
                          child: Column(
                            children: [
                              SizedBox(height: Get.height*.035,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Completed",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),),
                                  Text("£440.00",style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Color(0xff56B8F6))),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("10 Oct 2023",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                                  Text("10:40 AM",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,color: Color(0xffCFCFCF)),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ) ;

              },)
            ],
          ),
        ),
      ),
      ),
    );
  }
}
