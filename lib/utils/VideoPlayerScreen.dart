import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;

  const VideoPlayerScreen({Key? key, required this.videoPath}) : super(key: key);

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  bool chewieInitialized = false ;
  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
    // Do not initialize ChewieController here, wait for VideoPlayerController to be initialized
  }

  Future<void> _initializeVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoPath);
    await _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
   if(_videoPlayerController.value.isInitialized) {
     _initializeChewieController();
   }
    setState(() {});
  }

  void _initializeChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoInitialize: true,
      autoPlay: true,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      showControlsOnInitialize: false,
      looping: true,
      // Other customization options can be added here
    );
    setState(() {
      chewieInitialized = true ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            "assets/images/icon_back_blue.png",
            height: Get.height * .06,
          ),
        ),
        title: const Text('Video Player Screen'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (chewieInitialized == true) {
            return Chewie(
              controller: _chewieController,
            );
          } else {
            // Show a loading indicator or return an empty container
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}

