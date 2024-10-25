import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _events = [];

  List<Map<String, dynamic>> get events => _events;

  EventProvider() {
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('events').get();
      _events = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addEvent(Map<String, dynamic> eventData) async {
    try {
      await _firestore.collection('events').add(eventData);
      _fetchEvents();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> updateEvent(String eventId, Map<String, dynamic> eventData) async {
    try {
      await _firestore.collection('events').doc(eventId).update(eventData);
      _fetchEvents();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _firestore.collection('events').doc(eventId).delete();
      _fetchEvents();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
