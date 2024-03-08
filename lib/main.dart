import 'package:cinemax/UI/screens/fav_screen.dart';
import 'package:cinemax/UI/screens/movie_details.dart';
import 'package:cinemax/bloc/login_bloc/login_bloc.dart';
import 'package:cinemax/bloc/movie_bloc/movie_bloc.dart';
import 'package:cinemax/domain/usecase/login_usecase.dart';
import 'package:cinemax/domain/usecase/movies_usecase.dart';
import 'package:cinemax/firebase_options.dart';
import 'package:cinemax/UI/screens/create_new_password.dart';
import 'package:cinemax/UI/screens/home_screen.dart';
import 'package:cinemax/UI/screens/login_screen.dart';
import 'package:cinemax/UI/screens/profile_screen.dart';
import 'package:cinemax/UI/screens/reset_password_screen.dart';
import 'package:cinemax/UI/screens/search_screen.dart';
import 'package:cinemax/UI/screens/signup_screen.dart';
import 'package:cinemax/UI/screens/onboarding_screen.dart';
import 'package:cinemax/UI/screens/login_sign_up_screen.dart';
import 'package:cinemax/UI/screens/splash_screen.dart';
import 'package:cinemax/UI/screens/index_page.dart';
import 'package:cinemax/provider/page_provider.dart';
import 'package:cinemax/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool shouldShowOnboarding = true;

  @override
  void initState() {
    super.initState();
    checkOnboardingStatus();
  }

  Future<void> checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasShownOnboarding = prefs.getBool('hasShownOnboarding') ?? false;
    setState(() {
      shouldShowOnboarding = !hasShownOnboarding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PageProvider>(create: (_) => PageProvider()),
        ChangeNotifierProvider<UsernameProvider>(
          create: (_) => UsernameProvider(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(loginUseCase: LoginUseCase()),
          ),
          BlocProvider<MoviesBloc>(
            create: (context) => MoviesBloc(MovieUseCase()),
          ),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: shouldShowOnboarding ? Onboarding() : SplashScreen(),
          routes: {
            '/home': (context) => HomeScreen(),
            '/search': (context) => SearchScreen(),
            '/splashPage': (context) => const SplashScreen(),
            '/signUpPage': (context) => const SignupScreen(),
            '/loginPage': (context) => LoginScreen(),
            '/login-SignUpPage': (context) => const LoginSignUpScreen(),
            '/resetPassword': (context) => ResetPasswordScreen(),
            '/createPassword': (context) => CreatePassword(),
            '/indexPage': (context) => IndexPage(),
            '/profileScreen': (context) => const ProfileScreen(),
          },
        ),
      ),
    );
  }
}
