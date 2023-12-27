import 'package:flikka/Job%20Seeker/SeekerForum/FriendsFamily/ContactsController.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: Get.height *.02,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: contactController.contacts.length,
              itemBuilder: (context , index) {
            return ListView.builder(
              itemCount: contactController.contacts[index].phones.length,
              itemBuilder: (context, i) {
                var data = contactController.contacts[index].phones[i] ;
                return ListTile(
                  title: Text(data.label),
                  subtitle: Text(data.number),
                );
              }
            ) ;
          })
        ],
      ),
    );
  }


}
