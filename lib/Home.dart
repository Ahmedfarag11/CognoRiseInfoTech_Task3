import 'package:alarm/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color.fromARGB(255, 203, 207, 211),
          appBar: AppBar(
            title: Text(
              'Alarm Clock',
              style: TextStyle(color: Colors.white, fontSize: 27),
            ),
            backgroundColor: Color.fromARGB(255, 43, 43, 43),
          ),
          body: Consumer<AlarmProvider>(
            builder: (context, alarmProvider, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 13),
                child: ListView.builder(
                  itemCount: alarmProvider.alarms.length,
                  itemBuilder: (context, index) {
                    final alarm = alarmProvider.alarms[index];
                    return ListTile(
                      title: Text(alarm.time.format(context)),
                      subtitle: Text(alarm.alarmTone ?? 'Default tone'),
                      trailing: Switch(
                        value: alarm.isActive,
                        onChanged: (value) => alarmProvider.toggleAlarm(index),
                      ),

                      onTap: () =>
                          _editAlarm(context, alarm, index), // Edit the alarm
                    );
                  },
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () => _addAlarm(context),
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ));
  }

  Future<void> _addAlarm(BuildContext context) async {
    TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      Provider.of<AlarmProvider>(context, listen: false)
          .addAlarm(Alarm(time: picked));
    }
  }

  Future<void> _editAlarm(BuildContext context, Alarm alarm, int index) async {
    TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: alarm.time);
    if (picked != null) {
      Provider.of<AlarmProvider>(context, listen: false)
          .updateAlarm(index, Alarm(time: picked));
    }
  }
}
