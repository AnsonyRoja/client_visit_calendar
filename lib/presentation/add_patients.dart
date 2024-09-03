import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:work_with_days/Database/insert_database.dart';
import 'package:work_with_days/providers/patients_providers.dart';

class AddPatients extends StatefulWidget {
  final String date;
  const AddPatients({super.key, required this.date});

  @override
  State<AddPatients> createState() => _AddPatientsState();
}

class _AddPatientsState extends State<AddPatients> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime parseDate = DateFormat('yyyy-MM-dd').parse(widget.date);

    String formmater = DateFormat('dd/MM/yyyy').format(parseDate);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Patient'),
        ),
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Text(
                  'Fecha : $formmater',
                  style: const TextStyle(fontSize: 18),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(label: Text('Patient')),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      if (_nameController.text == "") return;
                      Map<String, dynamic> patient = {
                        'name': _nameController.text,
                        'consultation_date': formmater,
                      };

                      insertPatient(patient);

                      Provider.of<PatientProvider>(context, listen: false)
                          .getPatients(date: formmater);
                      _nameController.clear();
                    },
                    child: const Text('Agregar Paciente'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
