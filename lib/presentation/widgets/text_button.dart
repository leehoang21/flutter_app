import 'package:flutter/material.dart';

enum ButtonState { active, inactive }

class TextButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final Color? buttonColor;
  final Color? titleColor;
  final String title;
  final double? width;
  final double? height;
  final bool enabled;

  const TextButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.enabled = true,
    this.buttonColor,
    this.titleColor,
    this.height,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled ? onPressed : null,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
            enabled ? Colors.black : Colors.grey),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(500),
            ),
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
