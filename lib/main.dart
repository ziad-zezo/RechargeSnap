import 'package:flutter/material.dart';

void main() {
  runApp(const RechargeSnap());
}

class RechargeSnap extends StatelessWidget {
  const RechargeSnap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recharge Snap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OnboardingPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnState();
}

class _OnState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(title: const Text('Recharge Snap'), centerTitle: true),
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
                Container(
                  height: size.height * 0.09,
                  width: size.width * 0.6,
                  // padding: const EdgeInsets.symmetric(
                  //   horizontal: 40,
                  //   vertical: 70,
                  // ),
                  margin: const EdgeInsets.symmetric(
                    // horizontal: 40,
                    vertical: 70,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 74, 48, 219),
                        Color.fromARGB(200, 250, 183, 59),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color.fromARGB(160, 50, 56, 173),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
