import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:recharge_snap/cubit/scanner_cubit.dart';
import 'package:recharge_snap/generated/l10n.dart';
import 'package:recharge_snap/locale_helper.dart';
import 'package:recharge_snap/screens/about_screen.dart';
import 'package:recharge_snap/screens/home_screen.dart';
import 'package:recharge_snap/screens/scanner_screen.dart';
import 'package:recharge_snap/screens/settings_screen.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  final Locale? locale = await LocaleHelper.loadLocale();

  runApp(RechargeSnap(locale: locale));
}

class RechargeSnap extends StatelessWidget {
  const RechargeSnap({super.key, required this.locale});

  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScannerCubit(),
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        builder: (context, child) {
          final locale = Localizations.localeOf(context);
          return Directionality(
            textDirection:
                locale.languageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
            child: child!,
          );
        },

        title: 'Recharge Snap',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          ScannerScreen.routeName: (context) => const ScannerScreen(),
          AboutScreen.routeName: (context) => const AboutScreen(),
          SettingsScreen.routeName: (context) => const SettingsScreen(),
        },
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
