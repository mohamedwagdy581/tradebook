import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'constants/appBrain.dart';

class RoundedPinPut extends StatelessWidget {
  const RoundedPinPut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Pinput(
        length: 6,
        defaultPinTheme: const PinTheme(
          textStyle: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
          ),
          width: 45.0,
          height: 65.0,
        ),
        focusNode: pinPutFocusNode,
        controller: pinPutController,
        focusedPinTheme: PinTheme(
          decoration: pinPutDecoration,
          width: 45.0,
          height: 65.0,
        ),
        submittedPinTheme: PinTheme(
          decoration: pinPutDecoration,
          width: 45.0,
          height: 65.0,
        ),
        followingPinTheme: PinTheme(
          decoration: pinPutDecoration,
          width: 45.0,
          height: 65.0,
        ),
        pinAnimationType: PinAnimationType.fade,
        onSubmitted: (pin) async {
          firebaseService.verifyOTP(context, pin);
        },
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        onCompleted: (pin) => print(pin),
      ),
    );
  }
}

// Reusable Navigate Function and return to the previous screen
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

// Reusable Navigate Function and remove the previous screen
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

// Reusable TextFormField Function with validator
Widget defaultTextFormField({
  required TextEditingController? controller,
  required TextInputType keyboardType,
  required String? label,
  TextStyle? textStyle,
  VoidCallback? onTap,
  required String? Function(String?)? validator,
  Function(String)? onSubmitted,
  Function(String)? onChange,
  bool secure = false,
  required IconData? prefix,
  Color? prefixColor,
  IconData? suffix,
  Color? suffixColor,
  VoidCallback? suffixPressed,
  bool? isClickable,
  int? maxLength,
}) =>
    TextFormField(
      maxLength: maxLength,
      style: textStyle,
      controller: controller,
      keyboardType: keyboardType,
      onTap: onTap,
      onChanged: onChange,
      enabled: isClickable,
      validator: validator,
      obscureText: secure,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
          color: prefixColor,
        ),
        suffixIcon: IconButton(
          icon: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 10.0),
            child: Icon(suffix),
          ),
          onPressed: suffixPressed,
          color: suffixColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );

// Default Signing Row Button
Widget defaultSigningInRowButton({
  required String title,
  TextStyle? titleStyle,
  required double width,
  required IconData icon,
  Color iconColor = Colors.black,
  Color rowBackgroundColor = Colors.white,
  required VoidCallback onPressed,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 6.0,
      ),
      child: MaterialButton(
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: rowBackgroundColor,
        onPressed: onPressed,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
            SizedBox(
              width: width,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: titleStyle,
              ),
            ),
          ],
        ),
      ),
    );

Widget defaultButton({
  required VoidCallback onPressed,
  required String text,
  Color? backgroundColor,
}) =>
    Container(
      height: 50.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.blue,
      ),
      child: MaterialButton(
        color: backgroundColor,
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );

// Default TextButton
Widget defaultTextButton({
  required VoidCallback onPressed,
  required String text,
  Color? textColor,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );

// Default ListTile
Widget defaultListTile({
  VoidCallback? onTap,
  IconData? leadingIcon,
  Color? leadingIconColor,
  IconData? trailingIcon,
  Color? trailingIconColor,
  required String title,
  TextStyle textStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
}) =>
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          leadingIcon,
          color: leadingIconColor,
        ),
        title: Text(
          title,
          style: textStyle,
        ),
        trailing: Icon(
          trailingIcon,
          color: trailingIconColor,
        ),
      ),
    );

Widget userRoundedPic({
  required photoSize,
  required onPressed,
  dynamic image,
}) =>
    Stack(
      children: [
        Container(
          width: photoSize,
          height: photoSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: image,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: IconButton(
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.blue,
            ),
            iconSize: 37,
            onPressed: onPressed,
          ),
        ),
      ],
    );

Widget customCard({
  backgroundColor,
  required VoidCallback onPressed,
  required double iconSize,
  required IconData icon,
  required String txt,
  iconColor,
}) =>
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: onPressed,
          child: Card(
            child: (Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                IconButton(
                  color: iconColor,
                  onPressed: onPressed,
                  iconSize: iconSize,
                  icon: Icon(icon),
                ),
                const Spacer(),
                Text(
                  txt,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'XB_Zar',
                    fontSize: iconSize / 3,
                  ),
                ),
                const Spacer(),
              ],
            )),
          ),
        ),
      ),
    );
