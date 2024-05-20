// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';

// class ImagePickerCubit extends Cubit<File?> {
//   ImagePickerCubit() : super(null);

//   Future<void> pickImage(BuildContext context) async {
//     final picker = ImagePicker();
//     File? imageFile;

//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Choose option'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text('Gallery'),
//                 onTap: () async {
//                   final pickedFile =
//                       await picker.pickImage(source: ImageSource.gallery);
//                   if (pickedFile != null) {
//                     imageFile = File(pickedFile.path);
//                     print('Image selected from gallery: ${imageFile!.path}');
//                   }
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_camera),
//                 title: Text('Camera'),
//                 onTap: () async {
//                   final pickedFile =
//                       await picker.pickImage(source: ImageSource.camera);
//                   if (pickedFile != null) {
//                     final directory = await getApplicationDocumentsDirectory();
//                     final name = pickedFile.name;
//                     final file = File('${directory.path}/$name');
//                     await pickedFile.saveTo(file.path);
//                     imageFile = file;
//                     print('Image selected from camera: ${imageFile!.path}');
//                   }
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );

//     emit(imageFile);
//   }
// }
