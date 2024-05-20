import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class ImagePickerController {
  File? _file;

  File? get file => _file;

  void setFile(File? file) {
    _file = file;
  }
}

class ImagePickerWidget extends StatefulWidget {
  // final String title;
  final double height;
  final double width;
  // final Color backgroundColor;
  final BorderRadius borderRadius;
  final ImagePickerController controller;
  // final String? errorText;
  final bool showError;

  const ImagePickerWidget({
    super.key,
    required this.controller,
    this.height = 180,
    this.width = double.infinity,
    // this.backgroundColor = MColors.primary,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    // this.errorText,
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
      });
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
