import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../providerData.dart';
import 'activityHomeScreen.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    CollectionReference sections = FirebaseFirestore.instance
        .collection('sections')
        .doc(getSectionID(context: context))
        .collection('subSections')
        .doc(getSubSectionID(context: context))
        .collection('activities');
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/screenTopShape.png',
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 60.0,
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: sections.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Something was Wrong',
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    var subSectionData = document.data() as Map;
                    return GestureDetector(
                      onTap: () {
                        setActivityID(context: context, val: document.id);
                        Get.to(() => const ActivityHomeScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ListTile(
                          title: Text(
                            subSectionData['nameAR'],
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          leading: Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(subSectionData['logoUrl']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
