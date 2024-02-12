import 'package:cinemax/screens/home_screen.dart';
import 'package:cinemax/screens/search_screen.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
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
    return Scaffold(
      body: _getPage(_currentPage),
      bottomNavigationBar: CubertoBottomBar(
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
        },
      ),
    );
  }

  Widget _getPage(int page) {
    switch (page) {
      case 0:
        return HomeScreen();
      case 1:
        return SearchScreen();
      // Add cases for other pages here
      default:
        return Container(); // Return an empty container if the page is not found
    }
  }
}
