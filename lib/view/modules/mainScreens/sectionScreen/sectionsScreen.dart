import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradebook/providerData.dart';
import 'package:tradebook/view/modules/subSectionScreen/subSectionScreen.dart';
import 'package:tradebook/widgets/constants/appBrain.dart';

class SectionsScreen extends StatefulWidget {
  const SectionsScreen({Key? key}) : super(key: key);

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    CollectionReference sections =
        FirebaseFirestore.instance.collection('sections');
    return Container(
      padding: const EdgeInsets.only(
        top: 110.0,
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: sections.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.count(
            crossAxisCount: 2,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              var sectionData = document.data() as Map;
              return GestureDetector(
                onTap: () {
                  setSectionID(context: context, val: document.id);
                  Get.to(() => const SubSectionScreen());
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width / 7)),
                  child: CachedNetworkImage(
                    imageUrl: sectionData['logoURL'] ??= avatarPlaceholderURL,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    imageBuilder: (context, imageProvider) => Column(
                      children: [
                        CircleAvatar(
                          radius: 60.0,
                          backgroundColor: Colors.white,
                          child: Image.network(sectionData['logoURL']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            sectionData['nameAR'],
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'XB_Zar',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /*Column(
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.white,
                      child: Image.network(sectionData['logoURL']),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        sectionData['nameAR'],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'XB_Zar',
                        ),
                      ),
                    )
                  ],
                ),*/
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
