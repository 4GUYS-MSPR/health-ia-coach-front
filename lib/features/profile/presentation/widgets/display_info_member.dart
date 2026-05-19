import 'package:flutter/material.dart';

import 'info_text.dart';

class DisplayInfoMember extends StatefulWidget {
  final String label;
  final String value;
  const DisplayInfoMember({
    required this.label,
    required this.value,
    super.key});

  @override
  State<DisplayInfoMember> createState() => _DisplayInfoMemberState();
}

class _DisplayInfoMemberState extends State<DisplayInfoMember> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      crossAxisAlignment: .start,
      children: [
        InfoText(
          text: widget.label),
          InfoText(
          text: widget.value),
      ],);
  }
}