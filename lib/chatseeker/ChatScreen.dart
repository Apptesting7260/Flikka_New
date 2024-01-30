import 'dart:async';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flikka/Job%20Recruiter/message/message_page.dart';
import 'package:flikka/chatseeker/CreateChat.dart';
import 'package:flikka/chatseeker/chat_functios.dart';
import 'package:flikka/controllers/ViewSeekerProfileController/ViewSeekerProfileController.dart';
import 'package:flikka/main.dart';
import 'package:flikka/widgets/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:kplayer/kplayer.dart';
import 'package:path_provider/path_provider.dart';

import 'package:video_player/video_player.dart';
String messagetype="text";
 var playerx;
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
    ViewSeekerProfileController seekerProfileController = Get.put( ViewSeekerProfileController());
    String ?messageimgurl;
  String ?textmsg;
     bool ispageloading=false;
  String url="";
  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";
  String audioasset = "assets/audio/red-indian-music.mp3";
  bool isplaying = false;
  bool audioplayed = false;
  late Uint8List audiobytes;
// Recording ?recording;
  // AudioPlayer player = AudioPlayer();
  Map<String, dynamic>? messages;
  TextEditingController messagecontroller = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 


  String formatTimestamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    final DateFormat formatter = DateFormat('h:mm a');
    return formatter.format(dateTime);
  }
final MsgFunction chatfunctionsinstance=MsgFunction();
  FocusNode messageFocusNode = FocusNode();
 


  @override
  void initState() {
      _getDir();
    _initialiseControllers();

   MessengeRead();
    super.initState();
  }
  final ScrollController _scrollController = ScrollController();

  void onSendMessage() async {
    //  String anotherseekerid=seekerMyProfileController.SeekerMyProfileDetail.
    //       value.ProfileDetail!.id
    //           .toString()==ViewRequestDetailsControllerinstance.ViewProfileDetail.value.data!.getseeker!.id.toString()?
    //           ViewRequestDetailsControllerinstance.ViewProfileDetail.value.data!.getanotherseeker!.id.toString():ViewRequestDetailsControllerinstance.ViewProfileDetail.value.data!.getseeker!.id.toString();
    switch (messagetype) {
      case "text":
      textmsg= messagecontroller.text.toString();
      setState(() {
        textmsg;
      });
      messagecontroller.clear();
        Map<String, dynamic> messages = {
          "sentby":seekerProfileController.viewSeekerData.value.seekerInfo!.id
              .toString(),
               "sendertype":"seeker" ,
                 "profileimage":seekerProfileController.viewSeekerData.value.seekerInfo!.profileImg.toString(),
  'isRead':false,
          "message": textmsg,
          "type": "text",
          "time": FieldValue.serverTimestamp(),
        };
 
print(fcmToken);

          // setState(() {
          //   anotherseekerid;
          // });
        
 chatfunctionsinstance.SendMsgToRecruiter(textmsg.toString(),seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),"GRP"+RecruiterId.toString()+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),messages);
//  selfsender(textmsg.toString(), seekerMyProfileController.SeekerMyProfileDetail.
//           value.ProfileDetail!.id
//               .toString(), roomid.toString(), messages);
//                chatfunctionsinstance.anotherseekersender(textmsg.toString(), anotherseekerid, roomid.toString(), messages);

