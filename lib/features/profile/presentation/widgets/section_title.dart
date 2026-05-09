import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    required this.title,
    super.key});

    final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 32,
          ),
        ),
        Positioned(
          right: -60,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_note,
              size: 42,
            ),
          ),
        ),
      ],
    );
  }
}