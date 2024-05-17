import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class VaccinationCalendarScreen extends StatefulWidget {
  const VaccinationCalendarScreen({super.key});

  @override
  State<VaccinationCalendarScreen> createState() =>
      _VaccinationCalendarScreenState();
}

class _VaccinationCalendarScreenState extends State<VaccinationCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario de vacunación'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFbdc3c7),
              Color(0xFF2c3e50),
              Color(0xFF3a6186),
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              child: TableCalendar(
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2025, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                locale: 'es_ES', // Cambiar al idioma español
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  _showNoteDialog(context, selectedDay);
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  formatButtonTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            if (_selectedDay != null)
              Text(
                'Día seleccionado: ${_selectedDay!.toString().split(' ')[0]}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ..._getEventsList(_selectedDay),
          ],
        ),
      ),
    );
  }

  List<Widget> _getEventsList(DateTime? day) {
    if (day == null) return [];
    final events = _events[day] ?? [];
    return events
        .map((event) => Text(event, style: TextStyle(color: Colors.white)))
        .toList();
  }

  void _showNoteDialog(BuildContext context, DateTime day) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String noteText = '';
        return AlertDialog(
          title: const Text('Agregar nota'),
          content: TextField(
            onChanged: (text) => noteText = text,
            decoration: const InputDecoration(
              hintText: 'Ingresa tu nota aquí',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (noteText.isNotEmpty) {
                  _events[day] = [..._events[day] ?? [], noteText];
                  setState(() {});
                }
                Navigator.pop(context);
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }
}
