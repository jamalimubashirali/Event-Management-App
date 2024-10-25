import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_management_app/provider/event_provider.dart';

class CreateEditEventScreen extends StatefulWidget {
  const CreateEditEventScreen({super.key, required eventId});

  @override
  _CreateEditEventScreenState createState() => _CreateEditEventScreenState();
}

class _CreateEditEventScreenState extends State<CreateEditEventScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  void _createEvent() async {
    Map<String, dynamic> newEvent = {
      'name': _nameController.text,
      'description': _descriptionController.text,
      'date': _dateController.text,
    };

    await Provider.of<EventProvider>(context, listen: false).addEvent(newEvent);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Event")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Event Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Event Description'),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Event Date'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createEvent,
              child: const Text("Create Event"),
            ),
          ],
        ),
      ),
    );
  }
}
