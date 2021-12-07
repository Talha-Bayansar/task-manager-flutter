import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/utillities/constants.dart';
import 'package:task_manager/utillities/shared_prefs.dart';

final taskProvider = Provider<TaskProvider>((ref) => TaskProvider());

class TaskProvider {
  String taskUrl = '$kApiUrl/tasks';

  Future<List<dynamic>> fetchTasksToday() async {
    String token = SharedPrefs.instance.getString('jwt') ?? '';
    Response response = await Dio().get(
      '$taskUrl/today',
      options: Options(headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      }),
    );
    return response.data;
  }

  Future<List<Task>> getTasksToday() async {
    List<dynamic> data = await fetchTasksToday();
    List<Task> tasks = data.map((task) => Task.fromJson(task)).toList();
    return tasks;
  }

  Future<List<dynamic>> fetchTasksUpcoming() async {
    String token = SharedPrefs.instance.getString('jwt') ?? '';
    Response response = await Dio().get(
      taskUrl,
      options: Options(headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      }),
    );
    return response.data;
  }

  Future<List<Task>> getTasksUpcoming() async {
    List<dynamic> data = await fetchTasksUpcoming();
    List<Task> tasks = data.map((task) => Task.fromJson(task)).toList();
    return tasks;
  }

  Future<List<dynamic>> fetchTasksDone() async {
    String token = SharedPrefs.instance.getString('jwt') ?? '';
    Response response = await Dio().get(
      '$taskUrl/done',
      options: Options(headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      }),
    );
    return response.data;
  }

  Future<List<Task>> getTasksDone() async {
    List<dynamic> data = await fetchTasksDone();
    List<Task> tasks = data.map((task) => Task.fromJson(task)).toList();
    return tasks;
  }
}
