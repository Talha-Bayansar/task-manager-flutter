import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/models/subject.dart';
import 'package:task_manager/utillities/constants.dart';
import 'package:task_manager/utillities/shared_prefs.dart';

final subjectProvider = Provider<SubjectProvider>((ref) => SubjectProvider());

class SubjectProvider {
  String subjectUrl = '$kApiUrl/subjects';

  Future<List<dynamic>> fetchSubjects() async {
    String token = SharedPrefs.instance.getString('jwt') ?? '';
    Response response = await Dio().get(
      subjectUrl,
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      ),
    );
    return response.data;
  }

  Future<List<Subject>> getSubjects() async {
    List<dynamic> subjectsJson = await fetchSubjects();
    List<Subject> subjects = subjectsJson
        .map((subjectJson) => Subject.fromJson(subjectJson))
        .toList();
    return subjects;
  }

  Future<dynamic> createSubject(dynamic subjectJson) async {
    String token = SharedPrefs.instance.getString('jwt') ?? '';
    Response response = await Dio().post(
      subjectUrl,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ),
      data: jsonEncode(subjectJson),
    );
    return response.data;
  }
}
