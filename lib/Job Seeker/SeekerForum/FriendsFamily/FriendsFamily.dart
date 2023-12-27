import 'package:flikka/Job%20Seeker/SeekerForum/FriendsFamily/ContactsController.dart';
import 'package:flikka/utils/app_color.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsFamily extends StatefulWidget {
  const FriendsFamily({super.key});

  @override
  State<FriendsFamily> createState() => _FriendsFamilyState();
}

class _FriendsFamilyState extends State<FriendsFamily> {

  ContactController contactController = Get.put(ContactController()) ;
@override
  void initState() {
    contactController.loadContacts() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: Get.height *.05),
        child: Column(
          children: [
            SizedBox(height: Get.height *.02,),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: contactController.contacts.length,
                itemBuilder: (context , index) {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: contactController.contacts[index].phones.length,
                itemBuilder: (context, i) {
                  var data = contactController.contacts[index].phones[i] ;
                  return Column(
                    children: [
                      ListTile(
                        tileColor: AppColors.textFieldFilledColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        title: Text(contactController.contacts[index].displayName , style: const TextStyle(color: AppColor.whiteColor),),
                        subtitle: Text(data.number, style: const TextStyle(color: AppColor.whiteColor),),
                      ),
                      SizedBox(height: Get.height *.01,)
                    ],
                  );
                }
              ) ;
            })
          ],
        ),
      ),
    );
  }


}
