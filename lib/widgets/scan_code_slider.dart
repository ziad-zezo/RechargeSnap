import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recharge_snap/colors.dart';
import 'package:recharge_snap/cubit/scanner_cubit.dart';
import 'package:recharge_snap/generated/l10n.dart';
import 'package:recharge_snap/screens/scanner_screen.dart';
import 'package:recharge_snap/widgets/show_toast.dart';
import 'package:toastification/toastification.dart';

class ScanCodeSlider extends StatefulWidget {
  const ScanCodeSlider({super.key});

  @override
  State<ScanCodeSlider> createState() => _ScanCodeSliderState();
}

class _ScanCodeSliderState extends State<ScanCodeSlider> {
  bool isClicked = false;
  final _textRecognizer = TextRecognizer();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final s = S.of(context);
    //full slider container (background)
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 0.5),
        ),
        child: Stack(
          children: [
            //background container (inner)
            Container(
              width: size.width * 0.45,
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //*Scan Button
                  IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image_outlined, size: 26),
                    tooltip: s.pickImage,
                  ),
                  IconButton(
                    onPressed:
                        () => Navigator.of(
                          context,
                        ).pushNamed(ScannerScreen.routeName),
                    icon: const Icon(Icons.camera_alt_outlined, size: 26),
                    tooltip: s.scanCodeUsingCamera,
                  ),
                  //left padding to move the buttons right
                  AnimatedPadding(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.bounceOut,
                    padding: EdgeInsets.only(
                      right: !isClicked ? size.width * 0.2 : 0,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInBack,
              left: 0,
              right: isClicked ? 90 : 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () => setState(() => isClicked = !isClicked),
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx < -1) {
                    // سحب لليسار
                    setState(() {
                      isClicked = true;
                    });
                  } else if (details.delta.dx > 1) {
                    // سحب لليمين
                    setState(() {
                      isClicked = false;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(
                          2,
                          0,
                        ), // X=4, Y=0 → shadow to the right only
                        blurRadius: 2,
                        spreadRadius: 2,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),

                    color: Colors.white,
                  ),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(s.scanCode, maxLines: 1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    XFile? image;
    final ImagePicker picker = ImagePicker();

    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      _recognizeText(image);
    } catch (e) {
      if (!mounted) return;
      showToast(
        context: context,
        message: S.of(context).cantPickImage,
        toastType: ToastificationType.error,
      );
    }
  }

  void _recognizeText(image) async {
    if (image != null) {
      try {
        InputImage inputImage = InputImage.fromFilePath(image.path);
        final recognizedText = await _textRecognizer.processImage(inputImage);
        _processText(recognizedText.text);
      } catch (e) {
        if (!mounted) return;
        showToast(
          context: context,
          message: "Can't Recognize Text",
          toastType: ToastificationType.error,
        );
      }
    } else {
      if (!mounted) return;
      showToast(
        context: context,
        message: 'Please Select Image',
        toastType: ToastificationType.warning,
      );
    }
  }

  Future<void> _showResultDialog(String number) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Dialog(
            backgroundColor: primaryColor,

            shape: RoundedRectangleBorder(
              side: BorderSide(color: secondaryColor),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 60,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      S.of(context).numberDetected,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: containerBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        number,

                        style: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      S.of(context).correctNumberQuestion,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            showToast(
                              context: context,
                              message: S.of(context).canceled,
                              toastType: ToastificationType.warning,
                            );
                            //  _pickImage();
                          },
                          child: Text(
                            S.of(context).cancel,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            context.read<ScannerCubit>().doneScan(number);

                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
                            showToast(
                              context: context,
                              message: S.of(context).done,
                              toastType: ToastificationType.success,
                            );
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  void _processText(String fullText) {
    final numberMatches = RegExp(
      r'\d{12,20}',
    ).allMatches(fullText.replaceAll(' ', ''));

    if (numberMatches.isNotEmpty) {
      final bestMatch = numberMatches.first.group(0);
      if (bestMatch != null) {
        _showResultDialog(bestMatch);
      } else {
        showToast(
          context: context,
          message: S.of(context).noNumbersDetected,
          toastType: ToastificationType.error,
        );
      }
    } else {
      showToast(
        context: context,
        message: S.of(context).noNumbersDetected,
        toastType: ToastificationType.error,
      );
    }
  }
}
