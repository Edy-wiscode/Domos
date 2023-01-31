import 'package:flutter/material.dart';

import '../models/alarm.dart';

class AlarmTile extends StatelessWidget {
  const AlarmTile(
      {super.key,
      required this.alarm,
      required this.delete});
  final Alarm alarm;
  final void Function() delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 300,
      decoration: BoxDecoration(
        color: const Color.fromARGB(128, 217, 217, 217),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Text(alarm.title,
              style:
                  const TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
          const Spacer(),
          Text(alarm.time,
              style:
                  const TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
          // const SizedBox(width: 5),*
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.white,
            onPressed: delete,
          ),
        ],
      ),
    );
  }
}
