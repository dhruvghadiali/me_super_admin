import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/controller/authentication/sign_in_controller.dart';
import 'package:me_super_admin/widget/screen/sign_in/sign_in_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());

  @override
  void initState() {
    signInController.checkActiveUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SignInWidget(), resizeToAvoidBottomInset: true);
  }
}
