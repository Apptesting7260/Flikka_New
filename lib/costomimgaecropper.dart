// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'dart:io';
//
// class CustomImageCropper extends StatefulWidget {
//   @override
//   _CustomImageCropperState createState() => _CustomImageCropperState();
// }
//
// class _CustomImageCropperState extends State<CustomImageCropper> {
//   File? _imageFile;
//   double _cropperX = 100;
//   double _cropperY = 100;
//   double _cropperWidth = 200;
//   double _cropperHeight = 200;
//
//   Future<void> _pickAndCropImage(ImageSource source) async {
//     final picker = ImagePicker();
//     try {
//       final pickedImage = await picker.pickImage(source: source);
//       if (pickedImage != null) {
//         final croppedImage = await ImageCropper.cropImage(
//           sourcePath: pickedImage.path,
//           aspectRatioPresets: [
//             CropAspectRatioPreset.square,
//             CropAspectRatioPreset.ratio3x2,
//             CropAspectRatioPreset.original,
//             CropAspectRatioPreset.ratio4x3,
//             CropAspectRatioPreset.ratio16x9,
//           ],
//           cropStyle: CropStyle.rect, // Use CropStyle.rect to achieve similar behavior
//         );
//
//         if (croppedImage != null) {
//           setState(() {
//             _imageFile = croppedImage as File?;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error picking or cropping image: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Custom Cropper'),
//       ),
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             if (_imageFile != null)
//               Positioned(
//                 top: _cropperY,
//                 left: _cropperX,
//                 child: GestureDetector(
//                   onPanUpdate: (details) {
//                     setState(() {
//                       _cropperX += details.delta.dx;
//                       _cropperY += details.delta.dy;
//                     });
//                   },
//                   child: ClipRect(
//                     child: Container(
//                       width: _cropperWidth,
//                       height: _cropperHeight,
//                       child: Image.file(
//                         _imageFile!,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _pickAndCropImage(ImageSource.gallery),
//         tooltip: 'Pick and Crop Image',
//         child: Icon(Icons.photo_library),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: CustomImageCropper(),
//   ));
// }
