import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Toggle extends StatefulWidget {
  final List<String> options;
  final String? initialSelectedOption;
  final String label;
  final void Function(String selectedOption)? onOptionSelected;

  const Toggle({
    super.key,
    required this.options,
    required this.label,
    this.initialSelectedOption,
    this.onOptionSelected,
  });

  @override
  _ToggleState createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialSelectedOption;
  }

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
        Row(mainAxisSize: MainAxisSize.min, children: [
          ...widget.options.map((option) {
            final isSelected = selectedOption == option;
            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      isSelected ? theme.color : Color(0xFFEBE9E9),
                  side: BorderSide(color: Colors.transparent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    selectedOption = option;
                  });
                  if (widget.onOptionSelected != null) {
                    widget.onOptionSelected!(option);
                  }
                },
                child: Row(
                  children: [
                    if (isSelected) ...[
                      Icon(Icons.check, color: AppColors.whiteTitanium, size: 18),
                      const SizedBox(width: 4),
                    ],

                    Text(
                      option,
                      style: TextStyle(
                        color: isSelected ? AppColors.whiteTitanium : AppColors.blackCoal,
                      ),
                    ),
                  ],
                ),

              ),
            );
          }).toList(),
        ])
      ],
    );
  }
}
