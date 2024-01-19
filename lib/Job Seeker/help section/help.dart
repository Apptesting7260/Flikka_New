import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flikka/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/app_colors.dart';

class HelpSection extends StatefulWidget {
  const HelpSection({super.key});

  @override
  State<HelpSection> createState() => _HelpSectionState();
}

class _HelpSectionState extends State<HelpSection> {
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
          body: SingleChildScrollView(
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
                ),
                SizedBox(height: Get.height*.01,) ,
                Text("Email Address (if applicable, please use the email address connected to your FREE NOW account)",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),),
                SizedBox(height: Get.height*.04,) ,
                Text("What country does your question/issue apply to?:",style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: Get.height*.01,) ,
                Center(
                  child:
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint:  Row(
                        children: [
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                             '----' ,
                              style: Get.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: bankItems
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )).toList(),
                      value: bankValues,
                      // value: SaveBankDetailsControllerInstanse.bankName.value,
                      onChanged: (String? value) {
                        setState(() {
                          bankValues = value ;

                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: Get.height*0.078,
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),

                          color: Color(0xff353535),
                        ),
                        elevation: 2,
                      ),
                      iconStyleData:  IconStyleData(
                        icon: Image.asset('assets/images/arrowdown.png'),
                        iconSize: 14,
                        iconEnabledColor: Colors.yellow,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: Get.height*0.35,
                        width: Get.width*0.902,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Color(0xff353535),
                        ),
                        offset: const Offset(5, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius:  Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility: MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height*.04,) ,
                Text("Subject",style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: Get.height*.01,) ,
                TextFormField(
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
                ),
                SizedBox(height: Get.height*.01,) ,
                Text("Enter an email address to forward your request to. The forwarding is completely free and based on your consent. You can withdraw your consent at any time.",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),),
                SizedBox(height: Get.height*.04,) ,
                Text("How can we help?",style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: Get.height*.01,) ,
                TextFormField(
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
                ),
                SizedBox(height: Get.height*.01,) ,
                Text("No detail is too small - we want to hear everything!",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Color(0xffCFCFCF)),),
                SizedBox(height: Get.height*.05,) ,
                Center(
                  child: MyButton(title: "SUBMIT", onTap1: () {

                  },),
                ),
                SizedBox(height: Get.height*.05,) ,
              ],
            ),
          ),
        ));
  }
}
