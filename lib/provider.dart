import 'package:flutter/material.dart';

class Alarm {
  TimeOfDay time;
  bool isActive;
  String? alarmTone;

  Alarm({required this.time, this.isActive = true, this.alarmTone});
}
class AlarmProvider with ChangeNotifier {
  List<Alarm> _alarms = [];

  List<Alarm> get alarms => _alarms;

  void addAlarm(Alarm alarm) {
    _alarms.add(alarm);
    notifyListeners();
  }

  void updateAlarm(int index, Alarm newAlarm) {
    _alarms[index] = newAlarm;
    notifyListeners();
  }

  void toggleAlarm(int index) {
    _alarms[index].isActive = !_alarms[index].isActive;
    notifyListeners();
  }

  void deleteAlarm(int index) {
    _alarms.removeAt(index);
    notifyListeners();
  }
}
