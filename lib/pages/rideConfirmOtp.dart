import 'dart:math';

import 'package:flutter/material.dart';
import 'package:login/commons/common_methods.dart';
import 'package:login/global/global_var.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
class RideConfirmOTP extends StatefulWidget {
  const RideConfirmOTP({super.key});
  @override
  State<RideConfirmOTP> createState() => _RideConfirmOTPState();
}

class _RideConfirmOTPState extends State<RideConfirmOTP> {
 CommonMethods commonMethods=CommonMethods();
 Random rand=Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff103232),
      appBar: AppBar(
        backgroundColor: const Color(0xff103232),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
                const SizedBox(height: 50,),
                const Padding(
                  padding: EdgeInsets.only(top: 40,left: 40),
                  child: ListTile(
                    title: Text("Secret code!",style: TextStyle(
                      fontSize: 22
                    ),),
                    subtitle: Text("for your journey."),
                  ),
                ),
              Container(height: 100,
                width: 100,
                child: Text(generatedOtp.toString(),style: const TextStyle(
                  fontSize: 35
                ),),
              ),
              const SizedBox(height: 150,)
            ],
        ),
      ),
    );
  }
}
