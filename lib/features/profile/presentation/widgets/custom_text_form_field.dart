import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  const CustomTextFormField({super.key, required this.label, required this.controller});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.headlineSmall),
        TextFormField(
          // FIXME: l10n break this logic
          enabled: widget.label == 'Abonnement' ? false : true,
          controller: widget.controller,
        ),
      ],
    );
  }
}
