import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toastification/toastification.dart';

void showToast({
  required BuildContext context,
  required String message,
  required ToastificationType toastType,
}) {
  toastification.show(
    context: context, // optional if you use ToastificationWrapper
    title: SizedBox(
      height: 50,
      child: Row(
        children: [
          Center(
            child: Text(
              message,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    ),
    autoCloseDuration: const Duration(seconds: 3),
    type: toastType,
    alignment: Alignment.bottomCenter,
    applyBlurEffect: true,
    style: ToastificationStyle.flatColored,
    icon: _getIcon(toastType: toastType),
    //description: Text(message),
  );
}

Widget _getIcon({required ToastificationType toastType}) {
  switch (toastType) {
    case ToastificationType.error:
      return const Icon(
        FontAwesomeIcons.circleXmark,
        color: Color.fromARGB(161, 255, 17, 0),
      );
    case ToastificationType.success:
      return const Icon(
        FontAwesomeIcons.circleCheck,
        color: Color.fromARGB(255, 4, 140, 9),
      );
    case ToastificationType.warning:
      return const Icon(Icons.warning, color: Colors.yellow);
    case ToastificationType.info:
      return const Icon(Icons.info, color: Color.fromARGB(180, 5, 57, 100));
    default:
      return const Icon(Icons.error);
  }
}
