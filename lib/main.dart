import 'package:cinemax/bloc/login_bloc/auth_bloc.dart';
import 'package:cinemax/firebase_options.dart';
import 'package:cinemax/screens/create_new_password.dart';
import 'package:cinemax/screens/home_screen.dart';
import 'package:cinemax/screens/login_screen.dart';
import 'package:cinemax/screens/reset_password_screen.dart';
import 'package:cinemax/screens/signup_screen.dart';
import 'package:cinemax/screens/onboarding_screen.dart';
import 'package:cinemax/screens/login_sign_up_screen.dart';
import 'package:cinemax/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Onboarding(),
        routes: {
          '/home': (context) => HomeScreen(),
          '/splashPage': (context) => const SplashScreen(),
          '/signUpPage': (context) => const SignupScreen(),
          '/loginPage': (context) => LoginScreen(),
          '/login-SignUpPage': (context) => const LoginSignUpScreen(),
          '/resetPassword': (context) => const ResetPasswordScreen(),
          '/createPassword': (context) => const CreatePassword(),
        },
      ),
    );
  }
}
