import 'package:flutter/material.dart';
import 'package:recharge_snap/screens/home_screen.dart';
import 'package:recharge_snap/services/onboarding_service.dart';
import 'package:recharge_snap/widgets/custom_onboarding_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static const routeName = '/onboarding';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
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
                    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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
