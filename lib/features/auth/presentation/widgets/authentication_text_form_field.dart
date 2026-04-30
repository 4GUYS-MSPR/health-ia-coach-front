import 'package:flutter/material.dart';

class AuthenticationTextFormField extends StatefulWidget {
  const AuthenticationTextFormField({
    required this.icon,
    required this.textEditingController,
    required this.label,
    required this.isPassword,
    super.key,
  });

  final IconData icon;
  final TextEditingController textEditingController;
  final String label;
  final bool isPassword;

  @override
  State<AuthenticationTextFormField> createState() => _AuthenticationTextFormFieldState();
}

class _AuthenticationTextFormFieldState extends State<AuthenticationTextFormField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      obscureText: _isObscured, 
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );
  }
}