import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TodoDatasource {
  final SharedPreferences _sharedPreferences;

  TodoDatasource(this._sharedPreferences);

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    final tasks = _sharedPreferences.getStringList('tasks');
    return tasks?.map((task) {
          final json = jsonDecode(task);
          return Map<String, dynamic>.from(json);
        })?.toList() ??
        [];
  }

  Future<void> saveTasks(List<Map<String, dynamic>> tasks) async => await _sharedPreferences.setStringList(
        'tasks',
        tasks
            .map(
              (task) => task.toString(),
            )
            .toList(),
      );

  Future<void> clearAllTasks() async => await _sharedPreferences.remove('tasks');
}
