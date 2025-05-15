import 'package:flutter/material.dart';

class ShortcutIcon extends StatelessWidget {
  const ShortcutIcon({super.key, required this.onPressed, required this.icon});
  final VoidCallback onPressed;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color.fromARGB(170, 134, 76, 175),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: Colors.green,
        iconSize: 30,
      ),
    );
  }
}
