import 'package:firebase_crud/screens/add.dart';
import 'package:firebase_crud/screens/employee_list_screen.dart';
import 'package:firebase_crud/screens/login_screen.dart';
import 'package:firebase_crud/screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const SignUpPage(), routes: {
      '/login': (context) => const LoginPage(),
      '/signup': (context) => const SignUpPage(),
      '/list': (context) => const EmployeeListScreen(),
      '/add': (context) => const AddScreen(),
    });
  }
}
