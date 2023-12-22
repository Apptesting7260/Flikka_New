import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_colors.dart';

class AddAJobDropdownSection extends StatefulWidget {
  final String title;
  final String? subtitle;
  final Image imagePath;
  final Divider? divider;
  final Column? column;
  const AddAJobDropdownSection({super.key, required this.title,   this.subtitle, required this.imagePath,this.divider,this.column, required Null Function() onPressed});

  @override
  State<AddAJobDropdownSection> createState() => _AddAJobDropdownSectionState();
}

class _AddAJobDropdownSectionState extends State<AddAJobDropdownSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff353535),
          borderRadius: BorderRadius.circular(15)
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title,style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.white),),

                  IconButton(constraints:BoxConstraints(),onPressed: (){}, icon: widget.imagePath,)
                ],
              ),
              if (widget.divider != null) widget.divider!,
              if (widget.column != null)widget.column!,
              Text(
                widget.subtitle.toString(),
                style:Get.theme.textTheme.bodyLarge!.copyWith(color: Color(0xffCFCFCF)),textAlign: TextAlign.justify,),
            ],
          ),
        ),
      ),
    );
  }
}
