import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homeLayout/homeLayout.dart';
import 'modules/login/loginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      final FirebaseAuth auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        Get.to(() => const HomeLayout());
      } else {
        Get.to(() => const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SizedBox(
          height: height,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/main_top.png',
                  width: width * 0.3,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/main_bottom.png',
                  width: width * 0.4,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Trade Book',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.purple,
                              fontFamily: 'XB_Zar',
                            ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/appstore.gif',
                      width: width * 0.4,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
