import 'package:flutter/material.dart';
import 'package:yeclock/const.dart';
import 'package:yeclock/quotes.dart';
import 'package:yeclock/screens/settings.dart';

class ExampleAlarmTile extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final void Function()? onDismissed;

  const ExampleAlarmTile({
    Key? key,
    required this.title,
    required this.onPressed,
    this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Text(
            title.split(" ")[0],
            style: TextStyle(
              fontSize: 80,
              fontFamily: AppTheme.mainFont,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentColor,
            ),
          ),
          Text(
            title.split(" ")[1],
            style: TextStyle(
              fontSize: 20,
              fontFamily: AppTheme.mainFont,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentColor,
            ),
          ),
        ],
      ),
    ),
    Container(
      color: AppTheme.mainColor,
      height: 100,
    ),
    Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Container(
        alignment: Alignment.center, // Center alignment
        child: Text(
          "\"${getQuote()}\"",
          style: TextStyle(
            fontSize: 16,
            fontFamily: AppTheme.mainFont,
            fontWeight: FontWeight.bold,
            color: AppTheme.accentColor,
          ),
          textAlign: TextAlign.center, // Center text within the Container
        ),
      ),
    ),
    const SizedBox(height: 70),
  ],
);

  }
}
