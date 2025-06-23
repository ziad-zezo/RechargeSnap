import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recharge_snap/colors.dart';
import 'package:recharge_snap/cubit/scanner_cubit.dart';
import 'package:recharge_snap/generated/l10n.dart';
import 'package:recharge_snap/widgets/custom_app_bar.dart';
import 'package:recharge_snap/widgets/custom_app_bar_icon.dart';
import 'package:recharge_snap/widgets/show_toast.dart';
import 'package:toastification/toastification.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  static const routeName = '/scanner';

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late CameraController _cameraController;
  final _textRecognizer = TextRecognizer();
  bool _isCameraInitialized = false;
  bool _flashOn = false;
  String? _matchedNumber;
  bool _isProcessing = false;
  String _statusMessage = 'Align text within frame';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    // _initAlignText();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final camera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );

      _cameraController = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController.initialize();
      if (!mounted) return;

      setState(() => _isCameraInitialized = true);
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains('CameraAccessDenied') ||
          e.toString().contains('Camera access permission was denied')) {
        showToast(
          context: context,
          message: 'Camera Access Denied',
          toastType: ToastificationType.error,
        );
      } else {
        showToast(
          context: context,
          message: "Can't open camera",
          toastType: ToastificationType.error,
        );
      }
    }
  }

  Future<void> _toggleFlash() async {
    if (!_isCameraInitialized) return;

    setState(() => _flashOn = !_flashOn);
    await _cameraController.setFlashMode(
      _flashOn ? FlashMode.torch : FlashMode.off,
    );
  }

  Future<void> _captureAndRecognize() async {
    if (_isProcessing || !_isCameraInitialized) return;

    setState(() {
      _isProcessing = true;
      _statusMessage = S.of(context).processing;
    });

    try {
      final image = await _cameraController.takePicture();
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/scan_temp.jpg';
      final file = File(filePath);

      if (await file.exists()) await file.delete();
      await File(image.path).copy(filePath);

      final inputImage = InputImage.fromFilePath(filePath);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      await file.delete();
      await File(image.path).delete();

      _processText(recognizedText.text);
    } catch (e) {
      setState(() => _statusMessage = 'Error: Please try again');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  void _processText(String fullText) {
    final numberMatches = RegExp(
      r'\d{12,20}',
    ).allMatches(fullText.replaceAll(' ', ''));

    if (numberMatches.isNotEmpty) {
      final bestMatch = numberMatches.first.group(0);
      if (bestMatch != null) {
        setState(() => _matchedNumber = bestMatch);
        _showResultDialog(bestMatch);
      } else {
        setState(() => _statusMessage = S.of(context).noNumbersDetected);
      }
    } else {
      setState(() => _statusMessage = S.of(context).noNumbersDetected);
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
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            S.of(context).scanAgain,
                            style: TextStyle(color: Colors.black),
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
                          },
                          child: Text(S.of(context).confirm),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
    if (mounted) {
      setState(() {
        _matchedNumber = null;
        _statusMessage = S.of(context).alignTextWithinFrame;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_statusMessage == 'Align text within frame') {
      _statusMessage = S.of(context).alignTextWithinFrame;
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        // backgroundColor: Colors.black,
        appBar: CustomAppBar(
          title: S.of(context).scanCode,
          color: primaryColor,
          actions: [
            CustomAppBarIcon(
              icon: _flashOn ? Icons.flash_on : Icons.flash_off,
              color: Colors.white,
              tooltipText:
                  _flashOn ? S.of(context).flashOff : S.of(context).flashOn,
              onPressed: _toggleFlash,
            ),
          ],
          leading: CustomAppBarIcon(
            icon: FontAwesomeIcons.arrowLeft,
            color: Colors.white,
            tooltipText: S.of(context).back,
            onPressed: Navigator.of(context).pop,
          ),
        ),
        body: Stack(
          children: [
            if (_isCameraInitialized)
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  //   aspectRatio: _cameraController.value.aspectRatio,
                  child: CameraPreview(_cameraController),
                ),
              ),
            if (!_isCameraInitialized)
              const Center(child: CircularProgressIndicator()),
            // Scanner overlay
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _statusMessage,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            // Capture button
            Align(
              alignment: Alignment.bottomCenter,

              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [primaryColor, secondaryColor],
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 40),
                child: FloatingActionButton(
                  backgroundColor: Colors.black38,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: _captureAndRecognize,
                  child:
                      _isProcessing
                          ? const CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 3,
                          )
                          : const Icon(
                            FontAwesomeIcons.camera,
                            color: Colors.white,
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
