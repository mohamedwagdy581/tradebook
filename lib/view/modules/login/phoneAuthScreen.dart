import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tradebook/view/modules/login/otpScreen.dart';
import 'package:tradebook/widgets/components.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  late final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  String phoneNumber = 'Phone Number';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 50.0,
                        bottom: 30.0,
                      ),
                      child: Text(
                        phoneNumber,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    defaultTextFormField(
                      maxLength: 10,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      label: 'Enter your Phone',
                      onChange: (String? value) {
                        setState(() {
                          if (value == '') {
                            phoneNumber = 'Phone Number';
                          } else {
                            phoneNumber = '+966- ${value!}';
                          }
                        });
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Phone number';
                        }
                        return null;
                      },
                      prefix: FontAwesomeIcons.phone,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: defaultButton(
                  backgroundColor: Colors.teal[700],
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.to(() => OTPScreen(phone: _phoneController.text));
                    }
                  },
                  text: 'Verify',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
