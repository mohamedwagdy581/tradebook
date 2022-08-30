// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tradebook/model/locationServices.dart';
import 'package:tradebook/view/homeLayout/homeLayout.dart';
import 'package:tradebook/widgets/constants/fUser.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../model/firebaseServices.dart';
import '../../../providerData.dart';
import '../../../widgets/components.dart';
import '../../../widgets/constants/appBrain.dart';

class ActivityHomeScreen extends StatefulWidget {
  const ActivityHomeScreen({Key? key}) : super(key: key);

  @override
  _ActivityHomeScreenState createState() => _ActivityHomeScreenState();
}

class _ActivityHomeScreenState extends State<ActivityHomeScreen> {
  final FirebaseService _service = FirebaseService();
  final LocationServices _locationServices = LocationServices();
  String _logoURL = '';
  String _nameAR = '';
  String _whatsapp = '';
  double _latitude = 0;
  double _longitude = 0;

  @override
  void initState() {
    getActivityProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(_logoURL),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _nameAR,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: const Text(
                  'Facebook',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blueAccent,
                ),
                trailing: const Icon(
                  Icons.arrow_right,
                  color: Colors.purple,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: const Text(
                  'Twitter',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  FontAwesomeIcons.twitter,
                  color: Colors.blue,
                ),
                trailing: const Icon(
                  Icons.arrow_right,
                  color: Colors.purple,
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: const Text(
                  'Youtube',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  FontAwesomeIcons.youtube,
                  color: Colors.red,
                ),
                trailing: const Icon(
                  Icons.arrow_right,
                  color: Colors.purple,
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: const Text(
                  'Instagram',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  FontAwesomeIcons.instagram,
                  color: Colors.deepOrange,
                ),
                trailing: const Icon(
                  Icons.arrow_right,
                  color: Colors.purple,
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: const Text(
                  'Site',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.web,
                  color: Colors.purple,
                ),
                trailing: const Icon(
                  Icons.arrow_right,
                  color: Colors.purple,
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.home,
          color: Colors.purple,
        ),
        onPressed: () {
          Get.offAll(() => const HomeLayout());
        },
      ),
      body: Stack(
        children: [
          CustomPaint(
            painter: HeaderCurvedContainer(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        _nameAR,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'XB_Zar',
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  CachedNetworkImage(
                    imageUrl: _logoURL,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    imageBuilder: (context, imageProvider) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5),
                          //borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: imageProvider,
                          ),
                        ),
                      ),
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                        //borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(_logoURL),
                        ),
                      ),
                    ),
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('sections')
                            .doc(getSectionID(context: context))
                            .collection('subSections')
                            .doc(getSubSectionID(context: context))
                            .collection('activities')
                            .doc(getActivityID(context: context))
                            .collection('likedUsers')
                            .doc(auth.currentUser?.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: Icon(
                                FontAwesomeIcons.heart,
                              ),
                            );
                          }
                          if (snapshot.data!.exists) {
                            return IconButton(
                              onPressed: () {
                                addLike(true);
                              },
                              icon: const Icon(
                                FontAwesomeIcons.solidHeart,
                              ),
                              color: Colors.red,
                            );
                          } else {
                            return IconButton(
                              onPressed: () {
                                addLike(false);
                              },
                              icon: const Icon(
                                FontAwesomeIcons.heart,
                              ),
                              color: Colors.grey,
                            );
                          }
                        },
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('sections')
                            .doc(getSectionID(context: context))
                            .collection('subSections')
                            .doc(getSubSectionID(context: context))
                            .collection('activities')
                            .doc(getActivityID(context: context))
                            .collection('likedUsers')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child:
                                  Text(snapshot.data!.docs.length.toString()),
                            );
                          } else {
                            return const Text('0');
                          }
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.add_comment,
                          color: Colors.teal,
                        ),
                        onPressed: () {},
                      ),
                      const Text('التعليقات'),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.attachment_rounded,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                      const Text('0'),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          customCard(
                            onPressed: () {
                              _locationServices.goToLocation(
                                latitude: _latitude,
                                longitude: _longitude,
                              );
                            },
                            txt: 'الموقع',
                            icon: FontAwesomeIcons.searchLocation,
                            iconColor: Colors.red,
                            iconSize: MediaQuery.of(context).size.width / 6,
                          ),
                          customCard(
                            onPressed: () {
                              //print('ljlk');
                            },
                            txt: 'المتجر',
                            icon: FontAwesomeIcons.store,
                            iconColor: Colors.blueAccent,
                            iconSize: MediaQuery.of(context).size.width / 6,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          customCard(
                            txt: 'المعرض',
                            icon: FontAwesomeIcons.photoVideo,
                            iconColor: Colors.deepOrange,
                            iconSize: MediaQuery.of(context).size.width / 6,
                            onPressed: () {},
                          ),
                          customCard(
                            onPressed: () {
                              sendWhatsAppMessage(
                                  phone: _whatsapp,
                                  message: 'مرحبا $_nameAR من تطبيق تريدبوك');
                            },
                            txt: 'اتصل بنا',
                            icon: FontAwesomeIcons.whatsapp,
                            iconColor: Colors.green,
                            iconSize: MediaQuery.of(context).size.width / 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  addLike(bool liked) {
    liked = !liked;

    if (liked) {
      DocumentReference reference = _service.db
          .collection('sections')
          .doc(getSectionID(context: context))
          .collection('subSections')
          .doc(getSubSectionID(context: context))
          .collection('activities')
          .doc(getActivityID(context: context))
          .collection('likedUsers')
          .doc(auth.currentUser?.uid);

      reference.set({
        'logoUrl': auth.currentUser?.photoURL,
        'nameAR': auth.currentUser?.displayName,
        'createDate': DateTime.now(),
      });
    } else {
      DocumentReference reference = _service.db
          .collection('sections')
          .doc(getSectionID(context: context))
          .collection('subSections')
          .doc(getSubSectionID(context: context))
          .collection('activities')
          .doc(getActivityID(context: context))
          .collection('likedUsers')
          .doc(auth.currentUser?.uid);

      reference.delete();
    }
  }

  // Functions

  sendWhatsAppMessage({
    required String phone,
    required String message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return 'whatsapp://we.me/$phone/?text=${Uri.parse(message)}';
      } else {
        return 'whatsapp://send?phone=$phone&text=$message';
      }
    }

    await canLaunchUrlString(url())
        ? launchUrlString(url())
        : ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'There is now WhatsApp on your Device!',
              ),
            ),
          );
  }

  getActivityProfile() async {
    DocumentReference ref = _service.db
        .collection('sections')
        .doc(getSectionID(context: context))
        .collection('subSections')
        .doc(getSubSectionID(context: context))
        .collection('activities')
        .doc(getActivityID(context: context));
    ref.get().then(
          (doc) => {
            setState(() {
              var referencesData = doc.data() as Map;
              if (doc.data() != null) {
                _logoURL = referencesData['logoUrl'] ??= avatarPlaceholderURL;
                _nameAR = referencesData['nameAR'] ??= 'Activity Name';
                _whatsapp = referencesData['whatsapp'] ??= '00966596397777';
                _latitude = referencesData['latitude'] ??= 0.0;
                _longitude = referencesData['longitude'] ??= 0.0;
              }
            })
          },
        );
  }
} // CustomPainter class to for the header curved-container

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.purple[600]!;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
