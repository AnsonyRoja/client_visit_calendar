import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:work_with_days/Database/databas_init.dart';
import 'package:work_with_days/Database/get_database.dart';
import 'package:work_with_days/Database/insert_database.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String? date;
  DateTime? parsedDate;
  String? originalFormattedDate;
  String? newFormattedDate;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();

  void initDatabase() async {
    await DatabaseHelper.instance.database;
    // await insertPatient();
    dynamic result = await getPatient();
    print('Este es el resultado $result');
  }

  @override
  void initState() {
    super.initState();
    initDatabase();

    var originalFormattedDate =
        DateFormat.yMMMMEEEEd('es').add_jms().format(DateTime.now());
    print('Fecha formateada original: $originalFormattedDate');

    // Definir el formato del cual vamos a parsear
    // Este formato debe coincidir exactamente con el formato de la fecha original}
    String semana = DateFormat('d \'de\' MMMM \'de\' yyyy HH:mm:ss', 'es')
        .format(DateTime.now());
    print('Este es el dia de la semana $semana');
    DateFormat originalFormatter =
        DateFormat('EEEE, d \'de\' MMMM \'de\' yyyy HH:mm:ss', 'es');

    // Imprimir el formato del `DateFormat`
    print('Formato para parsear: ${originalFormatter.pattern}');

    // Definir el nuevo formato al cual queremos convertir
    DateFormat newFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');

    DateTime parsedDate;

    try {
      // Parsea la cadena de fecha en un objeto DateTime
      parsedDate = originalFormatter.parse(originalFormattedDate!);
      print('Fecha parseada: $parsedDate');

      // Formatea el objeto DateTime al nuevo formato
      newFormattedDate = newFormatter.format(parsedDate);
      print('Fecha en nuevo formato: $newFormattedDate');
      DateTime now = DateTime.now();
      print('Fecha y hora actuales: $now');
      setState(() {
        date = newFormattedDate;
      });
      // Comparar la fecha parseada con la fecha actual
      if (parsedDate.isBefore(now)) {
        print('La fecha parseada es anterior a la fecha actual.');
      } else {
        print('La fecha parseada no es anterior a la fecha actual.');
      }
    } catch (e) {
      print('Error al parsear la fecha: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TableCalendar(
              focusedDay: _selectedDay,
              firstDay: DateTime.utc(2021, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              selectedDayPredicate: (day) {
                // Esto resalta el día seleccionado en el calendario
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = focusedDay;
                });

                print('Día seleccionado: $_selectedDay ');
              },
              locale: 'es_ES',
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Formato cambiado a ${format == CalendarFormat.month ? 'Mes' : format == CalendarFormat.twoWeeks ? '2 Semanas' : 'Semana'}'),
                  duration: const Duration(seconds: 1),
                ));

                print('Valor de format $format');
              },
              availableCalendarFormats: const {
                // si solomente hay un solo formato desaparece el boton, de cambiar el formato del calendario
                CalendarFormat.month: 'Mes', // Texto en español para "Month"
                CalendarFormat.twoWeeks:
                    '2 Semanas', // Texto en español para "Two Weeks"
                CalendarFormat.week: 'Semana', // Texto en español para "Week"
              },
              calendarStyle: const CalendarStyle(
                todayTextStyle: TextStyle(color: Colors.black),
                // Aquí puedes personalizar el color de `focusedDay`
                todayDecoration: BoxDecoration(
                  color: Colors.transparent, // Quitar color al día enfocado
                  shape: BoxShape.circle,
                ),
                // selectedDecoration: BoxDecoration(
                //   color:
                //       Colors.blue, // Mantener el color para el día seleccionado
                //   shape: BoxShape.circle,
                // ),
                defaultDecoration: BoxDecoration(
                  shape:
                      BoxShape.circle, // Forma predeterminada para otros días
                ),
                outsideDecoration: BoxDecoration(
                  shape: BoxShape.circle, // Forma para días fuera del mes
                ),
                // Puedes seguir ajustando otras propiedades según tus necesidades
              ),
            )

            // const Text(
            //   'Fecha:',
            // ),
            // Text(
            //   '$date',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
    );
  }
}
