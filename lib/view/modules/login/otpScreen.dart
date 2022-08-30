import 'package:flutter/material.dart';
import 'package:tradebook/widgets/components.dart';
import 'package:tradebook/widgets/constants/appBrain.dart';

class OTPScreen extends StatefulWidget {
  final String phone;

  const OTPScreen({
    super.key,
    required this.phone,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  void initState() {
    firebaseService.verifyPhone(context, widget.phone);
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
          title: const Text('Verification'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                top: 50.0,
                bottom: 30.0,
              ),
              child: Text(
                '+966- ${widget.phone}',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const RoundedPinPut(),
          ],
        ),
      ),
    );
  }
}
