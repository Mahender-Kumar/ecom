import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Home Screen'),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: const Text('Login'),
          ),
          ElevatedButton(
            onPressed: () {
              // Go to the register page
              // GoRouter.of(context).go('/register');
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
