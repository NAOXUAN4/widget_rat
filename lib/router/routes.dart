import 'package:go_router/go_router.dart';
import 'package:widget_rat/nav/nav.dart';


import '../pages/PostDetailPage/view.dart';
import '../pages/SearchPage/view.dart';
import '../pages/HomePage/view.dart';
import '../pages/CommunityPage/view.dart';
import '../pages/myPage/view.dart';
import '../pages/sectionsPage/view.dart';
import '../pages/testPage/view.dart';

final GoRouter approutes = GoRouter(
  routes: [     // 路由列表
    GoRoute(    //顶级路由
      path: '/',
      name: RouteNames.nav,
      builder: (context, state) => GenNav(),
      routes: [
        GoRoute(
          path: '/home',
          name: RouteNames.homePage,
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/community',
          name: RouteNames.forumPage,
          builder: (context, state) => CommunityPage(),

        ),
        GoRoute(
          path: '/postdetail/:postId',
          name: RouteNames.postdetailPage,
          builder: (context, state){
            final postId = state.pathParameters['postId'];
            return PostDetailPage(postId: postId ?? "0");
          }
        ),
        GoRoute(
          path: '/sections',
          name: RouteNames.sectionsPage,
          builder: (context, state) => SectionsPage(),
        ),
        GoRoute(
          path: '/my',
          name: RouteNames.myPage,
          builder: (context, state) => MyPage(),
        ),
        GoRoute(
          path: '/search',
          name: RouteNames.searchPage,
          builder: (context, state) => SearchPage(),
        ),
        GoRoute(
          path: '/test',
          name: RouteNames.testPage,
          builder: (context, state) => TestPage(),
        ),
      ],
    ),
  ],
);

class RouteNames {
  static const String nav = '/';
  static const String homePage = "/home";
  static const String forumPage = "/community";
  static const String postdetailPage = "/postdetail";
  static const String searchPage = "/search";
  static const String sectionsPage = "/sections";
  static const String myPage = "/my";
  static const String testPage = "/test";
}
