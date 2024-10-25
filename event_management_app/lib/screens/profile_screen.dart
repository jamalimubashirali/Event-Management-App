import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_management_app/provider/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (user != null) ...[
              Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Use the updated class name
                  await Provider.of<CustomAuthProvider>(context, listen: false).signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text("Logout"),
              ),
            ] else
              const Center(child: Text("User not logged in")),
          ],
        ),
      ),
    );
  }
}
