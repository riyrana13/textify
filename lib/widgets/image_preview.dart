import 'dart:io';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final File? image;

  const ImagePreview({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Container(
        height: 300,
        width: double.infinity,
        color: Colors.grey.shade300,
        child: const Center(child: Text('No image selected')),
      );
    }
    return Image.file(image!, height: 300);
  }
}
