import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package
import 'package:yeclock/const.dart';
import 'package:yeclock/const.dart';
import 'package:yeclock/main.dart';
import 'package:restart_app/restart_app.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isGraduation = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference(); // Load the saved theme preference when the page is initialized.
  }

  _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isGraduation = prefs.getInt('theme') == 0;
    });
  }

  _saveThemePreference(int themeValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('theme', themeValue);
    print("saved As " + isGraduation.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SETTINGS',
            style: TextStyle(
                fontFamily: AppTheme.mainFont, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: AppTheme.accentColor,
            fontSize: 24,
            fontFamily: AppTheme.mainFont),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0), // Add left padding
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            color: AppTheme.accentColor,
            iconSize: 28,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      backgroundColor: AppTheme.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("THEME",
                    style: TextStyle(
                        color: AppTheme.accentColor,
                        fontSize: 24,
                        fontFamily: AppTheme.mainFont,
                        fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "LIFE OF PABLO",
                      style: TextStyle(
                        color: AppTheme.accentColor,
                        fontSize: 18,
                        fontFamily: AppTheme.mainFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: isGraduation,
                      onChanged: (value) {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Theme Change'),
                                  content:
                                      const Text('To ensure complete theme change, please revisit the settings page, then create a new alarm.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                        setState(() {
                          isGraduation = value;
                        });
                        _saveThemePreference(value
                            ? 0
                            : 1); // Save the selected theme preference.
                        changeTheme();
                        print(value);
                      },
                      thumbColor: MaterialStateProperty.all<Color>(
                          AppTheme.accentColor),
                      activeTrackColor: Colors.black.withOpacity(0.35),
                    ),
                    Text(
                      "GRADUATION",
                      style: TextStyle(
                        color: AppTheme.accentColor,
                        fontSize: 18,
                        fontFamily: AppTheme.mainFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // ElevatedButton(
                //   style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all<Color>(
                //           AppTheme.accentColor)),
                //   onPressed: () {
                //     RestartWidget.restartApp(context);
                //     // print("hello");
                //   },
                //   child: Text(
                //     "RESTART APP",
                //     style: TextStyle(
                //       color: AppTheme.mainColor,
                //       fontSize: 18,
                //       fontFamily: AppTheme.mainFont,
                //     ),
                //   ),
                // ),
              ],
            ),
            Column(
              children: [
                Text(
                  "CONTACT",
                  style: TextStyle(
                      color: AppTheme.accentColor,
                      fontSize: 24,
                      fontFamily: AppTheme.mainFont,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "yeclock@gmail.com",
                  style: TextStyle(
                    color: AppTheme.accentColor,
                    fontSize: 18,
                    fontFamily: AppTheme.mainFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center the contents horizontally
                    children: [
                      FaIcon(FontAwesomeIcons.instagram,
                          color: AppTheme.accentColor),
                      Text(
                        " yeclock",
                        style: TextStyle(
                          color: AppTheme.accentColor,
                          fontSize: 18,
                          fontFamily: AppTheme.mainFont,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "FEEDBACK",
                  style: TextStyle(
                      color: AppTheme.accentColor,
                      fontSize: 24,
                      fontFamily: AppTheme.mainFont,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppTheme.accentColor)),
                  onPressed: () async {
                    final Uri _url = Uri.parse('https://forms.gle/P4RUpYMFPTYKc5oY7');
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch feedback form.');
                    }
                  },
                  child: Text(
                    "FORM",
                    style: TextStyle(
                      color: AppTheme.mainColor,
                      fontSize: 18,
                      fontFamily: AppTheme.mainFont,
                    ),
                  ),
                ),
              ],
            ),
            AppTheme(),
          ],
        ),
      ),
    );
  }
}

// TextStyle titleFont = TextStyle(
//     color: AppTheme.accentColor,
//     fontSize: 24,
//     fontFamily: AppTheme.mainFont,
//     fontWeight: FontWeight.bold);

// TextStyle subFont = TextStyle(
//   color: AppTheme.accentColor,
//   fontSize: 18,
//   fontFamily: AppTheme.mainFont,
//   fontWeight: FontWeight.bold,
// );

void changeTheme() {}

////////
////////

class AppTheme extends StatefulWidget {
  const AppTheme({super.key});

