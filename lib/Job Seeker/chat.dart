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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Get.height*.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height*.02,),
            Padding(
              padding: EdgeInsets.only(left: Get.width*.03),
              child: Text("Messages",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.black),),
            ),
            SizedBox(height: Get.height*.02,),
            ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: Get.height*.03),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 28,
                      ),
                      title: SizedBox(
                          width: Get.width*.35,
                          child: Text("Samira", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.black,fontSize: 15,overflow: TextOverflow.ellipsis),)),
                           subtitle: Text("You matched",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.black),),
                           trailing:   Text("30/12/2024",style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.silverColor),),
                    ),
                  );
                },)
        ]
            ),
      ),
    );
  }
}
