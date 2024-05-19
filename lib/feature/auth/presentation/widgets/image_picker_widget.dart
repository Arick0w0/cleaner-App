import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mae_ban/core/constants/color.dart';

class ImagePickerController {
  File? _file;

  File? get file => _file;

  void setFile(File? file) {
    _file = file;
  }
}

class ImagePickerWidget extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final ImagePickerController controller;
  final String? errorText;

  const ImagePickerWidget({
    Key? key,
    required this.title,
    required this.controller,
    this.height = 180,
    this.width = double.infinity,
    this.backgroundColor = MColors.grey,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.errorText,
  }) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        widget.controller.setFile(File(pickedFile.path));
      });
    }
  }

  void _showPickerDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _showPickerDialog,
          child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: widget.borderRadius,
              border: Border.all(
                color:
                    widget.controller.file == null && widget.errorText != null
                        ? Colors.red
                        : Colors.transparent,
              ),
            ),
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: widget.controller.file == null
                  ? Center(child: Text(widget.title))
                  : Image.file(widget.controller.file!, fit: BoxFit.cover),
            ),
          ),
        ),
        if (widget.controller.file == null && widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.errorText!,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
