import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img_lib; // Import the image library

class ImagePickerController {
  File? _file;

  File? get file => _file;

  void setFile(File? file) {
    _file = file;
  }
}

class ImagePickerWidget extends StatefulWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;
  final ImagePickerController controller;
  final bool showError;

  const ImagePickerWidget({
    super.key,
    required this.controller,
    this.height = 180,
    this.width = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.showError = false,
  });

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        widget.controller.setFile(File(pickedFile.path));
        _uploadImage(File(pickedFile.path)); // Upload after picking
      });
    }
  }

  Future<String?> getPresignedUrl(String fileName) async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://54.179.166.162:7070/auth-service/api/v1/auth/generate-presigned-url'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'file_name': fileName}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (!data['error']) {
          return data['data'];
        }
      }
      return null;
    } catch (e) {
      print('Failed to get pre-signed URL: $e');
      return null;
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    final fileName = imageFile.path.split('/').last;
    final preSignedUrl = await getPresignedUrl(fileName);

    if (preSignedUrl != null) {
      // Read the image
      img_lib.Image? originalImage =
          img_lib.decodeImage(await imageFile.readAsBytes());
      // Resize the image to a width of 800 pixels
      img_lib.Image resizedImage =
          img_lib.copyResize(originalImage!, width: 800);

      // Encode the resized image to JPEG
      List<int> imageBytes = img_lib.encodeJpg(resizedImage, quality: 85);

      var request = http.Request('PUT', Uri.parse(preSignedUrl))
        ..headers['Content-Type'] = 'image/jpeg'
        ..bodyBytes = imageBytes;

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Upload successful');
      } else {
        print('Failed to upload image: ${response.statusCode}');
      }
    } else {
      print('Failed to obtain pre-signed URL');
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo_library, size: 50),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                  Text(
                    'Gallery',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt, size: 50),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  Text(
                    'Camera',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ],
          ),
        );
      },
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            _showImageSourceActionSheet(context);
          },
          child: DottedBorder(
            color: Colors.black,
            dashPattern: [10, 4],
            borderType: BorderType.RRect,
            radius: Radius.circular(8),
            child: Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: widget.borderRadius,
              ),
              child: ClipRRect(
                borderRadius: widget.borderRadius,
                child: widget.controller.file == null
                    ? Center(
                        child: Icon(
                        Icons.add_a_photo,
                        size: 40,
                      ))
                    : Image.file(widget.controller.file!, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
