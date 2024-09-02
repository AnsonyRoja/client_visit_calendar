class Patient {
  final int? id;
  final String name;
  final String consultationDate;
  Patient({this.id, required this.name, required this.consultationDate});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'consultation_date': consultationDate,
    };
  }

  factory Patient.fromMap(Map<String, dynamic> patient) {
    return Patient(
        id: patient['id'],
        name: patient['name'],
        consultationDate: patient['consultation_date']);
  }
}
