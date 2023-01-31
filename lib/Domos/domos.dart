import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:my_app/Domos/db_helper/databaseconnection.dart';
import 'db_helper/alarmservice.dart';
import 'models/alarm.dart';
import 'widgets/alarm_tile.dart';
import 'widgets/timer_tile.dart';

class Domos extends StatefulWidget {
  late DatabaseConnection databaseConnection = DatabaseConnection();
  Domos({super.key, required this.title});
  final String title;

  @override
  State<Domos> createState() => _DomosState();
}

class _DomosState extends State<Domos> {
  final AlarmService alarmService = AlarmService();
  TimeOfDay _timeUser = const TimeOfDay(hour: 8, minute: 30);
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  final List<AlarmTile> _alarms = [];
  Color pickerColor = Colors.white;
  Color currentColor = Colors.white;
  String _titleUser = "";
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF2A2D4D),
      ),
      body: Column(
        children: [
          TimerTile(color: currentColor,),
          Expanded(
            child: Container(
              color: Colors.black,
              child: ListView.builder(
                  itemCount: _alarms.length,
                  itemBuilder: (BuildContext context, int index) {
                    Alarm alarmTemp = Alarm(
                        id: index,
                        title: _alarms[index].alarm.title,
                        time: _alarms[index].alarm.time);
                    return AlarmTile(
                      alarm: alarmTemp,
                      delete: () {
                        setState(() {
                          _alarms.removeAt(index);
                        });
                      },
                    );
                  }),
            ),
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              _showTimePicker();

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  actions: [
                    ElevatedButton(
                        onPressed: () => setState(() {
                              _titleUser = _textFieldController.text;
                              _textFieldController.clear();
                              Navigator.pop(context);
                            }),
                        child: const Text("OK"))
                  ],
                  title: const Text('Défissez un titre'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _textFieldController,
                        autofocus: true,
                        decoration:
                            const InputDecoration(hintText: "Exemple: alarm3"),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: const Text('Défnir une alarme'),
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              _showColorPicker();
            },
            child: const Text('Allumer la lumière'),
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              setState(() {
                currentColor = Colors.white;
              });
            },
            child: const Text('Eteindre la lumière'),
          ),
        ],
      ),
    );
  }

// Fonction pour définir une alarme
// datetimepicker ne fonctionne pas
  void _showTimePicker() {
    showTimePicker(
      helpText: "Choisissez l'heure de l'alarme",
      context: context,
      initialTime: _timeUser,
    ).then((value) {
      setState(() {
        _timeUser = value!;

        Alarm alarmTemp = Alarm(
          id: _alarms.length - 1,
          title: _titleUser,
          time: _timeUser.format(context).toString(),
        );

        _alarms.add(AlarmTile(
          alarm: alarmTemp,
          delete: () {
            _alarms.removeAt(_alarms.length - 1);
          },
        ));
        var result = alarmService.saveAlarm(alarmTemp);
        print(alarmService.getAlarms());
      });
    });
  }

  // Fonction pour définir La couleur de la lumière
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choisir la couleur'),
        content: SingleChildScrollView(
          child: ColorPicker(
            enableAlpha: false,
            pickerColor: pickerColor,
            onColorChanged: changeColor,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Allumer la led'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