// chatfunctionsinstance.Makersender(textmsg.toString(),ViewRequestDetailsControllerinstance.ViewProfileDetail.value.data!.getmaker!.id.toString(), roomid.toString(), messages);

             
        chatfunctionsinstance.sendNotification(textmsg.toString(),seekerProfileController.viewSeekerData.value.seekerInfo!.fullname.toString());
            
        print("----dfsdfsdfsdfsdfsdfsdffdsg,");

  

   
   
          messagecontroller.clear();
          print("cleared");

     
        break;
      case "img":
       Map<String, dynamic>   messages = {
          "sentby": seekerProfileController.viewSeekerData.value.seekerInfo!.id
              .toString(),
               "sendertype":"seeker" ,
   "profileimage":seekerProfileController.viewSeekerData.value.seekerInfo!.profileImg.toString(),
          "message": "",
          "imageurl": messageimgurl,
          "type": "img",
          "time": FieldValue.serverTimestamp(),
        };
        String latmdg="image";

 chatfunctionsinstance.SendMsgToRecruiter(textmsg.toString(),seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),"GRP"+RecruiterId.toString()+seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString(),messages);


       setState(() {
        messagetype="text";
        print(messagetype);
      });
        
      // Add your logic for handling image messages here
      break;
    case "audio":
  //  Map<String, dynamic>    messages = {
  //       "sentby": seekerMyProfileController.SeekerMyProfileDetail.
  //         value.ProfileDetail!.id.toString(),
  //       "message": messagecontroller.text,
  //       "audiourl":messagaudiourl,
  //              "sendertype":"seeker" ,
  //          "profileimage":seekerMyProfileController.SeekerMyProfileDetail.
  //         value.ProfileDetail!.imgPath,
  //       "type": "audio",
  //       "time": FieldValue.serverTimestamp(),
  //     };
// 

// chatfunctionsinstance.selfsender(textmsg.toString(), seekerMyProfileController.SeekerMyProfileDetail.
//           value.ProfileDetail!.id
//               .toString(), roomid.toString(), messages);
//                chatfunctionsinstance.anotherseekersender(textmsg.toString(), anotherseekerid, roomid.toString(), messages);

