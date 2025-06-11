import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.iconSize = 28,
    this.fontSize,
    this.color = Colors.white70,
  });
  final String label;
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  final double iconSize;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(icon, size: iconSize, color: color),

          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: TextStyle(color: color, fontSize: fontSize),
            ),
          ),
        ],
      ),
    );
  }
}


//