import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(elevation: 0.5,
        backgroundColor: AppColors.white,
        title: Text("Your Chats",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.black),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.heart_broken_outlined, color: Colors.black), // Change the icon as needed
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height,
              child: ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 28,
                      ),
                      title: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Samira",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.black),),
                              Text("30/12/2024",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.silverColor),),
                            ],
                          ) ,
                          Row(
                            children: [],
                          )
                        ],
                      ),
                    );
                  },),
            )
        ],
            ),
      ),
    );
  }
}
