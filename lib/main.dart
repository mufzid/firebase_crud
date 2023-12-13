import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/firebase_options.dart';
import 'package:firebase_crud/screens/add.dart';
import 'package:firebase_crud/screens/employee_list_screen.dart';
import 'package:firebase_crud/screens/login_screen.dart';
import 'package:firebase_crud/screens/signup_screen.dart';
import 'package:firebase_crud/screens/update.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SignUpPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/list': (context) => const EmployeeListScreen(),
        '/add': (context) => const AddScreen(),
        '/update': (context) => const UpdateScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
