import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';


import '../common/style/theme.dart';
import '../pages/HomePage/view.dart';
import '../pages/myPage/view.dart';
import '../pages/CommunityPage/view.dart';
import '../pages/sectionsPage/view.dart';
import '../pages/testPage/view.dart';
class GenNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GenNavState();
}

class _GenNavState extends State<GenNav> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 2);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Theme.of(context).colorScheme.background , // Change this to your preferred color
      handleAndroidBackButtonPress: true, // Default true
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default true.
      stateManagement: true, // Default is true.
      decoration: NavBarDecoration(
        colorBehindNavBar: Color(0xff5e2987),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style you like
    );
  }

  List<Widget> _buildScreens() {  // 返回页面列表
    return [
      TestPage(),
      HomePage(),
      CommunityPage(),
      SectionsPage(),
      MyPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {   // 返回底部导航栏列表
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.exit_to_app_sharp),
        title: ("Test"),
        activeColorPrimary: Theme.of(context).colorScheme.secondary,
        activeColorSecondary: Theme.of(context).colorScheme.secondary,
        inactiveColorPrimary: Theme.of(context).colorScheme.primary,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Theme.of(context).colorScheme.secondary,
        activeColorSecondary: Theme.of(context).colorScheme.secondary,
        inactiveColorPrimary: Theme.of(context).colorScheme.primary,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.forum),
        title: ("Community"),
        activeColorPrimary: Theme.of(context).colorScheme.secondary,
        activeColorSecondary: Theme.of(context).colorScheme.secondary,
        inactiveColorPrimary: Theme.of(context).colorScheme.primary,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.grid_view_rounded),
        title: ("Sections"),
        activeColorPrimary: Theme.of(context).colorScheme.secondary,
        activeColorSecondary: Theme.of(context).colorScheme.secondary,
        inactiveColorPrimary: Theme.of(context).colorScheme.primary,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_box),
        title: ("My"),
        activeColorPrimary: Theme.of(context).colorScheme.secondary,
        activeColorSecondary: Theme.of(context).colorScheme.secondary,
        inactiveColorPrimary: Theme.of(context).colorScheme.primary,
      ),
    ];
  }
}
