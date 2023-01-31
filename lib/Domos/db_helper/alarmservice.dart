import 'package:my_app/Domos/db_helper/repository.dart';

import '../models/alarm.dart';

class AlarmService {

  late Repository _repository;

  AlarmService() {
    _repository = Repository();
  }
  
  saveAlarm(Alarm alarm) async {
    return await _repository.insertData('alarm_table', alarm.alarmMap());
  }

  getAlarms () async {
    return await _repository.readData('alarm_table');
  }
}
