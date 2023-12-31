import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/auth/firebase_auth.dart';
import 'package:firebase_crud/widgets/form_container.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emialController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock,
                  size: 90,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                FromCondainerWidget(
                  controller: _emialController,
                  hintText: "Email",
                  isPasswordField: false,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "please enter your email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                FromCondainerWidget(
                  controller: _pass,
                  validator: (val) {
                    if (val!.isEmpty) return 'please enter your password';
                    return null;
                  },
                  hintText: "Password",
                  isPasswordField: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                FromCondainerWidget(
                  controller: _passwordController,
                  validator: (value) {
                    // if (val!.isEmpty) return 'Empty';
                    // if (_passwordController.text != _pass.text) {
                    //   return 'Not Match';
                    // }
                    // return null;
                    // return _pass.text =
                    //     value ? null : "Please validate your entered password";

                    return _pass.text == value
                        ? null
                        : "Passwords do not match";
                  },
                  hintText: "Confirm Password",
                  isPasswordField: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    _signUp();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 251, 0, 0)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String email = _emialController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully created");

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      print('Some error happen');
    }
    if (_formkey.currentState!.validate()) {
      Navigator.pushNamed(context, '/login');
    }
  }
}
