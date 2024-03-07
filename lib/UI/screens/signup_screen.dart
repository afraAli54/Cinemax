import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:cinemax/UI/widgets/custom_appbar.dart';
import 'package:cinemax/UI/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;
  bool isChecked = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _useremailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
    return Scaffold(
      appBar: const CustomAppBar(
        text: "Sign Up",
      ),
      backgroundColor: AppColors.primaryDark,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
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
                textController: _usernameController,
              ),
              CustomTextField(
                labelText: 'Email Address',
                hintText: 'Enter Your Email',
                textController: _useremailController,
              ),
              CustomTextField(
                labelText: 'Password',
                hintText: 'Enter Your Password',
                isPassword: true,
                textController: _passwordController,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                  onPressed: () {},
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
    );
  }
}
