import 'package:flutter/material.dart';
import 'package:recharge_snap/services/onboarding_service.dart';
import 'package:recharge_snap/widgets/custom_onboarding_button.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomOnboardingButton(
                  onTap: () async {
                    await OnboardingService().setOnboardingCompleted();
                    if (!context.mounted) return;
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  height: size.height * 0.08,
                  width: size.width * 0.6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
