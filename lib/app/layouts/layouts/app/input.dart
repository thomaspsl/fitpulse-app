import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  const Input({
    super.key,
    required this.label,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.initialValue,
    this.onChanged,
  });

  final String label;
  final String? hintText;
  final String? initialValue;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            widget.label,
            style: TextStyle(
              color: Theme.of(context).cardColor,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        TextFormField(
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusColor: Theme.of(context).indicatorColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            filled: true,
            hintStyle: TextStyle(color: AppColors.greyDark),
            hintText: widget.hintText,
            fillColor: const Color(0xFFEBE9E9),
          ),
          initialValue: widget.initialValue,
          style: const TextStyle(fontSize: 15, color: AppColors.blackCoal),
          cursorColor: theme.color,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
