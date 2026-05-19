import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String text;

  const InfoText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Theme.of(context).textTheme.displayLarge?.color, fontSize: 18),
    );
  }
}
