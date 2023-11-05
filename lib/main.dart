import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    TextEditingController value = TextEditingController();
    FocusNode txt = FocusNode();
    return GestureDetector(
      onTap: () => txt.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: value,
                  focusNode: txt,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    floatingLabelStyle: TextStyle(color: Colors.deepPurple),
                    labelText: 'Enter the data',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  final FirebaseFirestore firestore =
                      FirebaseFirestore.instance;

                  CollectionReference itemsCollection =
                      firestore.collection('Data');

                  Map<String, dynamic> data = {
                    'itemName': value.text,
                  };

                  itemsCollection
                      .add(data)
                      .then((DocumentReference documentReference) {
                    print('Document added with ID: ${documentReference.id}');
                    print('Data: ${value.text}');
                    value.clear();
                  }).catchError((error) {
                    print('Error adding document: $error');
                  });
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
