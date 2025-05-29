part of 'scanner_cubit.dart';

@immutable
abstract class ScannerState {}

class ScannerInitial extends ScannerState {}

class NumberDetected extends ScannerState {
  final String detectedNumber;
  NumberDetected({required this.detectedNumber});
}
