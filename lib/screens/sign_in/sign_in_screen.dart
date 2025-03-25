import 'package:flutter/material.dart';
import 'package:me_super_admin/controller/authentication/login_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Sign In Screen'),
      resizeToAvoidBottomInset: true,
    );
  }
}
