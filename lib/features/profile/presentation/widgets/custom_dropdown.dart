import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final String label;
  final String? selectedValue;
  final List<String> listChoice;

  const CustomDropDown({
    required this.label,
    required this.selectedValue,
    required this.listChoice,
    super.key,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  late String? _selectedValue;

  @override
  void initState() {
    _selectedValue = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.headlineSmall),
        DropdownButtonFormField<String>(
          initialValue: _selectedValue,
          style: TextStyle(fontSize: 18),
          items: widget.listChoice.map((String choice) {
            return DropdownMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
          },
        ),
      ],
    );
  }
}
