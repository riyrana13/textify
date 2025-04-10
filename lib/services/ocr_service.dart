import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRService {
  static Future<String> extractTextFromImage(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final recognizedText = await textRecognizer.processImage(inputImage);
      await textRecognizer.close();
      if (recognizedText.text.isEmpty) {
        return "🖼️🔍 No readable text found in the image. Give it another shot! 🤖";
      }
      return recognizedText.text;
    } catch (e) {
      return "🖼️🔍 No readable text found in the image. Give it another shot! 🤖";
    }
  }
}
