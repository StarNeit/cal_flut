import 'package:flutter/material.dart';
import '../models/calendar_event.dart';
import '../widgets/week_header.dart';
import '../widgets/event_item.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  List<CalendarEvent> mockEvents = [
    CalendarEvent.fromJson({
      "title": "Rdv Olivier NOLS",
      "datetime": "2024-12-05 13:30:00",
      "desc": "Microsoft Teams Meeting; Meeting Room 3 [ Protection Unit ]"
    }),
    CalendarEvent.fromJson({
      "title": "Test Event",
      "datetime": "2024-12-05 15:00:00",
      "desc": "Microsoft Teams Meeting"
    }),
    CalendarEvent.fromJson({
      "title": "Gohy test serveur",
      "datetime": "2024-12-05 17:30:00",
      "desc": null
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            WeekHeader(
              selectedDate: selectedDate,
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
            Divider(color: Colors.grey[800]),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Number of days to show
                itemBuilder: (context, index) {
                  final date = DateTime(2024, 12, 5).add(Duration(days: index));
                  final events = mockEvents.where((event) =>
                      DateUtils.isSameDay(event.datetime, date)).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${date.day} déc.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateUtils.isSameDay(date, DateTime(2024, 12, 5))
                                  ? "Aujourd'hui"
                                  : DateFormat('EEEE', 'fr_FR').format(date),
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (events.isEmpty)
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Aucun événement',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ...events.map((event) => EventItem(
                            event: event,
                            onTap: () {
                              // Navigate to event details
                              print('Tapped event: ${event.title}');
                            },
                          )),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new event
          print('Add new event');
        },
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFF7F7FFF), // This is the color from the image
        elevation: 8,
        highlightElevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}