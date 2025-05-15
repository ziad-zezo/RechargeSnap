import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recharge_snap/screens/scanner_screen.dart';
import 'package:recharge_snap/widgets/shortcut_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cardCodeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final List<DropdownMenuEntry> dropDownItems = [
      DropdownMenuEntry(
        label: ("Etisalat"),
        value: "etisalat",
        leadingIcon: Image.asset("assets/images/etisalat.png"),
      ),
      DropdownMenuEntry(label: ("Option 2"), value: "option2"),
    ];
    dropdownMenuEntries.addAll(dropDownItems);
  }

  List<DropdownMenuEntry> dropdownMenuEntries = [];

  String text = "initial";
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Recharge Snap"), centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff5e4bd5), Color(0xffe6e6e6)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownMenu(
                width: size.width * 0.8,
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                    label: ("Etisalat"),
                    value: "etisalat",
                    leadingIcon: SizedBox(
                      width: size.width * 0.08,
                      height: size.height * 0.08,
                      child: Image.asset("assets/logos/etisalat.png"),
                    ),
                  ),
                  DropdownMenuEntry(
                    label: ("Vodafone"),
                    value: "vodafone",
                    leadingIcon: SizedBox(
                      width: size.width * 0.08,
                      height: size.height * 0.08,
                      child: Image.asset("assets/logos/vodafone.png"),
                    ),
                  ),
                  DropdownMenuEntry(
                    label: ("We"),
                    value: "we",
                    leadingIcon: SizedBox(
                      width: size.width * 0.08,
                      height: size.height * 0.08,
                      child: Image.asset("assets/logos/we.png"),
                    ),
                  ),
                  DropdownMenuEntry(
                    label: ("Orange"),
                    value: "orange",
                    leadingIcon: SizedBox(
                      width: size.width * 0.08,
                      height: size.height * 0.08,
                      child: Image.asset("assets/logos/orange.png"),
                    ),
                  ),
                ],
              ),
              Text(text),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CameraScreen()),
                  );
                  print("The vlue is ${result.toString()}");
                  setState(() {
                    text = result.toString();
                    _cardCodeController.text = text;
                  });
                },
                child: Text("Scan"),
              ),
              //text field
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 8.0,
                ),
                child: TextField(
                  controller: _cardCodeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShortcutIcon(
                    onPressed: () {
                      _copyToClipboard(text);
                    },
                    icon: Icon(Icons.copy),
                  ),
                  SizedBox(width: 10),
                  ShortcutIcon(
                    onPressed: () async {
                      final Uri phoneUri = Uri(scheme: 'tel', path: text);
                      print("phone uri  ${phoneUri.toString()}");
                      try {
                        if (await canLaunchUrl(phoneUri)) {
                          await launchUrl(phoneUri);
                        } else {
                          throw 'Could not launch phone app';
                        }
                      } catch (e) {
                        debugPrint('Error launching phone app: $e');
                      }
                    },
                    icon: Icon(Icons.call_end_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _copyToClipboard(textToCopy) async {
    await Clipboard.setData(ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Copied to clipboard: $textToCopy')));
  }
}

class DropdownItem {
  String label;
  String value;
  Widget leadingIcon;
  DropdownItem({
    required this.label,
    required this.value,
    required this.leadingIcon,
  });
}
