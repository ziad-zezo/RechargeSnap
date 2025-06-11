import 'package:flutter/material.dart';
import 'package:recharge_snap/widgets/custom_tooltip.dart';

class CustomAppBarIcon extends StatelessWidget {
  const CustomAppBarIcon({
    super.key,
    required this.tooltipText,
    required this.route,
    required this.icon,
    this.onPressed,
  });
  final String tooltipText;
  final String route;
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
          icon: Icon(icon),
          color: Colors.white70,
        ),
      ),
    );
  }
}
