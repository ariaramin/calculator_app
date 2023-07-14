import 'package:calculator/theme/app_colors.dart';
import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  final List<String> buttonList;
  final Function(String button) onButtonPressed;

  const ButtonRow({
    super.key,
    required this.buttonList,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var button in buttonList) ...{
          Expanded(
            child: Button(
              text: button,
              color: _getButtonColor(context, button),
              onPressed: () => onButtonPressed(button),
            ),
          ),
        }
      ],
    );
  }

  Color? _getButtonColor(BuildContext context, String button) {
    final primaryButtons = ['÷', '×', '-', '+', '='];
    final secondaryButtons = ['C', '+/-', '%'];
    if (primaryButtons.contains(button)) {
      return AppColors.primaryColor;
    } else if (secondaryButtons.contains(button)) {
      return Theme.of(context).colorScheme.secondary;
    }
    return null;
  }
}
