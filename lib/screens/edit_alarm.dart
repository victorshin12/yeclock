// ignore_for_file: prefer_const_constructors

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeclock/const.dart';
import 'package:yeclock/screens/settings.dart';

class ExampleAlarmEditScreen extends StatefulWidget {
  final AlarmSettings? alarmSettings;

  const ExampleAlarmEditScreen({Key? key, this.alarmSettings})
      : super(key: key);

  @override
  State<ExampleAlarmEditScreen> createState() => _ExampleAlarmEditScreenState();
}

class _ExampleAlarmEditScreenState extends State<ExampleAlarmEditScreen> {
  bool loading = false;

  late bool creating;
  late TimeOfDay selectedTime;
  late bool loopAudio;
  late bool vibrate;
  late bool volumeMax;
  late bool showNotification;
  late String assetAudio;
  late DateTime dateTimeFormat;

  bool isToday() {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
      0,
      0,
    );

    return now.isBefore(dateTime);
  }

  @override
  void initState() {
    super.initState();
    creating = widget.alarmSettings == null;

    if (creating) {
      final dt = DateTime.now().add(const Duration(minutes: 1));
      selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
      dateTimeFormat = dt;
      loopAudio = true;
      vibrate = true;
      volumeMax = true;
      showNotification = true;
      assetAudio = 'assets/goodmorning.mp3';
    } else {
      selectedTime = TimeOfDay(
        hour: widget.alarmSettings!.dateTime.hour,
        minute: widget.alarmSettings!.dateTime.minute,
      );
      dateTimeFormat = widget.alarmSettings!.dateTime;
      loopAudio = widget.alarmSettings!.loopAudio;
      vibrate = widget.alarmSettings!.vibrate;
      volumeMax = widget.alarmSettings!.volumeMax;
      showNotification = widget.alarmSettings!.notificationTitle != null &&
          widget.alarmSettings!.notificationTitle!.isNotEmpty &&
          widget.alarmSettings!.notificationBody != null &&
          widget.alarmSettings!.notificationBody!.isNotEmpty;
      assetAudio = widget.alarmSettings!.assetAudioPath;
    }
  }

  AlarmSettings buildAlarmSettings() {
    final now = DateTime.now();
    final id = creating
        ? DateTime.now().millisecondsSinceEpoch % 100000
        : widget.alarmSettings!.id;

    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
      0,
      0,
    );
    if (dateTime.isBefore(DateTime.now())) {
      dateTime = dateTime.add(const Duration(days: 1));
    }

    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: dateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      volumeMax: volumeMax,
      notificationTitle: showNotification ? 'yeclock' : null,
      notificationBody: showNotification ? 'It\'s time to wake up!' : null,
      assetAudioPath: assetAudio,
      stopOnNotificationOpen: false,
    );
    return alarmSettings;
  }

  void saveAlarm() {
    setState(() => loading = true);
    Alarm.set(alarmSettings: buildAlarmSettings()).then((res) {
      if (res) Navigator.pop(context, true);
    });
    setState(() => loading = false);
  }

  void deleteAlarm() {
    Alarm.stop(widget.alarmSettings!.id).then((res) {
      if (res) Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Container(
        color: AppTheme.mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppTheme.accentColor,
                        fontFamily: AppTheme.mainFont,
                        fontWeight: FontWeight.bold,
                        ),
                      ),),
                TextButton(
                  onPressed: saveAlarm,
                  child: loading
                      ? const CircularProgressIndicator()
                      : Text(
                          "SAVE",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppTheme.accentColor,
                            fontFamily: AppTheme.mainFont,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
            Text(
              '${isToday() ? 'TODAY' : 'TOMORROW'} AT',
              // style: AppTheme.todayTomorrow,
              style: TextStyle(
                fontFamily: AppTheme.mainFont,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.accentColor,
              )
            ),
            TimePickerSpinner(
              time: dateTimeFormat,
              is24HourMode: false,
              normalTextStyle: TextStyle(
    fontFamily: AppTheme.mainFont,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: AppTheme.accentColor.withOpacity(0.5),
  ),
              highlightedTextStyle: TextStyle(
    fontFamily: AppTheme.mainFont,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: AppTheme.accentColor,
  ),
              spacing: 50,
              itemHeight: 45,
              isForce2Digits: true,
              onTimeChange: (time) {
                setState(() {
                  dateTimeFormat = time;
                  selectedTime = TimeOfDay.fromDateTime(time);
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LOOP AUDIO',
                  style: TextStyle(
    fontFamily: AppTheme.mainFont,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppTheme.accentColor,
  ),

                ),
                Switch(
                  value: loopAudio,
                  onChanged: (value) => setState(() => loopAudio = value),
                  activeColor: AppTheme.accentColor,
                  inactiveThumbColor: AppTheme.accentColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'VIBRATE',
                  style: TextStyle(
    fontFamily: AppTheme.mainFont,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppTheme.accentColor,
  ),
                ),
                Switch(
                  value: vibrate,
                  onChanged: (value) => setState(() => vibrate = value),
                  activeColor: AppTheme.accentColor,
                  inactiveThumbColor: AppTheme.accentColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'MAX VOLUME',
                  style: TextStyle(
    fontFamily: AppTheme.mainFont,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppTheme.accentColor,
  ),
                ),
                Switch(
                  value: volumeMax,
                  onChanged: (value) => setState(() => volumeMax = value),
                  activeColor: AppTheme.accentColor,
                  inactiveThumbColor: AppTheme.accentColor,
                ),
              ],
            ),
            // TextButton(
            //   style: ButtonStyle(
            //     foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            //   ),
            //   onPressed: () async {
            //     SharedPreferences prefs = await SharedPreferences.getInstance();
            //     print(prefs.getInt('theme'));
            //   },
            //   child: Text('Status Check'),
            // ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Show notification',
            //       style: Theme.of(context).textTheme.titleMedium,
            //     ),
            //     Switch(
            //       value: showNotification,
            //       onChanged: (value) => setState(() => showNotification = value),
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SOUND',
                  style: TextStyle(
    fontFamily: AppTheme.mainFont,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppTheme.accentColor,
  ),
                ),
                DropdownButton(
                  dropdownColor: AppTheme.mainColor,
                  iconEnabledColor: AppTheme.accentColor,
                  style: TextStyle(color: AppTheme.accentColor, fontSize: 16),
                  value: assetAudio,
                  items: [
                    DropdownMenuItem<String>(
                      value: 'assets/goodmorning.mp3',
                      child: Text('GOOD MORNING', style: TextStyle(
    fontFamily: AppTheme.mainFont,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppTheme.accentColor,
  ),),
                    ),
                    DropdownMenuItem<String>(
                      value: 'assets/feedback.mp3',
                      child: Text('FEEDBACK', style: TextStyle(
    fontFamily: AppTheme.mainFont,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppTheme.accentColor,
  ),),
                    ),
                  ],
                  onChanged: (value) => setState(() => assetAudio = value!),
                ),
              ],
            ),
            if (!creating)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                },
                      child: Text("SETTINGS", style: TextStyle(
    fontFamily: AppTheme.mainFont,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppTheme.accentColor,
  ),)),
                  TextButton(
                    onPressed: deleteAlarm,
                    child: Text('DELETE', style: TextStyle(
    fontFamily: AppTheme.mainFont,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppTheme.accentColor,
  ),),
                  ),
                ],
              ),
            if (creating)
              TextButton(
                  onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                },
                  child: Text("SETTINGS", style: TextStyle(
    fontFamily: AppTheme.mainFont,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppTheme.accentColor,
  ),)),
            const SizedBox(
              height: 0,
            ),
          ],
        ),
      ),
    );
  }
}
