import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recharge_snap/cubit/scanner_cubit.dart';
import 'package:recharge_snap/screens/about_screen.dart';
import 'package:recharge_snap/screens/home_screen.dart';
import 'package:recharge_snap/screens/onboarding_screen.dart';
import 'package:recharge_snap/screens/scanner_screen.dart';
import 'package:recharge_snap/services/onboarding_service.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final onboardingService = OnboardingService();
  final isOnboardingCompleted = await onboardingService.isOnboardingCompleted();

  cameras = await availableCameras();
  debugPrint("cameras $cameras");

  runApp(RechargeSnap(onboardingCompleted: isOnboardingCompleted));
}

class RechargeSnap extends StatelessWidget {
  const RechargeSnap({super.key, required this.onboardingCompleted});
  final bool onboardingCompleted;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScannerCubit(),
      child: MaterialApp(
        title: 'Recharge Snap',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          '/home': (context) => HomeScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/scannerScreen': (context) => const ScannerScreen(),
          '/aboutScreen': (context) => const AboutScreen(),
        },
        initialRoute:
            onboardingCompleted
                ? HomeScreen.routeName
                : OnboardingScreen.routeName,
      ),
    );
  }
}
