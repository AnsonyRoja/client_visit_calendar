import 'package:flutter/material.dart';
import 'package:work_with_days/Database/get_database.dart';

class PatientProvider extends ChangeNotifier {
  String? selectedDate;
  List<dynamic> patients = [];

  Future getPatients({required String date}) async {
    patients = await getPatient(date: date);
    notifyListeners();
  }
}
