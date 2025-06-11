import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recharge_snap/screens/scanner_screen.dart';

class ScanCodeSlider extends StatefulWidget {
  const ScanCodeSlider({super.key});

  @override
  State<ScanCodeSlider> createState() => _ScanCodeSliderState();
}

class _ScanCodeSliderState extends State<ScanCodeSlider> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: Stack(
        children: [
          Container(
            width: size.width * 0.45,
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                AnimatedPadding(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.bounceOut,
                  padding: EdgeInsets.only(
                    left: isClicked ? size.width * 0.2 : 0,
                  ),
                ),
                //*Scan Button
                IconButton(
                  onPressed: _pickImage,
                  icon: const Icon(FontAwesomeIcons.fileImage),
                ),
                IconButton(
                  onPressed:
                      () => Navigator.of(
                        context,
                      ).pushNamed(ScannerScreen.routeName),
                  icon: const Icon(FontAwesomeIcons.qrcode),
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
                child: const Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('Scan Code', maxLines: 1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      await picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    // ImagePicker.platform.getImageFromSource(source: ImageSource.camera);
  }
}
