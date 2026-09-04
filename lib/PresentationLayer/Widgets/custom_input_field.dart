import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatefulWidget {
  final Widget? prefixIcon;
  final String hintText;
  final bool readOnly;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final int? maxLines;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;

  const CustomInputField({
    Key? key,
    this.prefixIcon,
    required this.hintText,
    this.readOnly = false,
    this.controller,
    this.keyboardType,
    this.onTap,
    this.maxLines,
    this.validator,
    this.inputFormatter,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool hidePassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8F9),
          border: Border.all(
            color: const Color(0xFFE8ECF4),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: TextFormField(
            controller: widget.controller,
            readOnly: widget.readOnly,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            textInputAction: TextInputAction.done,
            inputFormatters: widget.inputFormatter,
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF8391A1),
              ),
              hintMaxLines: 2,
            ),
            onTap: widget.onTap,
            validator: widget.validator,
          ),
        ),
      ),
    );
  }
}
