import 'package:fitpulse_app/app/config/colors.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Input extends StatefulWidget {
  const Input({
    super.key,
    required this.label,
    required this.placeholder,
    this.maxLines = 1,
    this.obscure = false,
  });

  final String label;
  final String placeholder;
  final int maxLines;
  final bool obscure;

  @override
  State<Input> createState() => _input();
}

class _input extends State<Input> {
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
        TextField(
          obscureText: widget.obscure,
          autofocus: false,
          // controller: _emailController,
          scrollPhysics: const ScrollPhysics(),
          maxLines: widget.maxLines,
          textInputAction: TextInputAction.next,
          minLines: 1,
          style: const TextStyle(fontSize: 15, color: AppColors.blackCoal),
          cursorColor: theme.color,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusColor: Theme.of(context).indicatorColor,
            contentPadding: const EdgeInsets.only(left: 12, top: 30, right: 12),
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
            hintText: widget.placeholder,
            fillColor: Color(0xFFEBE9E9),
          ),
        ),
      ],
    );
  }
}
