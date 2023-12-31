import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundpool/soundpool.dart';
import 'package:yeclock/const.dart';
import 'package:yeclock/screens/settings.dart';

class ExampleAlarmRingScreen extends StatefulWidget {
  final AlarmSettings alarmSettings;

  const ExampleAlarmRingScreen({Key? key, required this.alarmSettings})
      : super(key: key);

  @override
  State<ExampleAlarmRingScreen> createState() => _ExampleAlarmRingScreenState();
}

class _ExampleAlarmRingScreenState extends State<ExampleAlarmRingScreen> {
  @override
  Widget build(BuildContext context) {
    return AppTheme.mainFont.toString()=="Helvetica" ?
    Pablo(alarmSettings: widget.alarmSettings) :
    Graduation(alarmSettings: widget.alarmSettings,);
  }
}

class Graduation extends StatelessWidget {
  var alarmSettings;

  Graduation({super.key, required this.alarmSettings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.mainColor,
        body: Container(
          decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage("assets/gradBackground.jpg"),
            fit: BoxFit.fitHeight,
            ),
          ),
          child: Stack(
            children: [
              Padding(
    padding: const EdgeInsets.only(top: 70, right: 35),
    child: Align(
      alignment: Alignment.topRight,
      child: Text(
        "waKeUp",
        style: TextStyle(
          color: AppTheme.accentColor,
          fontFamily: AppTheme.mainFont,
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
      ),
    ),
  ),
              ButtonRow(a: alarmSettings),
            ],
          ),
        ));
  }
}

class Pablo extends StatelessWidget {
  var alarmSettings;

  Pablo({super.key, required this.alarmSettings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.mainColor,
        body: Stack(
          children: [
            Padding(
    padding: EdgeInsets.only(top: 120),
    child: Align(
      alignment: Alignment.topCenter,
      child: Text(
        "WAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\n",
        style: TextStyle(
          color: AppTheme.accentColorPablo,
          fontFamily: AppTheme.mainFont,
          fontWeight: FontWeight.bold,
          fontSize: 48,
        ),
      ),
    ),
  ),
            const Ye(),
            ButtonRow(a: alarmSettings),
          ],
        ));
  }
}

class Ye extends StatelessWidget {
  const Ye({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 225,
        child: Image(
          image: AssetImage("assets/kanye.png"),
        ),
      ),
    );
  }
}

// class WakeUp extends StatelessWidget {
  // const WakeUp({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   Padding wakeUpPablo = Padding(
  //   padding: const EdgeInsets.only(top: 120),
  //   child: Align(
  //     alignment: Alignment.topCenter,
  //     child: Text(
  //       "WAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\nWAKE UP\n",
  //       style: TextStyle(
  //         color: AppTheme.accentColorPablo,
  //         fontFamily: AppTheme.mainFont,
  //         fontWeight: FontWeight.bold,
  //         fontSize: 48,
  //       ),
  //     ),
  //   ),
  // );

  // Padding wakeUpGrad = Padding(
  //   padding: const EdgeInsets.only(top: 70, right: 35),
  //   child: Align(
  //     alignment: Alignment.topRight,
  //     child: Text(
  //       "waKeUp",
  //       style: TextStyle(
  //         color: AppTheme.accentColor,
  //         fontFamily: AppTheme.mainFont,
  //         fontWeight: FontWeight.bold,
  //         fontSize: 36,
  //       ),
  //     ),
  //   ),
  // );

    // return getTheme()==1 ? wakeUpGrad : wakeUpPablo;
  // }
// }

Future<int?> getTheme() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("Text:" + prefs.getInt("theme").toString());
  print(prefs.getInt("theme").toString()=="1");
  
  return prefs.getInt('theme');
}

class ButtonRow extends StatelessWidget {
  final AlarmSettings a;
  const ButtonRow({super.key, required this.a});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                color: AppTheme.mainColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: RawMaterialButton(
                    onPressed: () async {
                      final now = DateTime.now();
                      Alarm.set(
                        alarmSettings: a.copyWith(
                          dateTime: DateTime(
                            now.year,
                            now.month,
                            now.day,
                            now.hour,
                            now.minute,
                            0,
                            0,
                          ).add(const Duration(minutes: 5)), //snooze timer
                        ),
                      ).then((_) async {
                        Navigator.pop(context);
                        //snooze sound
                        Soundpool pool =
                            // ignore: deprecated_member_use
                            Soundpool(streamType: StreamType.notification);
                        int soundId = await rootBundle
                            .load("assets/snooze.mp3")
                            .then((ByteData soundData) {
                          return pool.load(soundData);
                        });
                        int streamId = await pool.play(soundId);
                      });
                    },
                    child: Text(
    "SNOOZE",
    style: TextStyle(
      color: AppTheme.accentColor,
      fontFamily: AppTheme.mainFont,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
  ),),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                color: AppTheme.mainColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: RawMaterialButton(
                    onPressed: () {
                      final now = DateTime.now();
                      Alarm.set(
                        alarmSettings: a.copyWith(
                          dateTime: DateTime(
                            now.year,
                            now.month,
                            now.day,
                            now.hour,
                            now.minute,
                            0,
                            0,
                          ).add(const Duration(days: 1)), //snooze timer
                        ),
                      ).then((_) => {Navigator.pop(context)});
                      // Alarm.stop(alarmSettings.id)
                      //     .then((_) => Navigator.pop(context));
                    },
                    child: Text(
    "STOP",
    style: TextStyle(
      color: AppTheme.accentColor,
      fontFamily: AppTheme.mainFont,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
  ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
