import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageAndCompress() async {
  try {
    final ImagePicker imagePicker = ImagePicker();

    // استخدام Android Photo Picker المدمج (بدون صلاحيات)
    // يعمل تلقائياً على Android 13+ و يتوافق مع الإصدارات الأقدم
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      final compressedFile = await FlutterImageCompress.compressWithFile(
        image.path,
        quality: 80,
        minWidth: 500,
        minHeight: 500,
      );

      if (compressedFile != null) {
        // Create a temporary file from the compressed data
        final tempDir = Directory.systemTemp;
        final tempFile = File(
          '${tempDir.path}/compressed_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
        await tempFile.writeAsBytes(compressedFile);
        return tempFile;
      }
    }
    return null;
  } catch (e) {
    debugPrint('Error picking image: $e');
    return null;
  }
}
