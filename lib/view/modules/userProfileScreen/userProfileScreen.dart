import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tradebook/model/firebaseServices.dart';
import 'package:tradebook/widgets/components.dart';
import 'package:tradebook/widgets/constants/appBrain.dart';
import 'package:tradebook/widgets/constants/fUser.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final GlobalKey _barcodeKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final FirebaseService _service = FirebaseService();
  late String imageUrl;

  File? _image;
  final picker = ImagePicker();
  bool _uploading = false;
  bool _editing = false;

  @override
  void initState() {
    getUserProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text('User Profile'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
              ),
              child: IconButton(
                onPressed: () {
                  _shareWidgetAsImage();
                },
                icon: const Icon(
                  Icons.share,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            updateUserProfileData();
                            _editing = !_editing;
                          });
                        },
                        icon: !_editing
                            ? const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )
                            : const Icon(
                                Icons.save,
                                color: Colors.red,
                              ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      alignment: Alignment.center,
                      child: _image == null
                          ? userRoundedPic(
                              photoSize: 130.0,
                              onPressed: () {
                                getImageFromGallery();
                              },
                              image: NetworkImage(
                                userPhotoUrl ??= avatarPlaceholderURL,
                              ),
                            )
                          : userRoundedPic(
                              photoSize: 130.0,
                              onPressed: () {
                                getImageFromGallery();
                              },
                              image: FileImage(_image!),
                            ),
                    ),
                    _uploading == true
                        ? const CircularProgressIndicator()
                        : Container(),

                    // ========= Display Name ===============
                    !_editing
                        ? customDisplayData(
                            child: Text(
                              _nameController.text,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        : customDisplayData(
                            child: defaultTextFormField(
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              label: 'Enter your Name',
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Name must not be Empty';
                                }
                                return null;
                              },
                              prefix: FontAwesomeIcons.person,
                            ),
                          ),

                    // ========= Display Email ===============
                    !_editing
                        ? Text(
                            _emailController.text,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        : customDisplayData(
                            child: defaultTextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              label: 'Enter your Email',
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Email must not be Empty';
                                }
                                return null;
                              },
                              prefix: Icons.email,
                            ),
                          ),

                    // ========= Display Phone ===============
                    !_editing
                        ? customDisplayData(
                            child: Text(
                              _phoneController.text,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        : customDisplayData(
                            child: defaultTextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              label: 'Enter your Phone',
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Phone must not be Empty';
                                }
                                return null;
                              },
                              prefix: FontAwesomeIcons.phone,
                            ),
                          ),
                  ],
                ),
                RepaintBoundary(
                  key: _barcodeKey,
                  child: BarcodeWidget(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 2,
                    color: Colors.purple[600]!,
                    data: auth.currentUser!.uid,
                    barcode: Barcode.qrCode(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _shareWidgetAsImage() async {
    try {
      // Use this Boundary to select Boundaries that we need to cut and share Barcode
      RenderRepaintBoundary boundary = _barcodeKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;

      // Transform The Boundaries that we selected to Image as Pixels
      ui.Image image = await boundary.toImage(pixelRatio: 5.0);

      // Transform Image that we selected to BytesData with format png
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      // start save the image bytes data in buffer as Unit8List
      var pngBytes = byteData?.buffer.asUint8List();

      // Select the path of image in phone
      String dir = (await getApplicationDocumentsDirectory()).path;

      // start Name the image from path with date and png type
      File file = File(
          '$dir/' + DateTime.now().millisecondsSinceEpoch.toString() + '.png');

      // start write the image or save it actually on device
      await file.writeAsBytes(pngBytes!);

      // start share image
      Share.shareFiles([file.path],
          text: 'TradeBook User : ${_nameController.text}');
    } catch (error) {
      print(error);
    }
  }

  getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      uploadAndUpdate();
    } else {
      print('No Image Selected');
    }
  }

  uploadAndUpdate() async {
    setState(() => _uploading = true);
    _uploading = true;
    final _storage = FirebaseStorage.instance;
    var file = File(_image!.path);
    var snapshot = await _storage
        .ref()
        .child('usersPhotos/${auth.currentUser?.uid}')
        .putFile(file)
        .whenComplete(
          () => {
            () => _uploading = false,
            print('Upload Completed Successfully'),
          },
        );
    var downloadUrl = await snapshot.ref.getDownloadURL();
    DocumentReference reference =
        _service.db.collection('users').doc(auth.currentUser?.uid);
    reference.update({
      'photoUrl': downloadUrl,
    });
  }

  getUserProfileData() {
    DocumentReference reference =
        _service.db.collection('users').doc(auth.currentUser?.uid);
    reference.get().then(
          (doc) => {
            setState(() {
              var profileData = doc.data() as Map;
              if (doc.data() != null) {
                userPhotoUrl = profileData['photoUrl'];
                _nameController.text = profileData['displayName'];
                _emailController.text = profileData['email'];
                _phoneController.text = profileData['phone'];
              }
            })
          },
        );
  }

  customDisplayData({required Widget child}) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      );

  updateUserProfileData() {
    if (_editing == true) {
      DocumentReference reference =
          _service.db.collection('users').doc(auth.currentUser?.uid);
      reference.update({
        'displayName': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
      });
    }
  }
}
