import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recharge_snap/build_dropdown_item.dart';
import 'package:recharge_snap/colors.dart';
import 'package:recharge_snap/generated/l10n.dart';
import 'package:recharge_snap/helper/settings_helper.dart';
import 'package:recharge_snap/locale_helper.dart';
import 'package:recharge_snap/providers.dart';
import 'package:recharge_snap/widgets/custom_app_bar.dart';
import 'package:recharge_snap/widgets/custom_app_bar_icon.dart';
import 'package:recharge_snap/widgets/show_toast.dart';
import 'package:restart_app/restart_app.dart';
import 'package:toastification/toastification.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String defaultProvider = etisalat;
  bool isPrefsReady = false;
  bool _isToastActive = false;
  Locale? currentLocale;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    //ar_EG
    final String languageCode = PlatformDispatcher.instance.locale.languageCode;
    final Locale locale = Locale(languageCode.contains('ar') ? 'ar' : 'en');
    defaultProvider = await SettingsHelper.getDefaultProvider() ?? etisalat;

    currentLocale = await LocaleHelper.loadLocale() ?? locale;
    setState(() => isPrefsReady = true);
  }

  Future<void> changeDefaultProvider(String? value) async {
    if (value == null) return;
    setState(() => isPrefsReady = false);
    await SettingsHelper.setDefaultProvider(value);
    setState(() {
      defaultProvider = value;
      isPrefsReady = true;
    });
    if (!mounted) return;
    if (_isToastActive) return;
    _isToastActive = true;
    showToast(
      context: context,
      message: S.of(context).providerSetSuccess(defaultProvider),
      toastType: ToastificationType.success,
    );
    Future.delayed(const Duration(milliseconds: 1300), () {
      _isToastActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: CustomAppBar(
          title: S.of(context).settings,
          leading: CustomAppBarIcon(
            tooltipText: S.of(context).back,
            icon: FontAwesomeIcons.arrowLeft,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: beginAlignment,
              end: endAlignment,
            ),
          ),
          child: SafeArea(
            child:
                !isPrefsReady
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(40, 255, 255, 255),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      S.of(context).defaultProvider,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 4,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          isExpanded: true,
                                          value: defaultProvider,
                                          items: [
                                            DropdownMenuItemBuilder.buildDropdownItem(
                                              S.of(context).etisalat,
                                              etisalat,
                                              'assets/logos/etisalat.png',
                                            ),
                                            DropdownMenuItemBuilder.buildDropdownItem(
                                              S.of(context).vodafone,
                                              vodafone,
                                              'assets/logos/vodafone.png',
                                            ),
                                            DropdownMenuItemBuilder.buildDropdownItem(
                                              S.of(context).we,
                                              we,
                                              'assets/logos/we.png',
                                            ),
                                            DropdownMenuItemBuilder.buildDropdownItem(
                                              S.of(context).orange,
                                              orange,
                                              'assets/logos/orange.png',
                                            ),
                                          ],
                                          onChanged: changeDefaultProvider,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(40, 255, 255, 255),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      S.of(context).language,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 4,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<Locale>(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          isExpanded: true,
                                          value: currentLocale,
                                          items: const [
                                            DropdownMenuItem(
                                              value: Locale('en'),
                                              child: Text('English'),
                                            ),
                                            DropdownMenuItem(
                                              value: Locale('ar'),
                                              child: Text('العربية'),
                                            ),
                                          ],

                                          onChanged: (value) async {
                                            if (currentLocale == value) return;
                                            currentLocale = value;
                                            await LocaleHelper.saveLocale(
                                              value!,
                                            );

                                            _restartApp();

                                            // setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
          ),
        ),
      ),
    );
  }

  void _restartApp() async {
    await Restart.restartApp();
    //RestartWidget.restartApp(context);
  }
}
