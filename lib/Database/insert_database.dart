import 'package:intl/intl.dart';
import 'package:work_with_days/Database/databas_init.dart';

insertPatient() async {
  final db = await DatabaseHelper.instance.database;
  String date = DateFormat.yMd().format(DateTime.now());

  await db.insert('patients', {'name': 'Oiga', 'consultation_date': date});
}
