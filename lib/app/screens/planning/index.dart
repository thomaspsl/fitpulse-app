import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PlanningIndex extends StatefulWidget {
  const PlanningIndex({super.key});

  @override
  State<PlanningIndex> createState() => _PlanningIndexState();
}

class _PlanningIndexState extends State<PlanningIndex> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<ThemeProvider>(context).color;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Suivi de vos séances',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TableCalendar(
              firstDay: DateTime.utc(1970, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              locale: 'fr',
              startingDayOfWeek: StartingDayOfWeek.monday,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: color,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: color,
                ),
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: color.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
