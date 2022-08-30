import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> _languages = ['AR', 'EN', 'TR'];
  String? _selectedLanguage;
  bool _darkMode = false;
  bool _notifications = false;

  @override
  void initState() {
    super.initState();
    getSelectedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.purple,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                margin: const EdgeInsets.all(8.0),
                color: Colors.purple,
                child: ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 33,
                  ),
                  title: Text(
                    'Settings',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.language,
                      color: Colors.purple,
                    ),
                    title: const Text(
                      'Change Language',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: DropdownButton(
                      hint: const Text('Language'),
                      value: _selectedLanguage,
                      onChanged: (newValue) async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setString(
                          'language',
                          newValue.toString(),
                        );
                        setState(() {
                          _selectedLanguage = newValue as String?;
                        });
                      },
                      items: _languages.map((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                        );
                      }).toList(),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.brush,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Dark Mode',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Switch(
                      activeColor: Colors.teal,
                      value: _darkMode,
                      onChanged: (val) async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setBool(
                          'darkMode',
                          val,
                        );
                        setState(() {
                          _darkMode = val;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.bell,
                      color: Colors.red,
                    ),
                    title: const Text(
                      'Recive Notifications',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Switch(
                      activeColor: Colors.teal,
                      value: _notifications,
                      onChanged: (val) async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setBool(
                          'notifications',
                          val,
                        );
                        setState(() {
                          _notifications = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Functions:
  getSelectedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = preferences.getString('language');
      _darkMode = preferences.getBool('darkMode')!;
      _notifications = preferences.getBool('notifications')!;
    });
  }
}
