import 'package:flutter/material.dart';

class CustomTooltip extends StatelessWidget {
  final String message;
  final Widget child;
  final Color backgroundColor;
  final TextStyle textStyle;
  final double cornerRadius;
  final EdgeInsets padding;
  final Duration showDuration;
  final Duration waitDuration;
  final double verticalOffset;
  const CustomTooltip({
    Key? key,
    required this.message,
    required this.child,
    this.backgroundColor = const Color(0xFF424242),
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 14),
    this.cornerRadius = 8,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.showDuration = const Duration(seconds: 2),
    this.waitDuration = const Duration(milliseconds: 500),
    this.verticalOffset=-60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: child,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(cornerRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: padding,
      textStyle: textStyle,
      preferBelow: true,
      verticalOffset: verticalOffset,
      showDuration: showDuration,
      waitDuration: waitDuration,
    );
  }
}
