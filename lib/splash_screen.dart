import 'package:final_project/data/sp_helper.dart';
import 'package:final_project/providers/auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  navigateFun(BuildContext context) async {
    String? userType = await SpHelper.spHelper.getUserType();

    await Future.delayed(Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Provider.of<AppAuthProvider>(context, listen: false).userType = userType;

    // ignore: use_build_context_synchronously
    Provider.of<AppAuthProvider>(context, listen: false).checkUser(userType);
  }

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    navigateFun(context);
    return Scaffold(
      body: Center(child: Image(image: AssetImage("assets/doctor.png"))),
    );
  }
}
