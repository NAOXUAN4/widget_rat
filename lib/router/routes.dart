import 'package:go_router/go_router.dart';
import 'package:widget_rat/nav/nav.dart';

import '../pages/SearchPage/index.dart';
import '../pages/HomePage/index.dart';
import '../pages/forumPage/index.dart';
import '../pages/myPage/index.dart';
import '../pages/sectionsPage/index.dart';

final GoRouter approutes = GoRouter(
  routes: [     // 路由列表
    GoRoute(    //顶级路由
      path: '/',
      name: RouteNames.nav,
      builder: (context, state) => GenNav(),
      routes: [
        GoRoute(
          path: 'homePage',
          name: RouteNames.homePage,
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: 'forumPage',
          name: RouteNames.forumPage,
          builder: (context, state) => ForumPage(),
        ),
        GoRoute(
          path: 'sectionsPage',
          name: RouteNames.sectionsPage,
          builder: (context, state) => SectionsPage(),
        ),
        GoRoute(
          path: 'myPage',
          name: RouteNames.myPage,
          builder: (context, state) => MyPage(),
        ),
        GoRoute(
          path: 'searchPage',
          name: RouteNames.searchPage,
          builder: (context, state) => SearchPage(),
        ),
      ],
    ),
  ],
);

class RouteNames {
  static const String nav = '/';
  static const String homePage = "homePage";
  static const String forumPage = "forumPage";
  static const String searchPage = "searchPage";
  static const String sectionsPage = "sectionsPage";
  static const String myPage = "myPage";
}
