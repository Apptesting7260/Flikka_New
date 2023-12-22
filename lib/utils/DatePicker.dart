import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final String hint ;
  final DateTime? firstDate ;
  final GlobalKey<FormState>? form;
  const DatePickerWidget({super.key, required this.onDateSelected, required this.hint, required this.firstDate, this.form});

  @override
  DatePickerWidgetState createState() => DatePickerWidgetState();
}

class DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? selectedDate ;
  final formKey = GlobalKey<FormState>();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: widget.firstDate ?? DateTime(2000),

      lastDate: DateTime.now(),

      initialDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate && picked != DateTime.now()) {
      setState(() {
        selectedDate = picked;
        widget.onDateSelected(selectedDate!);
        controller.text = "${picked.day}-${picked.month}-${picked.year}" ;
      });
    }
  }
  var controller = TextEditingController() ;

  bool validate (){
    if(formKey.currentState!.validate()) {
      return true ;
    }else {
      return false ;
    }
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        _selectDate(context) ;
      },
      child: Align(
        alignment: Alignment.topLeft,

        child: Form(
          key: widget.form,
          child: TextFormField(
            style: Theme.of(context).textTheme
                .bodyLarge
                ?.copyWith(
                color: Color(0xffCFCFCF),
                fontSize: 12,
                fontWeight: FontWeight.w400),
            controller: controller,
            onTap: () {
              if(widget.firstDate == null) {
                if (widget.form!.currentState!.validate()) {
                  _selectDate(context);
                }
              } else {
                _selectDate(context);
              }
            },
            readOnly: true,
            decoration: InputDecoration(
              constraints: const BoxConstraints(
                //maxWidth: Get.width * 0.41,
              ),
              filled: true,
              fillColor: Color(0xff373737),
              hintText: "Select date",
              contentPadding: EdgeInsets.symmetric(vertical: Get.height*.027,horizontal: Get.width*.06),
              hintStyle:  Theme.of(context).textTheme
                  .bodyLarge
                  ?.copyWith(
                  color: Color(0xffCFCFCF),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                // borderSide: BorderSide(color: Colors.white),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
                borderSide: BorderSide(color: Colors.red),
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
                borderSide: BorderSide(color: Color(0xff373737)),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide: BorderSide.none),
              suffixIcon:  const Icon(
                Icons.calendar_month,
                size: 13,
              ),
            ),
            validator: (value) {
              if(widget.firstDate !=  null){
                if (value == null || value.isEmpty) {
                  return 'This field is empty';
                }
              }else{
                return 'Select start date';
              }

              // return null ;
            },
          ),
        ),
      ),
    );
  }
}
