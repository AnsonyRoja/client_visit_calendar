import 'package:work_with_days/Database/databas_init.dart';

getPatient() async {
  final db = await DatabaseHelper.instance.database;

  dynamic result = await db.query('patients');

  return result;
}
