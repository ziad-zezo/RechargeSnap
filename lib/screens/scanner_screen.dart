import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:recharge_snap/cubit/scanner_cubit.dart';
import 'package:recharge_snap/widgets/custom_elevated_button.dart';

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
  String? _matchedNumber; // Store the matched number

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
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _cameraController.initialize();
      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
      });

      _startImageStream();
    } catch (e) {
      //if camera permission denied
      if (!mounted) return;

      if (e.toString().contains("CameraAccessDenied")) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Camera Access Denied")));
      }
      Navigator.pop(context);
    }
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
            InputImageRotation.rotation90deg;

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

        if (matchedNumber != null && matchedNumber != _matchedNumber) {
          _matchedNumber = matchedNumber;
          await _cameraController.stopImageStream();

          if (!mounted) return;

          // Remove the SnackBar as we're using a dialog now
          await _showResultDialog(matchedNumber);
          _startImageStream();
        }
      } catch (e) {
        debugPrint("Error during text recognition: $e");
      } finally {
        _isDetecting = false;
      }
    });
  }

  Future<void> _showResultDialog(String matchedNumber) async {
    if (!mounted) return;
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            backgroundColor: Colors.white,
            icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
            title: const Text(
              'Number Detected!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  matchedNumber,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Please verify the number before proceeding',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              CustomElevatedButton(
                color: Colors.orange,
                icon: const Icon(Icons.refresh, size: 20),
                label: "Retry",
                onPressed: () {
                  Navigator.pop(context);
                  _matchedNumber = null;
                },
              ),
              CustomElevatedButton(
                color: Colors.green,
                icon: const Icon(Icons.check, size: 20),
                label: "Done",
                onPressed: () {
                  context.read<ScannerCubit>().doneScan(matchedNumber);
                  try {
                    print("Done from Scanner Screen ${matchedNumber}");
                  } catch (e) {
                    print("done frome ex");
                  }

                  print("not try done from");
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
    );
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
      appBar: AppBar(
        title: const Text('Scan Card'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 74, 48, 219),
              Color.fromARGB(150, 250, 183, 59),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child:
            _isCameraInitialized
                ? Center(
                  child: Container(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CameraPreview(_cameraController),
                    ),
                  ),
                )
                : const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
      ),
    );
  }
}
