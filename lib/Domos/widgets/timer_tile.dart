import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimerTile extends StatefulWidget {
  const TimerTile({super.key, required this.color});
  final Color color;

  @override
  State<TimerTile> createState() => _TimerTileState();
}

class _TimerTileState extends State<TimerTile> {
  Timer? timer;
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Text(
          _timeNow(),
          style: const TextStyle(fontSize: 40),
        ),
        const Spacer(),
        Icon (Icons.lightbulb, color: widget.color, size: 60),
      ],
    );
  }

  String _timeNow() {
    setState(() {
      now = DateTime.now();
    });
    return DateFormat('HH : mm : ss').format(now);
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _timeNow());
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}
