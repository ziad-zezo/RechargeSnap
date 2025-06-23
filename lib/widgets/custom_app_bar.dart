import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.leading,
    this.actions,
    required this.title,
    this.centerTitle = true,
    this.color,
  });

  final Widget? leading;
  final List<Widget>? actions;
  final String title;
  final bool centerTitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      elevation: 1,
      backgroundColor: color ?? const Color.fromARGB(29, 0, 0, 0),
      leading: leading,
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
