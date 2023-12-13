import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/resources/save_data.dart';
import 'package:firebase_crud/screens/insertimage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveProfile() async {
    String resp = await StoreData().saveData(file: _image!);
  }

  final CollectionReference employee =
      FirebaseFirestore.instance.collection('employee');
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
                            style: TextStyle(
                                color: Color.fromARGB(255, 203, 16, 3)),
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
        color: const Color.fromARGB(255, 220, 219, 219),
        child: StreamBuilder(
          stream: employee.orderBy('name').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot employeeSnap =
                      snapshot.data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
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
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Stack(children: [
                                  _image != null
                                      ? CircleAvatar(
                                          radius: 30,
                                          backgroundImage: MemoryImage(_image!),
                                        )
                                      : const CircleAvatar(
                                          backgroundColor: Color.fromARGB(
                                              255, 170, 170, 170),
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              'https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg'),
                                        ),
                                  Positioned(
                                    bottom: -18,
                                    left: 20,
                                    child: IconButton(
                                      onPressed: selectImage,
                                      icon: const Icon(
                                        Icons.add_a_photo,
                                        size: 15,
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                              SizedBox(
                                width: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text('id'),
                                    Text(
                                      employeeSnap['name'],
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 189, 0, 0),
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    Text(
                                      employeeSnap['job'],
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      employeeSnap['email'],
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/update',
                                        arguments: {
                                          'name': employeeSnap['name'],
                                          'email': employeeSnap['email'],
                                          'job': employeeSnap['job'],
                                          'sex': employeeSnap['sex'],
                                          'address': employeeSnap['address'],
                                          'number':
                                              employeeSnap['number'].toString(),
                                          'country': employeeSnap['country'],
                                          'state': employeeSnap['state'],
                                          'city': employeeSnap['city'],
                                          'id': employeeSnap.id,
                                        });
                                  },
                                  icon: const Icon(Icons.edit)),
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
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              deleteEmployee(employeeSnap.id);
                                            },
                                            child: const Text(
                                              'Delete',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete)),
                              IconButton(
                                  onPressed: () {
                                    saveProfile();
                                  },
                                  icon: const Icon(Icons.person))
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void deleteEmployee(docId) {
    employee.doc(docId).delete().then((value) => Navigator.pop(context));
  }
}
