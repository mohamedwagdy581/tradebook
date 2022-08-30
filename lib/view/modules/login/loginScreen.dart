import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tradebook/view/modules/login/phoneAuthScreen.dart';

import '../../../model/firebaseServices.dart';
import '../../../widgets/components.dart';
import '../../homeLayout/homeLayout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(children: [
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
          /*const Expanded(
            child: SizedBox(),
          ),*/
          Column(
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              Center(
                child: Image.asset(
                  'assets/images/appstore.png',
                  width: width / 2,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              const Text(
                'Login with : ',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              defaultSigningInRowButton(
                rowBackgroundColor: Colors.teal,
                title: 'Login with Phone',
                titleStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                width: 30.0,
                icon: FontAwesomeIcons.phone,
                iconColor: Colors.white,
                onPressed: () {
                  Get.to(() => const PhoneAuthScreen());
                },
              ),
              defaultSigningInRowButton(
                rowBackgroundColor: Colors.amber,
                title: 'Login with Google',
                titleStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                width: 30.0,
                icon: FontAwesomeIcons.google,
                iconColor: Colors.white,
                onPressed: () {
                  firebaseService.googleSignIn(context);
                },
              ),
              defaultSigningInRowButton(
                title: 'Sign in with Apple',
                titleStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                width: 30,
                icon: FontAwesomeIcons.apple,
                onPressed: () {},
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Container(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                alignment: Alignment.centerRight,
                child: defaultTextButton(
                  onPressed: () {
                    Get.to(() => const HomeLayout());
                  },
                  text: 'SKIP',
                  textColor: Colors.purple,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
