import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tradebook/model/firebaseServices.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            DocumentReference reference =
                _service.db.collection('sections').doc('MedicalServices');

            reference.set({
              'logoURL':
                  'https://firebasestorage.googleapis.com/v0/b/tradebook-821ba.appspot.com/o/logos%2FmedicalServices.png?alt=media&token=9cb3f32b-3af4-438e-b317-c5742ed3a23a',
              'nameAR': 'خدمات طبية',
              'nameEN': 'Medical Services',
              'nameTR': 'Medikal Servis',
              'createdAt': DateTime.now(),
            });
          },
          color: Colors.purple,
          textColor: Colors.white,
          child: const Text(
            'Add Data to Firebase',
          ),
        ),
      ),
    );
  }
}
