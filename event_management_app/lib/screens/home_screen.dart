import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_management_app/provider/event_provider.dart';
import 'event_details_screen.dart';
import 'create_edit_event_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Upcoming Events"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateEditEventScreen(eventId: null,)),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            title: Text(event['name']),
            subtitle: Text(event['date']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailsScreen(eventId: event['id']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
