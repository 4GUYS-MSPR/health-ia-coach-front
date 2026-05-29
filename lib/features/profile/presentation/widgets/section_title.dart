import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final VoidCallback onTapEdit;
  const SectionTitle({required this.title, required this.onTapEdit, super.key});


  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min, 
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: onTapEdit,
          icon: const Icon(
            Icons.edit_note,
            size: 42,
          ),
        ),
      ],
    );
  }
}