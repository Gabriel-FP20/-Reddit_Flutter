import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:estudos_app/config.dart';
import 'package:intl/intl.dart';



int i = 0;
int j = 0;
final materias = <String>['Biologia','Física','Portugues','Matematica','Quimica','Historia','Geografia','Literatura','Redação'];
DateTime final_date = DateTime(2022, 6, 12, 9, 0, 0);
int limite_materias = 3;
int qtd_materias = 9;
int num_materias_dia = 0;
int horas_materias = 2;
int hora_inicial = 9;

List<Meeting> _getDataSource(int intervalo) {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();


  DateTime currentDay = DateTime(today.year, today.month, today.day, hora_inicial, 0, 0);

  for (j=0; j< qtd_materias; j++) {
    final DateTime endTime = currentDay.add(Duration(hours: horas_materias));
    if ((DateFormat('EEEE').format(currentDay)) == 'Sunday') {
      currentDay = currentDay.add(Duration(days: 1));
    }
    if ((DateFormat('EEEE').format(currentDay)) == 'Saturday') {
      currentDay = currentDay.add(Duration(days: 2));
    }
        for (i = 0; i < qtd_materias; i++) {
          if (currentDay.compareTo(final_date) > 0) {
            break;
          }
          meetings.add(Meeting(materias[i], currentDay, endTime, const Color(0xFF0F8644), false));
          num_materias_dia ++;
          if (num_materias_dia == limite_materias){
            currentDay = currentDay.add(Duration(days: 1));
            if ((DateFormat('EEEE').format(currentDay)) == 'Saturday') {
              currentDay = currentDay.add(Duration(days: 2));
            }
            num_materias_dia = 0;
          }
        }
  }
  return meetings;
}


class Calendar extends ConsumerStatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}
class _CalendarState extends ConsumerState<Calendar> {
  @override
  Widget build(BuildContext context) {
    final intervalo = qtd_materias ~/ limite_materias;
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendário'),
      ),
      body: Container(
          child: SfCalendar(
            view: CalendarView.month,
            dataSource: MeetingDataSource(_getDataSource(intervalo)),
            monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          ),
      ));
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

