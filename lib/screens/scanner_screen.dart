import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late CameraController _cameraController;
  bool _isDetecting = false;
  final textRecognizer = TextRecognizer();
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _cameraController = CameraController(
      camera,
      ResolutionPreset.high, // رفع الدقة لتحسين القراءة
      enableAudio: false,
    );

    await _cameraController.initialize();

    if (!mounted) return;

    setState(() {
      _isCameraInitialized = true;
    });

    _startImageStream();
  }

  void _startImageStream() {
    _cameraController.startImageStream((CameraImage image) async {
      if (_isDetecting) return;
      _isDetecting = true;

      try {
        final WriteBuffer allBytes = WriteBuffer();
        for (final Plane plane in image.planes) {
          allBytes.putUint8List(plane.bytes);
        }
        final bytes = allBytes.done().buffer.asUint8List();

        final rotation =
            InputImageRotationValue.fromRawValue(
              _cameraController.description.sensorOrientation,
            ) ??
            InputImageRotation.rotation0deg;

        final format =
            InputImageFormatValue.fromRawValue(image.format.raw) ??
            InputImageFormat.nv21;

        final inputImage = InputImage.fromBytes(
          bytes: bytes,
          metadata: InputImageMetadata(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: rotation,
            format: format,
            bytesPerRow: image.planes[0].bytesPerRow,
          ),
        );

        final recognizedText = await textRecognizer.processImage(inputImage);

        String fullText = recognizedText.text.replaceAll(RegExp(r'\s+'), '');

        final matchedNumber = RegExp(
          r'\d{12,16}',
        ).firstMatch(fullText)?.group(0);

        if (matchedNumber != null) {
          await _cameraController.stopImageStream();
          if (!mounted) return;
          Navigator.pop(context, matchedNumber);
          return;
        }
      } catch (e) {
        debugPrint("Error during text recognition: $e");
      } finally {
        _isDetecting = false;
      }
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Card')),
      body:
          _isCameraInitialized
              ? CameraPreview(_cameraController)
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
