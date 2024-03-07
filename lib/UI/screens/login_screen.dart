import 'package:cinemax/UI/widgets/show_snack_bar.dart';
import 'package:cinemax/bloc/login_bloc/login_bloc.dart';
import 'package:cinemax/bloc/login_bloc/login_event.dart';
import 'package:cinemax/bloc/login_bloc/login_state.dart';
import 'package:cinemax/domain/usecase/login_usecase.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:cinemax/UI/widgets/custom_appbar.dart';
import 'package:cinemax/UI/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //const LoginScreen({super.key});
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(loginUseCase: LoginUseCase());
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    return Scaffold(
      appBar: const CustomAppBar(
        text: "Login",
      ),
      backgroundColor: AppColors.primaryDark,
      body: BlocConsumer<LoginBloc, LoginState>(
          bloc: _loginBloc,
          listener: (contect, state) {
            if (state is LoginLoading) {
              isLoading = true;
            } else if (state is LoginSuccess) {
              //print(sessionId);
              Navigator.pushReplacementNamed(
                context,
                '/indexPage',
              );
              isLoading = false;
            } else if (state is LoginFailure) {
              context.showSnackBar(context, state.error);
              isLoading = false;
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Hi",
                        style:
                            typography.h2SemiBold.copyWith(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: Text(
                          "Welcome back! Please enter your details.",
                          style:
                              typography.h6Medium.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 70),
                      CustomTextField(
                        labelText: 'User Name',
                        hintText: 'Enter Your UserNAme',
                        textController: _usernameController,
                        isPassword: false,
                      ),
                      CustomTextField(
                        textController: _passwordController,
                        labelText: 'Password',
                        hintText: 'Enter Your Password',
                        isPassword: true,
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
                                  Navigator.pushNamed(
                                      context, '/resetPassword');
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
                          onPressed: () {
                            final username = _usernameController.text;
                            final password = _passwordController.text;

                            _loginBloc.add(LoginButton(
                                username: username, password: password));
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
            );
          }),
    );
  }
}
