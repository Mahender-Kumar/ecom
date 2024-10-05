import 'dart:async';
import 'package:ecom/app_scaffold.dart';
import 'package:ecom/auth/login.dart';
import 'package:ecom/auth/sign_up.dart';
import 'package:ecom/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRouter {
  AppRouter._();
  static final instance = AppRouter._();

  static List<Map<String, dynamic>> navList = [
    {
      'icon': const Icon(Icons.home),
      'selectedIcon': const Icon(Icons.home),
      'label': 'Home',
      'path': '/',
    },
    {
      'icon': const Icon(Icons.home),
      'selectedIcon': const Icon(Icons.home),
      'label': 'Home',
      'path': '/',
    },
    // {
    //   'icon': const Icon(Icons.storefront_outlined),
    //   'selectedIcon': const Icon(Icons.storefront),
    //   'label': 'Explore',
    //   'path': '/explore',
    // },
    // {
    //   'icon': const Icon(Icons.account_box),
    //   'selectedIcon': const Icon(Icons.account_box),
    //   // 'label': 'Account',
    //   'path': '/account',
    // },
    // {
    //   'icon': const Icon(Icons.file_copy_outlined),
    //   'selectedIcon': const Icon(Icons.file_copy),
    //   'label': 'Help',
    //   'path': '/help',
    // }
  ];

  final _auth = FirebaseAuth.instance;

  late final router = GoRouter(
    refreshListenable: GoRouterRefreshStream(_auth.authStateChanges()),
    initialLocation: '/',
    redirect: (BuildContext context, GoRouterState state) {
      final loggedIn = _auth.currentUser != null;
      final goingToLogin = state.matchedLocation.startsWith('/login');
      final goingToRegister = state.matchedLocation.startsWith('/register');
      if (!loggedIn && goingToRegister) {
        return '/register';
      }
      if (!loggedIn && !goingToLogin) {
        return '/login?from=${state.matchedLocation}';
      }

      if (loggedIn && goingToLogin) return '/';

      return null;
    },
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          int index = navList.indexWhere(
            (e) => e['path'] != '/' && state.uri.path.startsWith(e['path']),
          );

          return AppScaffold(
            selectedIndex: index == -1 ? 0 : index,
            body: child,
            mobileNavs: 3,
            navList: navList,
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen(
                  // tag: 'all',
                  );
            },
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/register',
        builder: (BuildContext context, GoRouterState state) {
          return SignUpPage();
        },
      ),
    ],
  );
}
