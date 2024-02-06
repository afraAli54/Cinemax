import 'package:cinemax/screens/create_new_password.dart';
import 'package:cinemax/screens/login_screen.dart';
import 'package:cinemax/screens/reset_password_screen.dart';
import 'package:cinemax/screens/signup_screen.dart';
import 'package:cinemax/screens/onboarding_screen.dart';
import 'package:cinemax/screens/login_sign_up_screen.dart';
import 'package:cinemax/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Onboarding(),
      routes: {
        'splashPage': (context) => const SplashScreen(),
        'signUpPage': (context) => const SignupScreen(),
        'loginPage': (context) => const LoginScreen(),
        'login-SignUpPage': (context) => const LoginSignUpScreen(),
        'resetPassword': (context) => const ResetPasswordScreen(),
        'createPassword': (context) => const CreatePassword(),
      },
    );
  }
}