// chatfunctionsinstance.Makersender(textmsg.toString(),ViewRequestDetailsControllerinstance.ViewProfileDetail.value.data!.getmaker!.id.toString(), roomid.toString(), messages);
//       print("Enter Some Text");
//        setState(() {
//         messagetype="text";
//         print(messagetype);
//       });
      break;
    case "video":
      print("Video");
      // Add your logic for handling video messages here
      break;
    default:
      print("Unknown message type");
      // Handle the case where the message type is unknown
    }
  }

  String customPath = '/flutter_audio_recorder_';
  Future<String> uploadSelectedImageAndGetUrl(ImageSource source) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    try {
      // Check if the picked file is an image
      if (pickedFile.path != null && await File(pickedFile.path!).exists()) {
        // Determine the file extension based on MIME type
        final String fileExtension =
            pickedFile.mimeType?.split('/').last ?? 'jpg';

        // Create a reference to the Firebase Storage location where you want to store the image.
        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now()}.$fileExtension');

        // Upload the selected image to Firebase Storage
        final UploadTask uploadTask =
            storageReference.putFile(File(pickedFile.path!));

        // Await the completion of the upload
        final TaskSnapshot storageTaskSnapshot =
            await uploadTask.whenComplete(() => null);

        // Retrieve the download URL for the uploaded image
        final String downloadUrl =
            await storageTaskSnapshot.ref.getDownloadURL();
        print(downloadUrl);

        setState(() {
          messageimgurl = downloadUrl;
          messagetype = "img";
        });
        onSendMessage();
        print(downloadUrl);
        return downloadUrl;
      } else {
        print('Selected file is not an image.');
        return "null";
      }
    } catch (error) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $error');
      return "null";
    }
  } else {
    // User canceled the image selection
    return "null";
  }
}

Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose",style: Theme.of(context).textTheme.titleLarge,),
            //Image Picker
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child:Icon(Icons.camera_alt,color: Colors.pink,),
                  onTap: () {
                    uploadSelectedImageAndGetUrl(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                GestureDetector(
                  child: Icon(Icons.photo_library,color: Colors.pink,),
                  onTap: () {
                    Navigator.of(context).pop();
                    uploadSelectedImageAndGetUrl(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

// Future<void> _uploadAudioToFirebase(File audioFile) async {
//   if (audioFile.existsSync()) {
//     try {
//       final storage = FirebaseStorage.instance;
//       final fileName = audioFile.path.split('/').last; // Get the original file name
//       final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_$fileName'; // Add a timestamp to make the file name unique
//       final Reference reference = storage.ref().child('audio_recordings/$uniqueFileName');

//       final UploadTask uploadTask = reference.putFile(audioFile);

//       // Await the completion of the upload task
//       final TaskSnapshot storageTaskSnapshot = await uploadTask;

//       // Get the download URL
//       final String downloadURL = await storageTaskSnapshot.ref.getDownloadURL();
      
//       // Now you can use downloadURL to store in Firestore as you were doing

//       setState(() {
//         messagetype = "audio";
//         messagaudiourl = downloadURL;
//       });
//       onSendMessage();
//       print('File uploaded successfully. Download URL: $downloadURL');
//     } catch (error) {
//       print('Error uploading file: $error');
//     }
//   } else {
//     print('File does not exist: ${audioFile.path}');
//   }
// }




//   @override
//   void dispose() {
//     // _audioRecorder.dispose();
//     super.dispose();
//   }


  late final RecorderController recorderController;

  String? path;
  String? musicFile;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  late Directory appDirectory;



  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}/recording.m4a";
    isLoading = false;
    setState(() {});
  }

  void _initialiseControllers() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      musicFile = result.files.single.path;
      setState(() {});
    } else {
      debugPrint("File not picked");
    }
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }
Future<String?> uploadVideoToFirebaseStorage(String filePath) async {
  try {
    Reference storageReference = FirebaseStorage.instance.ref().child('videos/${DateTime.now()}.mp4');
    final UploadTask uploadTask = storageReference.putFile(File(filePath));

    final TaskSnapshot downloadUrl = (await uploadTask.whenComplete(() {}));

    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  } catch (e) {
    print('Error uploading video: $e');
    return null;
  }
}

Future<void> pickVideoAndUploadToFirebase(BuildContext context) async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      // type: FileType.custom,
      // allowedExtensions: ['mp4', 'mov'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      String filePath = file.path.toString();

      String? videoUrl = await uploadVideoToFirebaseStorage(filePath);

      if (videoUrl != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Video uploaded to Firebase: $videoUrl'),
        ));
      }
    }
  } catch (e) {
    print('Error picking and uploading video: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
      // resizeToAvoidBottomInset: true,
appBar: AppBar(
  centerTitle: true,
  backgroundColor: Colors.white,
  elevation: 0,

  leading: IconButton(
    onPressed: () {
      Get.back();
    },
    icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
  ),

  title: Container(
// Adjust the left margin as needed
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      CircleAvatar(radius: 20,backgroundImage: NetworkImage(Chatimage.toString()),),
        SizedBox(
          width: Get.width * 0.018,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width*0.4,
              child: Text(
                // overflow: TextOverflow.ellipsis,
                softWrap:true,
                chatname.toString(),
                style: Get.theme.textTheme.titleSmall!.copyWith(color: AppColors.black,),
              ),
            ),
            SizedBox(
              height: Get.height * 0.005,
            ),
            Row(
              children: [
                Image.asset('assets/images/liveimage.png'),
                Text(
                  "Online",
                  style: Get.theme.textTheme.bodySmall!.copyWith(color: AppColors.black),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ),

  actions: [
    IconButton(
      icon: Icon(Icons.more_horiz, color: Colors.black), // Change the icon as needed
      onPressed: () {
        // Handle settings action
      },
    ),
  ],
),


      body: Container(
        child: Column(
          children: [
            // SizedBox(height: height*.03),
            SizedBox(
              height: Get.height * 0.02,
            ),
         Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                                  stream: _firestore
                                      .collection("RoomID")
                                      .doc("GRP${RecruiterId}${seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString()}")
                                      .collection('massages')
                                      .orderBy("time", descending: true)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (kDebugMode) {
                                          print("GRP${RecruiterId}${seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString()}=======roomid");
                                        }
                                    return snapshot.data != null
                                        ? ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            
                            final message = snapshot
                                .data!.docs[index]['message']
                                .toString();
                            final timestamp = snapshot.data!.docs[index]['time']
                                as Timestamp?; // Assuming 'time' is the timestamp field
                            final isSentByCurrentUser = snapshot
                                    .data!.docs[index]['sentby']
                                    .toString() ==
                            seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString();
        return isSentByCurrentUser?     Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:AppColors.blueThemeColor,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      constraints: BoxConstraints(
                                        maxWidth: Get.width / 2, // Set maximum width as half of the screen width
                                      ),
                                      padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 10), // Adjust padding as needed
                                      child: Text(
                                        breakMessage(message),
                                        style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 13, color: AppColors.white),
                                      ),
                                    ),
                                  ),
                              
                              SizedBox(height: Get.height*.01,),
                            //  if (timestamp != null)        Align(
                            //           alignment: AlignmentDirectional.bottomEnd,
                            //           child: Text(   formatTimestamp(timestamp),style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 10,color: Color(0xffCFCFCF))),
                            //         ),

                                    if (timestamp != null)        Align(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(   formatTimestamp(timestamp),style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 10,color: Color(0xffCFCFCF)),),
                                       SizedBox(width: 10,),   Text( snapshot.data!.docs[index]['isRead']==false?"Sent":"Seen",style: TextStyle(color: Colors.white),)
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
:


                             Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.bottomStart,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      constraints: BoxConstraints(
                                        maxWidth: Get.width / 2, // Set maximum width as half of the screen width
                                      ),
                                      padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 10), // Adjust padding as needed
                                      child: Text(
                                        breakMessage(message),
                                        style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 13, color: AppColors.white),
                                      ),
                                    ),
                                  ),
                              
                              SizedBox(height: Get.height*.01,),
                                 if (timestamp != null)    Align(
                                      alignment: AlignmentDirectional.bottomStart,
                                      child: Text(   formatTimestamp(timestamp),style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 10,color: Color(0xffCFCFCF))),
                                    ),
                                ],
                              ),
                            );

                                  // SizedBox(height: Get.height*.01,),
                                  // Align(
                                  //   alignment: AlignmentDirectional.bottomStart,
                                  //   child: Text("09:30 am",style: Get.theme.textTheme.bodySmall!.copyWith(fontSize: 10,color: Color(0xffCFCFCF))),
                                  // );
                            
        //                      Align(
        //                       alignment: isSentByCurrentUser
        //                           ? Alignment.centerRight
        //                           : Alignment.centerLeft,
        //                       child: Row(
        //                         mainAxisAlignment:isSentByCurrentUser
        //                           ? MainAxisAlignment.end
        //                           : MainAxisAlignment.start, 
        //                         children: [
        // SizedBox(width: Get.width*0.02,),
        //                        if(snapshot
        //                             .data!.docs[index]['sentby']
        //                             .toString() !=
        //                          seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString())   CircleAvatar(radius: 10,backgroundImage: NetworkImage(snapshot
        //                                             .data!.docs[index]['profileimage']
        //                                             .toString()),), Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: Container(
        //                           padding: EdgeInsets.all(8.0),
        //                           decoration: BoxDecoration(
        //                             color: isSentByCurrentUser
        //                                 ? AppColors.blueThemeColor
        //                                 :AppColors.blueThemeColor,
        //                             borderRadius: isSentByCurrentUser
        //                                 ? BorderRadius.only(
        //                                     topLeft: Radius.circular(8),
        //                                     topRight: Radius.circular(8),
        //                                     bottomLeft: Radius.circular(8),
        //                                   )
        //                                 : BorderRadius.only(
        //                                     topRight: Radius.circular(8),
        //                                     bottomRight: Radius.circular(8),
        //                                     bottomLeft: Radius.circular(8),
        //                                   ),
        //                           ),
        //                           child: Column(
        //                             crossAxisAlignment: isSentByCurrentUser
        //                                 ? CrossAxisAlignment.end
        //                                 : CrossAxisAlignment.start,
        //                             children: [
        //                               if (snapshot.data!.docs[index]['type']
        //                                       .toString() ==
        //                                   "text")
        //                                 Container(


        //                                   child: Text(
        //                                     breakMessage(message),
        //                                     style: TextStyle(color: Colors.white),
        //                                     textAlign: TextAlign.start,
        //                                     softWrap: true,
        //                                   ),

        //                                 ),
        //                               if (snapshot.data!.docs[index]['type']
        //                                       .toString() ==
        //                                   "img")
        //                                 Container(
        //                                   height: 150,
        //                                   width: 100,
        //                                   child: CachedNetworkImage(
        //                                     imageUrl: snapshot
        //                                         .data!.docs[index]['imageurl']
        //                                         .toString(),
        //                                     progressIndicatorBuilder: (context,
        //                                             url, downloadProgress) =>
        //                                         Center(
        //                                             child:
        //                                                 CircularProgressIndicator(
        //                                                     value:
        //                                                         downloadProgress
        //                                                             .progress)),
        //                                     errorWidget:
        //                                         (context, url, error) =>
        //                                             Icon(Icons.error),
        //                                   ),
        //                                 ),
        
        //     //  if(snapshot.data!.docs[index]['type'].toString()=="audio") CustomAudioPlayer(audioUrl:snapshot.data!.docs[index]['audiourl'].toString() ,),
             
          
        //       SizedBox(height: 4), // Adjust the spacing as needed
        //      if (timestamp != null)  Text(
        //         formatTimestamp(timestamp), // Format timestamp as needed
        //         style: TextStyle(color: Colors.grey, fontSize: 12),
        //       ),
        //     ],
        //   ),
        // ),
        //     ),
        //   ]));
        },
        ):Container();
        
                    }
        ),
        ),
        
         
              SizedBox(height: Get.height*0.02,),
        
             
               
            ],
          ),
        ),

        bottomNavigationBar: TapRegion(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
       child:Container(
          padding: MediaQuery.of(context).viewInsets,
        width: Get.width,
         child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
            child: SizedBox(
              height: Get.height * 0.07,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messagecontroller,
                         style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                    
               
                        suffixIcon: IconButton(
                          icon: GestureDetector(
                            onTap: () {
                             String userMessage = messagecontroller.text.trim();
                                        if(userMessage.isNotEmpty){
                                          onSendMessage();
                                        }
                            },
                            child: Image.asset('assets/images/sendme.png'),
                          ),
                        onPressed:(){
                                       
                                    } ,
                        ),
                        prefixIcon: IconButton(
                          icon: Image.asset('assets/images/addfile.png'),
                          onPressed: () {
                             showPopup(context); 
                            // Handle add file button tap
                          },
                        ),
                        hintText: 'Type Message',
                         hintStyle: const TextStyle(
                                                      color: Colors.grey),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
               ),
       )
      
     ), 
   
    ));
  }



  String breakMessage(String message) {


    var words = message.length; // Count of characters in the string
    var lines = "";
    var linesBreak="";// Variable to store the characters in separate lines

    for (int i = 0; i < words; i++) {
      // Concatenating characters to create separate lines
      if (linesBreak.length == 30) {
        linesBreak="";
        lines += '\n';
        // print(lines);// Add a line break for each non-space character
      }

        lines += message[i];
      linesBreak += message[i];
        // print(lines);

    }
    // List<String> words = message.split(' ');
    // var wordLenght=words.where((word) => word.isNotEmpty).length;
    // List<String> lines = [];
    // for (int i = 0; i < wordLenght; i += 5) {
    //   lines.add(words.skip(i).take(9).join(' '));
    // }
    return lines;
  }







  void _startOrStopRecording() async {
    try {
      if (isRecording) {
        recorderController.reset();

        final path = await recorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          debugPrint(path);
          debugPrint("Recorded file size: ${File(path).lengthSync()}");
          // _uploadAudioToFirebase(File(path));
        }
      } else {
        await recorderController.record(path: path!);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void _refreshWave() {
    if (isRecording) recorderController.refresh();
  }

//   void _showBottomSheet() {
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(23),
//             border: Border.all(color: Colors.grey, width: 0.5),
//           ),
//           child: SizedBox(
//             height: Get.height * 0.07,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messagecontroller,
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                         icon: GestureDetector(
//                           onTap: () {
//                             // Handle send button tap
//                           },
//                           child: Image.asset('assets/images/sendme.png'),
//                         ),
//                       onPressed:(){
//                                       String userMessage = messagecontroller.text.trim();
//                                       if(userMessage.isNotEmpty){
//                                         onSendMessage();
//                                       }
//                                     } ,
//                       ),
//                       prefixIcon: IconButton(
//                         icon: Image.asset('assets/images/addfile.png'),
//                         onPressed: () {
//                           // Handle add file button tap
//                         },
//                       ),
//                       hintText: 'Type Message',
//                       enabledBorder: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// Call this function where you want to show the BottomSheet
//  MessengeRead(){
//           _firestore.collection('RoomID').doc("GRP${RecruiterId}${seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString()}").collection("massages").get().then((value) {
//                value.docs.forEach((element) {
//  final result= _firestore.collection('RoomID').doc("GRP${RecruiterId}${seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString()}").collection("massages").doc(element.id).get();
//  if(result.then((value) => value.data()!['sentby'])==seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString().toString()){
//  _firestore.collection('RoomID').doc("GRP${RecruiterId}${seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString()}").collection("massages").doc(element.id).update({'isRead':true});
//  }
  


//                });
          
//           });
   
//       }

// }

Future<void> MessengeRead() async {
  final querySnapshot = await _firestore
      .collection('RoomID')
      .doc("GRP${RecruiterId}${seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString()}")
      .collection("massages")
      .get();

  for (final element in querySnapshot.docs) {
    final result = await _firestore
        .collection('RoomID')
        .doc("GRP${RecruiterId}${seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString()}")
        .collection("massages")
        .doc(element.id)
        .get();

    final sentBy = result.data()?['sentby'];
    // print("Sent By: $sentBy");

    if (sentBy ==RecruiterId ) {
  DocumentReference roomRef2 = _firestore.collection("RoomID").doc("GRP${RecruiterId}${seekerProfileController.viewSeekerData.value.seekerInfo!.id.toString()}").collection('massages').doc(element.id);

  await roomRef2.update({'isRead': true});
    }
  }
}


void showPopup(BuildContext context){
    showDialog(  

      barrierColor: Colors.transparent,
      context: context, builder: ((context) => AlertDialog(
      backgroundColor: Color(0xffE6F4F6),
      alignment: Alignment.bottomCenter,
      shadowColor: Colors.transparent,
      elevation: 0,

      insetPadding: EdgeInsets.only(bottom: 100),
     title:
       Container(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
       Column(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.blueThemeColor,
              radius: 30,child: Center(child: Image.asset('assets/images/docs.png' ,height: 30,width: 30,color: Colors.white,)),),
                 SizedBox(height: 10,),
            Text("Documents",style: TextStyle(color:AppColors.blueThemeColor,fontSize: 15),)

          ],
        ),
      InkWell(
        child: Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.blueThemeColor,
                radius: 30,child: Center(child: Image.asset('assets/images/camera2.png' ,height: 30,width: 30,color: Colors.white,)),),
                   SizedBox(height: 10,),
              Text("Camera",style: TextStyle(color:AppColors.blueThemeColor,fontSize: 15),)
        
            ],
          ),
          onTap: (){
            uploadSelectedImageAndGetUrl(ImageSource.gallery);
          },
      ),
        Column(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.blueThemeColor,
              radius: 30,child: Center(child: Image.asset('assets/images/image-gallery.png' ,height: 30,width: 30,color: Colors.white,)),),
                 SizedBox(height: 10,),
            Text("Camera",style: TextStyle(color:AppColors.blueThemeColor,fontSize: 15),)

          ],
        ),
       ],))
    )));
   }

}



// }