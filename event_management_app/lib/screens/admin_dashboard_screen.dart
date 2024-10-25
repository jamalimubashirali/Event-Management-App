import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_management_app/provider/event_provider.dart';
import 'create_edit_event_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return Scaffold(
      appBar: AppBar(title: const Text("Admin Dashboard")),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            title: Text(event['name']),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateEditEventScreen(eventId: event['id']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
