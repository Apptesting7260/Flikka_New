
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/my_button.dart';

class CommonFunctions {

  static showLoadingDialog(BuildContext context , String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator( color: AppColors.blueThemeColor,)) ,
                    SizedBox(width: Get.width*.1,),
                    Text("$message...",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),) ,
                  ],
                )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }

  static confirmationDialog (BuildContext context , { required String message , required  Function() onTap } ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          title: Center(
            child: Text(message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,fontSize: 13),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                      MyButton(
                        width: Get.width*.25,
                        height: Get.height*.05,
                        // loading: loading,
                        title: "Yes",
                        onTap1: onTap ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyButton(
                    width: Get.width*.25,
                    height: Get.height*.05,
                    title: "No",
                    onTap1: () {
                      Get.back();
                      },)
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static downloadFile(String fileUrl, String fileName, String savedDir) async {
    final taskId = await FlutterDownloader.enqueue(
      url: fileUrl,
      savedDir: savedDir,
      fileName: fileName,
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  static changeToHTML (String string) {
    String formattedText = string ;
    List<String> list = formattedText.split('\n');
    List<String> formattedLines = list.map((line) => line.isEmpty ? ''  : '<p>$line</p>').toList();
   return formattedText = formattedLines.join('');
  }

  static parseHTML<String> (String? string) {
    var parsed = parse(string) ;
    return parsed.body?.text ;
  }

 static String parseHtmlAndAddNewline(String htmlString) {
    List<String> paragraphs = htmlString.split('</p>');
    List<String> formattedParagraphs = [];

    for (String paragraph in paragraphs) {
      String formattedParagraph = paragraph.trim();
      if (formattedParagraph.isNotEmpty) {
        formattedParagraphs.add(formattedParagraph);
      }
    }

    return parseHTML(formattedParagraphs.join('\n'));
  }

  static doubleButtonDialog (BuildContext context ,
      { required String message ,
        required  Function() onTap1 ,
        required  Function() onTap2 ,
        required String title1,
        required String title2,
      }
      ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff373737),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          title: Center(
            child: Text(message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,fontSize: 13),
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyButton(
                      width: Get.width*.25,
                      height: Get.height*.05,
                      // loading: loading,
                      title: title1,
                      onTap1: onTap1 ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyButton(
                    width: Get.width*.25,
                    height: Get.height*.05,
                    title: title2,
                    onTap1: onTap2)
                ],
              ),
            ],
          ),
        );
      },
    );
  }

 // static _launchDialer(String phoneNumber) async {
 //    final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);
 //    if (await canLaunch(phoneLaunchUri.toString())) {
 //      await launch(phoneLaunchUri.toString());
 //    } else {
 //      print('Could not launch $phoneLaunchUri');
 //    }
 //  }

 static launchDialer(String phoneNumber) async {
    final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    } else {
      print('Could not launch $phoneLaunchUri');
    }
  }
}
