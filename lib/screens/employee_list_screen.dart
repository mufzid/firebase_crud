import 'package:flutter/material.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      surfaceTintColor: Colors.black,
                      backgroundColor: Colors.white,
                      title: const Text('Are you sure want to Logout?'),
                      content: const Text(
                          'You want to login after you logot from the page'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, "/login"),
                          child: const Text(
                            'Log Out',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.redAccent,
                )),
          )
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Employee List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: const Color.fromARGB(255, 40, 40, 40),
        child: const Icon(Icons.add, color: Colors.white, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        color: Colors.grey,
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 221, 220, 220),
                        blurRadius: 10,
                        spreadRadius: 10,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 170, 170, 170),
                        radius: 30,
                        child: Image(
                          image: AssetImage('assets/images/placeholder.png'),
                        ),
                      ),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('id'),
                        Text('name'),
                      ],
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('email'),
                        Text('Designation'),
                      ],
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              surfaceTintColor: Colors.black,
                              backgroundColor: Colors.white,
                              title: const Text('Are you sure?'),
                              content: const Text(
                                  'This action will permanently delete this data'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
