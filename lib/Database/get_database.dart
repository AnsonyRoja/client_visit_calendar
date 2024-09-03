import 'package:work_with_days/Database/databas_init.dart';

getPatient({required date}) async {
  final db = await DatabaseHelper.instance.database;

  dynamic result = await db
      .query('patients', where: 'consultation_date = ?', whereArgs: [date]);

  return result;
}
