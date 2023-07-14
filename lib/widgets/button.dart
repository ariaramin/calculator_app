import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color? color;
  final Function()? onPressed;

  const Button({
    super.key,
    required this.text,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor:
              color ?? Theme.of(context).colorScheme.primaryContainer,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 26,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
