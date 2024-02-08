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
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;
  bool isChecked = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  String? email, password, userName;

  void toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is SignUpLoading) {
        isLoading = true;
      } else if (state is SignUpSuccess) {
        Navigator.pushReplacementNamed(context, '/home');
        isLoading = false;
      } else if (state is SignUpFailure) {
        context.showSnackBar(context, state.errMessege);
        isLoading = false;
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          appBar: const CustomAppBar(
            text: "Sign Up",
          ),
          backgroundColor: AppColors.primaryDark,
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Let’s get started",
                    style: typography.h2SemiBold.copyWith(color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Text(
                      "The latest movies and series are here",
                      style: typography.h6Medium.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 60),
                  CustomTextField(
                    labelText: 'Full Name',
                    hintText: 'Enter Your Name',
                    onChanged: (data) {
                      userName = data;
                    },
                  ),
                  CustomTextField(
                    labelText: 'Email Address',
                    hintText: 'Enter Your Email',
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  CustomTextField(
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    isPassword: true,
                    obscureText: true,
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: toggleCheckbox,
                            child: Container(
                              width: 24,
                              height: 24,
                              child: isChecked
                                  ? SvgPicture.asset(
                                      'assets/images/Radio.svg',
                                      fit: BoxFit.contain,
                                    )
                                  : SvgPicture.asset(
                                      'assets/images/Checkbox.svg',
                                      fit: BoxFit.contain,
                                    ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "I agree to the Terms and Services and Privacy Policy",
                            style: typography.h6Medium
                                .copyWith(color: AppColors.textGrey),
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
                        if (formKey.currentState!.validate()) {
                          print("sign UP");
                          BlocProvider.of<AuthBloc>(context).add(SignUpEvent(
                            userName: userName!,
                            email: email!,
                            password: password!,
                          ));
                        }
                        ;
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 57, 170, 178)),
                      ),
                      child: Text("Sign UP",
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
