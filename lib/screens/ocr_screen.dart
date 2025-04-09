import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/ocr_service.dart';
import '../utils/image_picker_helper.dart';
import '../widgets/image_preview.dart';

class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key});

  @override
  State<OCRScreen> createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  File? _image;
  String _extractedText = '';
  bool _isLoading = false;

  Future<void> _getImage(bool fromCamera) async {
    final pickedFile = await ImagePickerHelper.pickImage(fromCamera);
    if (pickedFile == null) return;
    setState(() {
      _isLoading = true;
    });
    setState(() => _image = pickedFile);
    final text = await OCRService.extractTextFromImage(pickedFile);
    setState(() {
      _extractedText = text;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('!! Textify !!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 1, 10, 27),
              )),
        ),
        backgroundColor: const Color.fromARGB(255, 182, 178, 235),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Capture or select any image to extract text from it..!!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            ImagePreview(image: _image),
            const SizedBox(height: 16),
            if (_isLoading)
              const Expanded(
                child: Text(
                  'Generating text from image..',
                  style: TextStyle(fontSize: 16),
                ),
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _extractedText,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _getImage(true),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _getImage(false),
                  icon: const Icon(Icons.photo),
                  label: const Text('Gallery'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_extractedText.isNotEmpty) {
                      Clipboard.setData(ClipboardData(text: _extractedText));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Copied to clipboard ✅")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("No Text found to copy ❌")),
                      );
                    }
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text("Copy Text"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
