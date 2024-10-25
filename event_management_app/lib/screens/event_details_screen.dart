import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_management_app/provider/event_provider.dart';

class EventDetailsScreen extends StatelessWidget {
  final String eventId;

  EventDetailsScreen({required this.eventId});

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<EventProvider>(context)
        .events
        .firstWhere((event) => event['id'] == eventId);

    return Scaffold(
      appBar: AppBar(title: Text(event['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event['name'], style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text("Date: ${event['date']}"),
            SizedBox(height: 20),
            Text(event['description']),
          ],
        ),
      ),
    );
  }
}
