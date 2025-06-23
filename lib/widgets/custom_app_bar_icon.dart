import 'package:flutter/material.dart';
import 'package:recharge_snap/widgets/custom_tooltip.dart';

class CustomAppBarIcon extends StatelessWidget {
  const CustomAppBarIcon({
    super.key,
    required this.tooltipText,
    required this.icon,
    this.onPressed,
    this.color = Colors.white70,
  });

  final Color color;
  final String tooltipText;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomTooltip(
      message: tooltipText,
      verticalOffset: 30,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white, size: 22),
          color: color,
        ),
      ),
    );
  }
}