  ////////////
  static Color mainColor = mainColorPablo;
  static Color accentColor = accentColorPablo;

  static Color mainColorPablo = const Color(0xfff58b57);
  static Color accentColorPablo = const Color(0xff000000);
  static Color mainColorGraduation = const Color(0xff81307b);
  static Color accentColorGraduation = const Color(0xffed008d);

/////////////
  static String mainFont = fontPablo;

  static String fontPablo = "Helvetica";
  static String fontGraduation = "Compacta";

/////////////
  // static Padding wakeupTemplate = wakeUpGrad;

  // static Padding wakeUpPablo = Padding(
  //   padding: const EdgeInsets.only(top: 120),
  //   child: Align(
  //     alignment: Alignment.topCenter,
  //     child: Text(
  //       "WAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\n",
  //       style: TextStyle(
  //         color: accentColorPablo,
  //         fontFamily: mainFont,
  //         fontWeight: FontWeight.bold,
  //         fontSize: 48,
  //       ),
  //     ),
  //   ),
  // );

  // static Padding wakeUpGrad = Padding(
  //   padding: const EdgeInsets.only(top: 70, right: 35),
  //   child: Align(
  //     alignment: Alignment.topRight,
  //     child: Text(
  //       "waKeUp",
  //       style: TextStyle(
  //         color: accentColor,
  //         fontFamily: mainFont,
  //         fontWeight: FontWeight.bold,
  //         fontSize: 36,
  //       ),
  //     ),
  //   ),
  // );

  // static Text snoozePablo = Text(
  //   "SNOOZE",
  //   style: TextStyle(
  //     color: accentColor,
  //     fontFamily: mainFont,
  //     fontWeight: FontWeight.bold,
  //     fontSize: 24,
  //   ),
  // );

  // static Text stopPablo = Text(
  //   "STOP",
  //   style: TextStyle(
  //     color: accentColor,
  //     fontFamily: mainFont,
  //     fontWeight: FontWeight.bold,
  //     fontSize: 24,
  //   ),
  // );

  // static Text editCancelPablo = Text(
  //   "CANCEL",
  //   style: TextStyle(
  //     fontSize: 20,
  //     color: accentColor,
  //     fontFamily: mainFont,
  //     fontWeight: FontWeight.bold,
  //   ),
  // );

  // static Text editSavePablo = Text(
  //   "SAVE",
  //   style: TextStyle(
  //     fontSize: 20,
  //     color: accentColor,
  //     fontFamily: mainFont,
  //     fontWeight: FontWeight.bold,
  //   ),
  // );

  // static TextStyle todayTomorrow = TextStyle(
  //   fontFamily: mainFont,
  //   fontWeight: FontWeight.bold,
  //   fontSize: 16,
  //   color: accentColor,
  // );

  // static TextStyle unselectedSpinnerPablo = TextStyle(
  //   fontFamily: mainFont,
  //   fontWeight: FontWeight.bold,
  //   fontSize: 24,
  //   color: accentColor.withOpacity(0.5),
  // );

  // static TextStyle selectedSpinnerPablo = TextStyle(
  //   fontFamily: mainFont,
  //   fontWeight: FontWeight.bold,
  //   fontSize: 24,
  //   color: accentColor,
  // );

  // static TextStyle optionsPablo = TextStyle(
  //   fontFamily: mainFont,
  //   fontWeight: FontWeight.bold,
  //   fontSize: 16,
  //   color: accentColor,
  // );

  @override
  State<AppTheme> createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  int themeValue = 1; // Default theme value, change as needed

  @override
  void initState() {
    super.initState();
    loadThemePreference();
  }

  loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      themeValue =
          prefs.getInt('theme') ?? 1; // Default to 1 if 'theme' doesn't exist
    });

    // Update the mainColor based on the themeValue
    if (themeValue == 1) {
      AppTheme.mainColor = AppTheme.mainColorPablo;
      AppTheme.accentColor = AppTheme.accentColorPablo;
      AppTheme.mainFont = AppTheme.fontPablo;
    } else {
      AppTheme.mainColor = AppTheme.mainColorGraduation;
      AppTheme.accentColor = AppTheme.accentColorGraduation;
      AppTheme.mainFont = AppTheme.fontGraduation;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
