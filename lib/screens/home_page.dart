import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recharge_snap/cubit/scanner_cubit.dart';
import 'package:recharge_snap/screens/scanner_screen.dart';
import 'package:recharge_snap/widgets/custom_action_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  final String? detectedNumber;
  const HomePage({super.key, this.detectedNumber});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cardCodeController = TextEditingController();
  String? _selectedProvider;
  String _scannedText = "Scan a card or enter manually";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recharge Snap",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings_sharp),
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

                  const SizedBox(height: 80),

                  // Scan Button
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
                            "SCAN CARD",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

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
                                if (state is NumberDetected) {
                                  _cardCodeController.text =
                                      state.detectedNumber;
                                }
                                return TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: _cardCodeController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter card number",
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    //alignLabelWithHint: true,
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
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 200),
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

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 15),
                      CustomActionButton(
                        icon: Icons.call,
                        label: "Call",
                        onPressed:
                            () => _makePhoneCall(_cardCodeController.text),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // *Submit Button
                  if (_cardCodeController.text.isNotEmpty &&
                      _selectedProvider != null)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle recharge submission
                          _showSuccessDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          "CONFIRM RECHARGE",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
}
