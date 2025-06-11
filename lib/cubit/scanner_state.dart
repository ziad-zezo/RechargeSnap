part of 'scanner_cubit.dart';

@immutable
abstract class ScannerState {}

class ScannerInitial extends ScannerState {}

class NumberDetected extends ScannerState {
  NumberDetected({required this.detectedNumber});
  final String detectedNumber;
}
