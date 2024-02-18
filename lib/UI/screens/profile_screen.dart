import 'package:cinemax/UI/screens/login_sign_up_screen.dart';
import 'package:cinemax/bloc/profile_bloc/profile_bloc.dart';
import 'package:cinemax/bloc/profile_bloc/profile_event.dart';
import 'package:cinemax/bloc/profile_bloc/profile_state.dart';
import 'package:cinemax/domain/usecase/profile_usecase.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc _profileBloc;

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionId');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginSignUpScreen()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    _profileBloc = ProfileBloc(profileUseCase: ProfileUseCase());
    _profileBloc.add(FetchUserDataEvent());
  }

  @override
  void dispose() {
    _profileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Profile',
          style: typography.h4SemiBold.copyWith(color: AppColors.textWhite),
        ),
      ),
      backgroundColor: AppColors.primaryDark,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: _profileBloc,
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoadedState) {
            final user = state.user;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 20),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 300,
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/profile-picture.png'),
                              radius: 27,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    user.username,
                                    style: typography.h4SemiBold
                                        .copyWith(color: AppColors.textWhite),
                                  ),
                                  Text(
                                    '${user.username}@gmail.com',
                                    style: typography.h6Medium
                                        .copyWith(color: AppColors.textGrey),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 70,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 32,
                                height: 32,
                                color: AppColors.primarySoft,
                                child: SvgPicture.asset(
                                  "assets/images/Edit.svg",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 400,
                      ),
                      GestureDetector(
                        onTap: () => _logout(context),
                        child: Container(
                          width: 327,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.primaryDark,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.primaryBlue,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Log Out',
                              style: typography.h4SemiBold
                                  .copyWith(color: AppColors.primaryBlue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is ProfileErrorState) {
            return Center(child: Text('Error fetching user data'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
