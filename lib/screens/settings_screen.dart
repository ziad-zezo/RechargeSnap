import 'package:flutter/material.dart';
import 'package:recharge_snap/build_dropdown_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SharedPreferences prefs;
  bool isPrefsReady = false;
  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),

        backgroundColor: const Color.fromARGB(29, 0, 0, 0),
        centerTitle: true,
        elevation: 1,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: size.height,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A2980), Color(0xFF26D0CE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
                                const Text(
                                  'Default Provider',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
                                        borderRadius: BorderRadius.circular(15),

                                        isExpanded: true,
                                        enableFeedback: true,

                                        value:
                                            prefs.getString(
                                              'defaultProvider',
                                            ) ??
                                            'etisalat',
                                        hint: const Text(
                                          'Select Provider',
                                          style: TextStyle(color: Colors.red),
                                        ),

                                        items: [
                                          DropdownMenuItemBuilder.buildDropdownItem(
                                            'Etisalat',
                                            'etisalat',
                                            'assets/logos/etisalat.png',
                                          ),
                                          DropdownMenuItemBuilder.buildDropdownItem(
                                            'Vodafone',
                                            'vodafone',
                                            'assets/logos/vodafone.png',
                                          ),
                                          DropdownMenuItemBuilder.buildDropdownItem(
                                            'We',
                                            'we',
                                            'assets/logos/we.png',
                                          ),
                                          DropdownMenuItemBuilder.buildDropdownItem(
                                            'Orange',
                                            'orange',
                                            'assets/logos/orange.png',
                                          ),
                                        ],
                                        onChanged: (value) {
                                          changeDefaultProvider(value);
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
    );
  }

  void changeDefaultProvider(value) async {
    isPrefsReady = false;
    setState(() {});
    await prefs.setString('defaultProvider', value!);
    //print("The value you want to save is $value");
    isPrefsReady = true;
    setState(() {});
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isPrefsReady = true;
    });
  }
}
