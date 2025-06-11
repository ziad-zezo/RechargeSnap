import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recharge_snap/build_dropdown_item.dart';
import 'package:recharge_snap/cubit/scanner_cubit.dart';
import 'package:recharge_snap/screens/about_screen.dart';
import 'package:recharge_snap/screens/settings_screen.dart';
import 'package:recharge_snap/widgets/custom_action_button.dart';
import 'package:recharge_snap/widgets/custom_app_bar_icon.dart';
import 'package:recharge_snap/widgets/scan_code_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.detectedNumber});
  static const routeName = '/home';
  final String? detectedNumber;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cardCodeController = TextEditingController();
  String? _selectedProvider;
  final FocusNode _focusNode = FocusNode();
  late final SharedPreferences prefs;
  bool isPrefsReady = false;
  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  void dispose() {
    _cardCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Recharge Snap',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: const Color.fromARGB(29, 0, 0, 0),
        leading: CustomAppBarIcon(
          tooltipText: 'About',
          route: AboutScreen.routeName,
          icon: Icons.info_outlined,
          onPressed:
              () => Navigator.of(context).pushNamed(AboutScreen.routeName),
        ),
        actions: [
          CustomAppBarIcon(
            tooltipText: 'Settings',
            route: SettingsScreen.routeName,
            icon: Icons.settings_outlined,

            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName).then((
                _,
              ) {
                setState(() {});
              });
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A2980), Color(0xFF26D0CE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 20),
                        // Provider Selection Card
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(60, 255, 255, 255),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              //!DropDownMenu
                              Expanded(
                                child: Card(
                                  margin: const EdgeInsets.all(0),
                                  color: Colors.white,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      color: Colors.black,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 4,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        borderRadius: BorderRadius.circular(15),

                                        isExpanded: true,
                                        enableFeedback: true,

                                        value:
                                            isPrefsReady
                                                ? prefs.getString(
                                                  'defaultProvider',
                                                )
                                                : _selectedProvider,
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
                                        onChanged:
                                            (value) => setState(() {
                                              isPrefsReady = false;
                                              _selectedProvider = value;
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //*DropDownMenu
                              const SizedBox(width: 8),
                              //*scan Button
                              const ScanCodeSlider(),
                            ],
                          ),
                        ),

                        // Scan Button
                        const SizedBox(height: 30),
                        const Divider(color: Colors.white70, thickness: 1),
                        const SizedBox(height: 20),

                        // Card Number Input
                        const Text(
                          'OR ENTER MANUALLY',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            letterSpacing: 1.2,
                          ),
                        ),

                        const SizedBox(height: 25),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(40, 255, 255, 255),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black, width: 0.5),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  //*TextField
                                  Expanded(
                                    child: Container(
                                      height: 55,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                        ),
                                        child: BlocListener<
                                          ScannerCubit,
                                          ScannerState
                                        >(
                                          listener: (context, state) {
                                            if (state is NumberDetected) {
                                              _cardCodeController.text =
                                                  state.detectedNumber;
                                              _focusNode.unfocus();
                                              setState(() {});
                                            }
                                          },
                                          child: BlocBuilder<
                                            ScannerCubit,
                                            ScannerState
                                          >(
                                            builder: (context, state) {
                                              return TextField(
                                                autofocus: false,
                                                focusNode: _focusNode,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                controller: _cardCodeController,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Enter card number',
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                      ),

                                                  suffixIcon:
                                                      _cardCodeController
                                                              .text
                                                              .isNotEmpty
                                                          ? IconButton(
                                                            icon: const Icon(
                                                              Icons.clear,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            onPressed: () {
                                                              _cardCodeController
                                                                  .clear();
                                                              setState(() {});
                                                            },
                                                          )
                                                          : null,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                onChanged:
                                                    (value) => setState(() {
                                                      _cardCodeController.text =
                                                          value;
                                                    }),
                                                onTapOutside: (_) {
                                                  // FocusScope.of(context).unfocus();
                                                  _focusNode.unfocus();
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //*TextField
                                  //!Copy Icon
                                  AnimatedContainer(
                                    curve: Curves.easeInToLinear,
                                    duration: const Duration(milliseconds: 300),
                                    width:
                                        _cardCodeController.text.isNotEmpty
                                            ? 50
                                            : 0,
                                    child: ClipRRect(
                                      child: CustomActionButton(
                                        icon: Icons.copy,
                                        label: 'Copy',
                                        color: Colors.white,
                                        iconSize: 18,
                                        fontSize: 13,
                                        onPressed:
                                            () => _copyToClipboard(
                                              _cardCodeController.text,
                                            ),
                                      ),
                                    ),
                                  ),
                                  //SizedBox(width: 40, height: 50),
                                ],
                              ),
                              //!recharge button
                              const SizedBox(height: 30),

                              //  const SizedBox(height: 30),

                              // *Recharge Button
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeOutSine,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14.0,
                                ),
                                width:
                                    isValidNumber()
                                        ? size.width * 0.5
                                        : size.width * 0.14,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        isValidNumber()
                                            ? Colors.black
                                            : Colors.black38,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    isValidNumber() ? 12 : 45,
                                  ),
                                  gradient:
                                      isValidNumber()
                                          ? const LinearGradient(
                                            colors: [
                                              Color.fromARGB(255, 25, 131, 26),
                                              Color.fromARGB(255, 11, 245, 15),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          )
                                          : const LinearGradient(
                                            colors: [
                                              Color.fromARGB(255, 71, 66, 97),
                                              Color.fromARGB(255, 42, 44, 44),
                                            ],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                          ),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                            ),
                                            child: Icon(
                                              FontAwesomeIcons.phone,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                          AnimatedSwitcher(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            transitionBuilder: (
                                              child,
                                              animation,
                                            ) {
                                              return SizeTransition(
                                                sizeFactor: animation,
                                                axis: Axis.horizontal,
                                                child: child,
                                              );
                                            },
                                            child:
                                                isValidNumber()
                                                    ? const Text(
                                                      'Recharge Now',
                                                      key: ValueKey(
                                                        'recharge-text',
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                    : const SizedBox(width: 0),
                                          ),
                                        ],
                                      ),
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
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _copyToClipboard(String text) async {
    if (text.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: text));

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Copied to clipboard'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Future<void> _makePhoneCall(String number) async {
    if (number.isEmpty) return;
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch phone app')),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 60,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Recharge Successful!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Your $_selectedProvider card has been recharged successfully',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              Center(
                child: TextButton(
                  child: const Text(
                    'DONE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
    );
  }

  bool isValidNumber() {
    return _cardCodeController.text.length > 10;
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isPrefsReady = true;
    });
  }
}
