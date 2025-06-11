import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  ScannerCubit() : super(ScannerInitial());

  void doneScan(String detectedNumber) =>
      emit(NumberDetected(detectedNumber: detectedNumber));
}
