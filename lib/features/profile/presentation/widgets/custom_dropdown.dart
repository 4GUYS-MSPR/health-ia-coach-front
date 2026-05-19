import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final String label;
  String? selectedValue;
  final List<String> listChoice;
  CustomDropDown({
    required this.label,
    required this.selectedValue,
    required this.listChoice,
    super.key
    });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
         style: Theme.of(context).textTheme.headlineSmall
         ),
         DropdownButtonFormField<String>(
          initialValue: widget.selectedValue,
          style: TextStyle(
            fontSize: 18
          ),
          items: widget.listChoice.map((String choice) {
            return DropdownMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList() ,
          onChanged: (String? newValue){
            setState(() {
              widget.selectedValue = newValue;
            });
          }
          ),
      ],
    );
  }
}