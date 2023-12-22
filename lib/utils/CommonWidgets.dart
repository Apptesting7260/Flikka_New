import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommonWidgets {
  static textField(
      BuildContext context,
    TextEditingController controller,
    var hint,
      {required Function(bool) onFieldSubmitted ,
      Function(String)? onChanged}
  ) {
        return Focus(
          onFocusChange: onFieldSubmitted ,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: const BorderSide(color: Color(0xff373737))),
                filled: true,
                fillColor: const Color(0xff373737),
                hintText: "$hint",
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
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: const Color(0xffCFCFCF)),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: Get.width * .06, vertical: Get.height * .027)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is empty';
              }
              return null ;
            },
          ),
        );
  }

  static textFieldHeading (
      BuildContext context ,
      var text
      ) {
   return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(fontWeight: FontWeight.w700),
    ) ;
  }

  static divider () {
 return  const Divider(
      height: 35,
      color: Color(0xffFFFFFF),
      thickness: 0.1,
      indent: 5,
      endIndent: 5,
    ) ;
  }

  static textFieldMaxLines(
      BuildContext context,
      TextEditingController controller,
      var hint,
      {required Function(bool) onFieldSubmitted ,
        int? maxCharacter
      }
      ) {
    return Focus(
      onFocusChange: onFieldSubmitted,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller:controller ,
          // maxLength: maxCharacter ?? 500,
          inputFormatters: [
           // LengthLimitingTextInputFormatter(1000)
          ],
          maxLines: 5,
          style: Theme
              .of(context)
              .textTheme
              .bodyMedium,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xff373737),
            hintText: "$hint",
            hintStyle: Theme
                .of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: const Color(0xffCFCFCF)),
            contentPadding: EdgeInsets.symmetric(
                vertical: Get.height * .03, horizontal: Get.width * .07),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(22),
                borderSide: BorderSide.none),

            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(22),
            //   // borderSide: BorderSide(color: Colors.white),
            // ),
            // errorBorder: const OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(22.0)),
            //   borderSide: BorderSide(color: Colors.red),
            // ),
            // disabledBorder: const OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(22.0)),
            //   borderSide: BorderSide(color: Color(0xff373737)),
            // ),

          ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is empty';
          }
          return null ;
        },
      ),
    );
  }
}
