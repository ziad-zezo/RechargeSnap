import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recharge_snap/cubit/scanner_cubit.dart';
import 'package:recharge_snap/screens/scanner_screen.dart';
import 'package:recharge_snap/widgets/custom_action_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  final String? detectedNumber;
  const HomeScreen({super.key, this.detectedNumber});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cardCodeController = TextEditingController();
  String? _selectedProvider;
  String _scannedText = "Scan a card or enter manually";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recharge Snap",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => Navigator.pushNamed(context, '/aboutScreen'),
            icon: Icon(Icons.info_outlined),
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings_outlined),
              color: Colors.black,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 50),
                  // Provider Selection Card
                  Row(
                    children: [
                      //!DropDownMenu
                      Expanded(
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(15),

                                isExpanded: true,
                                enableFeedback: true,
                                underline: Text("Zia ddd"),
                                value: _selectedProvider,
                                hint: Text(
                                  "Select Provider",
                                  style: TextStyle(color: Colors.red),
                                ),

                                items: [
                                  _buildDropdownItem(
                                    "Etisalat",
                                    "etisalat",
                                    "assets/logos/etisalat.png",
                                  ),
                                  _buildDropdownItem(
                                    "Vodafone",
                                    "vodafone",
                                    "assets/logos/vodafone.png",
                                  ),
                                  _buildDropdownItem(
                                    "We",
                                    "we",
                                    "assets/logos/we.png",
                                  ),
                                  _buildDropdownItem(
                                    "Orange",
                                    "orange",
                                    "assets/logos/orange.png",
                                  ),
                                ],
                                onChanged:
                                    (value) => setState(
                                      () => _selectedProvider = value,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //*DropDownMenu
                      //!
                      //*Scan Button
                      SizedBox(
                        width: 130,
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ScannerScreen(),
                              ),
                            );
                            if (result != null) {
                              setState(() {
                                _scannedText = result.toString();
                                _cardCodeController.text = _scannedText;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 4,
                            ),
                            elevation: 3,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.qr_code_scanner, size: 24),
                              const SizedBox(width: 10),
                              Text(
                                "SCAN",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Scan Button
                  const SizedBox(height: 30),

                  // Card Number Input
                  Text(
                    "OR ENTER MANUALLY",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 15),
                  Row(
                    children: [
                      //*TextField
                      Expanded(
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
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
                            child: BlocBuilder<ScannerCubit, ScannerState>(
                              builder: (context, state) {
                                return TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: _cardCodeController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter card number",
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),

                                    suffixIcon:
                                        _cardCodeController.text.isNotEmpty
                                            ? IconButton(
                                              icon: Icon(
                                                Icons.clear,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                _cardCodeController.clear();
                                                setState(() {});
                                              },
                                            )
                                            : null,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onChanged: (value) => setState(() {}),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      //*TextField
                      //!Copy Icon
                      AnimatedContainer(
                        curve: Curves.easeInToLinear,
                        duration: Duration(milliseconds: 300),
                        width: _cardCodeController.text.isNotEmpty ? 50 : 0,
                        child: ClipRRect(
                          child: CustomActionButton(
                            icon: Icons.copy,
                            label: "Copy",
                            color: Colors.white,
                            iconSize: 18,
                            fontSize: 13,
                            onPressed:
                                () =>
                                    _copyToClipboard(_cardCodeController.text),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const SizedBox(height: 30),

                  // *Recharge Button
                  AnimatedContainer(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeOutSine,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    width:
                        isValidNumber() ? size.width * 0.5 : size.width * 0.14,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isValidNumber() ? Colors.black : Colors.black38,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(
                        isValidNumber() ? 12 : 45,
                      ),
                      // shape: BoxShape.circle,
                      gradient:
                          isValidNumber()
                              ? LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 25, 131, 26),
                                  Color.fromARGB(255, 11, 245, 15),
                                  //Color.fromARGB(241, 2, 125, 150),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                              : LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 71, 66, 97),
                                  Color.fromARGB(255, 42, 44, 44),
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                    ),

                    child: Center(
                      child: Row(
                        mainAxisAlignment:
                            isValidNumber()
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.center,
                        children: [
                          //*Icon
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Icon(
                              FontAwesomeIcons.phone,
                              color: Colors.white,
                              size: isValidNumber() ? 30 : 30,
                              //size: 28,
                            ),
                          ),

                          //*Text
                          Flexible(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 600),

                              curve: Curves.easeInOutCirc,
                              width: isValidNumber() ? size.width * 0.3 : 0,
                              child: Expanded(
                                child: Text(
                                  "Recharge Now",
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  DropdownMenuItem<String> _buildDropdownItem(
    String label,
    String value,
    String iconPath,
  ) {
    return DropdownMenuItem(
      //alignment: Alignment.centerRight,
      value: value,
      child: Row(
        children: [
          Image.asset(iconPath, width: 30, height: 30),
          const SizedBox(width: 15),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Future<void> _copyToClipboard(String text) async {
    if (text.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: text));

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard'),
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not launch phone app')));
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
            title: Icon(Icons.check_circle, color: Colors.green, size: 60),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Recharge Successful!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "Your $_selectedProvider card has been recharged successfully",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              Center(
                child: TextButton(
                  child: Text(
                    "DONE",
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
    return _cardCodeController.text.length > 5 && _selectedProvider != null;
  }
}
