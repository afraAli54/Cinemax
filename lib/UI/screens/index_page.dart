import 'package:cinemax/UI/screens/home_screen.dart';
import 'package:cinemax/UI/screens/profile_screen.dart';
import 'package:cinemax/UI/screens/search_screen.dart';
import 'package:cinemax/provider/page_provider.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
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
    int _currentPage = Provider.of<PageProvider>(context).currentPage;

    Widget currentPageWidget;
    switch (_currentPage) {
      case 0:
        currentPageWidget = HomeScreen();
        break;
      case 1:
        currentPageWidget = SearchScreen();
        break;
      case 2:
        currentPageWidget = Container();
        break;
      case 3:
        currentPageWidget = const ProfileScreen();
        break;
      default:
        currentPageWidget = Container();
        break;
    }

    return Scaffold(
      body: currentPageWidget,
      bottomNavigationBar: CubertoBottomBar(
        barBackgroundColor: AppColors.primaryDark,
        key: const Key("BottomBar"),
        inactiveIconColor: AppColors.primaryBlue,
        selectedTab: _currentPage,
        tabs: tabs,
        onTabChangedListener: (position, title, color) {
          Provider.of<PageProvider>(context, listen: false)
              .setCurrentPage(position, title);
        },
      ),
    );
  }
}
