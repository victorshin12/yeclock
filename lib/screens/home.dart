import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeclock/const.dart';
import 'package:yeclock/screens/edit_alarm.dart';
import 'package:yeclock/screens/ring.dart';
import 'package:yeclock/screens/settings.dart';
import 'package:yeclock/widgets/tile.dart';
import 'package:flutter/material.dart';

class YeClock extends StatefulWidget {
  const YeClock({Key? key}) : super(key: key);

  @override
  State<YeClock> createState() => _YeClockState();
  
}

class _YeClockState extends State<YeClock> {


  late List<AlarmSettings> alarms;

  static StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
    // SettingsPage();
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ExampleAlarmRingScreen(alarmSettings: alarmSettings),
        ));
    loadAlarms();
  }

  Future<void> navigateToAlarmScreen(AlarmSettings? settings) async {
    final res = await showModalBottomSheet<bool?>(
        backgroundColor: AppTheme.mainColor,
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: ExampleAlarmEditScreen(alarmSettings: settings),
          );
        });

    if (res != null && res == true) loadAlarms();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YECLOCK", style: TextStyle(color: AppTheme.accentColor, fontFamily: AppTheme.mainFont, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.mainColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: AppTheme.mainColor,
        child: alarms.isNotEmpty
            ? Center(
                child: ExampleAlarmTile(
                key: Key(alarms[0].id.toString()),
                title: TimeOfDay(
                  hour: alarms[0].dateTime.hour,
                  minute: alarms[0].dateTime.minute,
                ).format(context),
                onPressed: () => navigateToAlarmScreen(alarms[0]),
              ))
            : Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: AppTheme.accentColor,
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      color: AppTheme.mainColor,
                      onPressed: () => navigateToAlarmScreen(null),
                    ),
                  ),
                ),
              ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                final alarmSettings = AlarmSettings(
                  id: 69,
                  dateTime: DateTime.now(),
                  assetAudioPath: 'assets/marimba.mp3',
                  volumeMax: false,
                );
                Alarm.set(alarmSettings: alarmSettings);
              },
              backgroundColor: Colors.red,
              heroTag: null,
              child: const Text("RING NOW", textAlign: TextAlign.center),
            ),
            // FloatingActionButton(
            //   onPressed: () => navigateToAlarmScreen(null),
            //   child: const Icon(Icons.alarm_add_rounded, size: 33),
            // ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
