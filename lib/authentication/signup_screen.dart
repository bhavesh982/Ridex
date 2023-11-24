import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login/authentication/login_screen.dart';
import 'package:login/authentication/email_verification.dart';
import 'package:login/commons/common_methods.dart';
import 'package:login/global/global_var.dart';
import 'package:login/widgets/loading_dialog.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();

}


class _SignUpScreenState extends State<SignUpScreen> {
  //Text Editors

  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _uNameController= TextEditingController();
  final TextEditingController _uPhoneController= TextEditingController();
  final TextEditingController _passwordController= TextEditingController();
  CommonMethods commonMethods= CommonMethods();
  //Methods

  checkInternetConnection() async {
  if(await commonMethods.checkConnectivity(context)){
    signUpFormValidation();
  }
  }
  signUpFormValidation(){
    if(_uNameController.text.trim().length<3){
      commonMethods.displaySnackBar("User name must be greater than 4 ", context);
    }
    else if(_uPhoneController.text.trim().length!=10){
      commonMethods.displaySnackBar("Enter valid phone number ", context);
    }
    else if(!_emailController.text.trim().contains("@")){
      commonMethods.displaySnackBar("Enter valid email ", context);
    }
    else if(_passwordController.text.trim().length<6){
      commonMethods.displaySnackBar("Password must be at least 6 characters ", context);
    }
    else{
      createNewUser();
    }
  }
  createNewUser() async{

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context)=>LoadingDialog
          (messageText: "Registering your account"));
    final User? userFirebase=(
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim())
        .catchError((errorMsg){
      Navigator.pop(context);
      commonMethods.displaySnackBar(errorMsg.toString(), context);
        })
    ).user;
    if(!context.mounted) return;
    Navigator.pop(context);
    DatabaseReference userRef=FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);
    setState(() {
      userRefAuth=userRef;
      commonMethods.displaySnackBar(userRefAuth.child("otp").toString(), context);
    });
    Map userDataMap={
      "uid" :  userFirebase.uid,
      "name": _uNameController.text.trim(),
      "email": _emailController.text.trim(),
      "phone": _uPhoneController.text.trim(),
      "blockstatus": "no",
    };
    userRef.set(userDataMap);
    User? user = FirebaseAuth.instance.currentUser;
    if (user!= null && !user.emailVerified) {
      userRef.set(userDataMap);
      await user.sendEmailVerification().whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (c)=>const  EmailVerification())));
    }
  }
  @override
  Widget build(BuildContext context) {
    return signUpContent(context);
  }

  Scaffold signUpContent(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff103232),
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
          const SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Image.asset("assets/logo.png",
                scale: 1,),
            ),
          ],),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    controller: _uNameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        labelText: "username"
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "email"
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      labelText: "password"
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _uPhoneController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Phone no."
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(onPressed: (){
                    checkInternetConnection();
                  }, child: const Text("SignUp")),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text("Already have an account ?"),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (c)=>const LoginScreen()));
                      }, child: const Text("Login here")),
                    ],
                  )
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
