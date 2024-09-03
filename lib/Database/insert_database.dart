import 'package:work_with_days/Database/databas_init.dart';

insertPatient(Map<String, dynamic> patient) async {
  final db = await DatabaseHelper.instance.database;

  await db.insert('patients', patient);
}
