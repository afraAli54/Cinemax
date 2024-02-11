import 'package:cinemax/screens/search_screen.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  //const BottomNavigationBarWidget({Key key}) : super(key: key);

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentPage = 0;
  String _currentTitle = "";

  List<TabData> tabs = [
    TabData(
      title: 'Home',
      iconData: Icons.home,
      tabColor: AppColors.primaryBlue,
    ),
    TabData(
      title: 'Search',
      iconData: Icons.search,
    ),
    TabData(
      title: 'Downloads',
      iconData: Icons.download,
    ),
    TabData(
      title: 'Profile',
      iconData: Icons.person,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentTitle = tabs[0].title;
  }

  @override
  Widget build(BuildContext context) {
    return CubertoBottomBar(
      barBackgroundColor: AppColors.primaryDark,
      key: const Key("BottomBar"),
      inactiveIconColor: AppColors.primaryBlue,
      selectedTab: _currentPage,
      tabs: tabs,
      onTabChangedListener: (position, title, color) {
        setState(() {
          _currentPage = position;
          _currentTitle = title;
        });

        if (title == 'Search') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SearchScreen()),
          );
        }
      },
    );
  }
}
