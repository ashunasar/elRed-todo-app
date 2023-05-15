import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/modules/auth/view/auth.view.dart';
import 'package:todoapp/modules/home/view/home.view.dart';

import '../../../gen/assets.gen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        User? userId = FirebaseAuth.instance.currentUser;
        if (userId == null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AuthView()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeView()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Assets.icons.elRedLogo.svg(width: 100),
                  SizedBox(height: 20.h),
                  Text('Todo App',
                      style: theme.textTheme.displaySmall!
                          .copyWith(color: Colors.black))
                ]))));
  }
}
