import 'package:flutter/material.dart';

class AppButtonOutline extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color? colorText;
  final Color? colorTextDisabled;
  final Color? colorBackground;
  final Color? colorBackgroundDisabled;
  final Color? colorBoder;
  final Color? colorBoderDisabled;
  final double? radius;

  const AppButtonOutline({
    super.key,
    required this.onPressed,
    required this.text,
    this.colorText,
    this.colorTextDisabled,
    this.colorBackground,
    this.colorBackgroundDisabled,
    this.colorBoder,
    this.colorBoderDisabled,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final enable = onPressed != null;
    final textColor = colorText ?? Colors.black;
    final textColorDisabled = colorTextDisabled ?? Colors.grey;
    final backgroundColor = colorBackground ?? Colors.white;
    final backgroundColorDisabled = colorBackgroundDisabled ?? Colors.grey[200]!;
    final borderColor = colorBoder ?? Colors.black;
    final borderColorDisabled = colorBoderDisabled ?? Colors.grey[400]!;
    final borderRadius = radius ?? 4;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        disabledBackgroundColor: backgroundColorDisabled,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: enable ? borderColor : borderColorDisabled),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: enable ? textColor : textColorDisabled,
          fontSize: 14.0,
        ),
      ),
    );
  }
}
