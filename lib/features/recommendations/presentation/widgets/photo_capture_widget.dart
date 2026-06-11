import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/extensions/l10n_extension.dart';

class PhotoCapturePage extends StatefulWidget {
  const PhotoCapturePage({super.key});

  @override
  State<PhotoCapturePage> createState() => _PhotoCapturePageState();
}

class _PhotoCapturePageState extends State<PhotoCapturePage> {
  File? _imageFile;
  PlatformFile? _selectedFile;
  final ImagePicker _picker = ImagePicker();

  Future<PlatformFile> _toPlatformFile(XFile picked) async {
    final file = File(picked.path);
    final size = await file.length();
    return PlatformFile(
      name: picked.name,
      size: size,
      path: picked.path,
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(
      source: source,
      maxWidth: 1600,
      maxHeight: 1200,
      imageQuality: 85,
    );
    if (picked != null) {
      final platformFile = await _toPlatformFile(picked);
      setState(() {
        _imageFile = File(picked.path);
        _selectedFile = platformFile;
      });
    }
  }

  void _confirmAndReturn() {
    if (_selectedFile != null) {
      Navigator.of(context).pop(_selectedFile);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.photoCaptureTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: _imageFile == null
                    ? Text(context.l10n.photoCaptureEmptyMessage, textAlign: TextAlign.center)
                    : Image.file(_imageFile!, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: Text(context.l10n.photoCaptureCameraButton),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: Text(context.l10n.photoCaptureImportButton),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: _confirmAndReturn,
              child: Text(context.l10n.photoCaptureValidateButton),
            ),
          ],
        ),
      ),
    );
  }
}
