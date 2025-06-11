
  import 'package:flutter/material.dart';

class DropdownMenuItemBuilder{
static DropdownMenuItem<String> buildDropdownItem(
    String label,
    String value,
    String iconPath,
  ) {
    return DropdownMenuItem(
      //alignment: Alignment.centerRight,
      value: value,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            Image.asset(iconPath, width: 30, height: 30),
            const SizedBox(width: 15),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}