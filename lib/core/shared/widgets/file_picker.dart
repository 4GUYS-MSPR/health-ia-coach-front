import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomFilePicker extends StatefulWidget {
  final Function(PlatformFile) sendMedia;
  const CustomFilePicker({super.key, required this.sendMedia});

  @override
  State<CustomFilePicker> createState() => _CustomFilePickerState();
}

class _CustomFilePickerState extends State<CustomFilePicker> {
  PlatformFile? media;

  Widget _buildMediaPreview() {
    if (media != null) {
      if (['jpg', 'jpeg', 'png', 'svg'].contains(media!.extension)) {
        if (media!.bytes != null) {
          return Image.memory(media!.bytes!);
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.image, size: 48),
              const SizedBox(height: 8),
              Text(media!.name, style: TextStyle(fontSize: 12)),
            ],
          );
        }
      } else if (['dvr', 'mp4', 'avi', 'mkv'].contains(media!.extension)) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.videocam, size: 48),
            const SizedBox(height: 8),
            Text(media!.name, style: TextStyle(fontSize: 12)),
          ],
        );
      }
    }
    return const Icon(Icons.add_a_photo, size: 48);
  }

  Future<void> chooseFile() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'svg', 'dvr', 'mp4', 'avi', 'mkv'],
      withData: true,
    );
    if (result != null) {
      setState(() {
        media = result.files.first;
      });
      widget.sendMedia(media!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        chooseFile();
      },
      child: Container(
        decoration: BoxDecoration(
          border: media == null ? Border.all() : Border(),
          borderRadius: BorderRadius.circular(24),
        ),
        width: 150,
        height: 200,
        child: media == null ? const Icon(Icons.add_a_photo, size: 48) : _buildMediaPreview(),
      ),
    );
  }
}
