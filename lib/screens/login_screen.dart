import 'package:cinemax/bloc/login_bloc/auth_bloc.dart';
import 'package:cinemax/bloc/login_bloc/auth_event.dart';
import 'package:cinemax/bloc/login_bloc/auth_state.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:cinemax/widgets/custom_appbar.dart';
import 'package:cinemax/widgets/custom_text_field.dart';
import 'package:cinemax/widgets/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //const LoginScreen({super.key});
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String? email, password;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveSession(String sessionId) async {
    await sharedPreferences.setString('session_id', sessionId);
  }

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is LoginLoading) {
        isLoading = true;
      } else if (state is LoginSuccess) {
        saveSession(state.sessionId);
        Navigator.pushReplacementNamed(context, '/home');
        isLoading = false;
      } else if (state is LoginFailure) {
        context.showSnackBar(context, state.errorMessege);
        isLoading = false;
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          appBar: const CustomAppBar(
            text: "Login",
          ),
          backgroundColor: AppColors.primaryDark,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Hi , Tiffany",
                    style: typography.h2SemiBold.copyWith(color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Text(
                      "Welcome back! Please enter your details.",
                      style: typography.h6Medium.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 70),
                  CustomTextField(
                    labelText: 'Email Address',
                    hintText: 'Enter Your Email',
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  CustomTextField(
                    onChanged: (data) {
                      password = data;
                    },
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    isPassword: true,
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/resetPassword');
                            },
                            child: Text(
                              "Forget Password?",
                              style: typography.h6Medium
                                  .copyWith(color: AppColors.primaryBlue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 60,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () async {
                        //print(email);
                        //print(password);
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                              LoginEvent(email: email!, password: password!));
                        } else {}
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.primaryBlue),
                      ),
                      child: Text("Login",
                          style: typography.h3Medium
                              .copyWith(color: AppColors.textWhite)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
