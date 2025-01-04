import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final int? minLines;
  final int? maxLines;
  final TextEditingController controller; // Add the controller as a property

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller, // Ensure this is required in the constructor
    this.minLines,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, 
      decoration: InputDecoration(
        hintText: hintText,
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: TextInputType.multiline,
    );
  }
}
