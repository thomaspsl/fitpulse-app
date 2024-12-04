import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/data/providers/date.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    Provider.of<DateProvider>(context, listen: false).index();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var dates = Provider.of<DateProvider>(context);

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
                  color: theme.color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: theme.color,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: theme.color,
                ),
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                markerDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: theme.color,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: theme.color.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
              eventLoader: (day) {
                return dates.findByDay(day);
              },
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: dates.findByDay(_selectedDay).isEmpty
                  ? [
                      Center(
                        child: const Text(
                          'Pas de séance programmée',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ]
                  : dates
                      .findByDay(_selectedDay)
                      .map(
                        (event) => Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: theme.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat('HH:mm').format(event.date),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  event.session.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            )
          ],
        ),
      ),
    );
  }
}
