import 'package:ecom/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.currentPath,
    required this.body,
    this.secondaryBody,
    this.mobileNavs = 5,
  });

  final Widget body;
  final String currentPath;
  final Widget? secondaryBody;
  final int mobileNavs;

  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        colorFilter: ColorFilter.mode(
            color ??
                Theme.of(context).iconTheme.color!.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
            BlendMode.srcIn),
      );
    }

    List<Map<String, dynamic>> navList = [
      {
        'icon': svgIcon("assets/icons/Shop.svg"),
        'selectedIcon': svgIcon("assets/icons/Shop.svg", color: primaryColor),
        'label': 'Home',
        'path': '/',
      },
      {
        'icon': svgIcon("assets/icons/Category.svg"),
        'selectedIcon':
            svgIcon("assets/icons/Category.svg", color: primaryColor),
        'label': 'Discover',
        'path': '/discover',
      },
      {
        'icon': svgIcon("assets/icons/Bookmark.svg"),
        'selectedIcon': svgIcon("assets/icons/Bookmark.svg"),
        'label': 'Bookmarks',
        'path': '/bookmarks',
      },
      {
        'icon': svgIcon("assets/icons/Bag.svg"),
        'selectedIcon': svgIcon("assets/icons/Bag.svg", color: primaryColor),
        'label': 'Cart',
        'path': '/cart',
      },
      {
        'icon': svgIcon("assets/icons/Profile.svg"),
        'selectedIcon':
            svgIcon("assets/icons/Profile.svg", color: primaryColor),
        'label': 'Profile',
        'path': '/profile',
      }
    ];
    int index = navList.indexWhere(
      (e) => e['path'] != '/' && currentPath.startsWith(e['path']),
    );
    int selectedIndex = index == -1 ? 0 : index;

    return AdaptiveLayout(
      bodyRatio: 70,
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.smallAndUp: SlotLayout.from(
            key: const Key('Body All'),
            builder: (_) => body,
          ),
        },
      ),
      bottomNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.smallAndUp: SlotLayout.from(
            key: const Key('Bottom Navigation Small'),
            builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
              destinations: [
                ...navList.take(mobileNavs).map(
                      (e) => NavigationDestination(
                          icon: e['icon'],
                          selectedIcon: e['selectedIcon'],
                          label: e['label']),
                    ),
              ],
              currentIndex:
                  selectedIndex >= mobileNavs ? mobileNavs : selectedIndex,
              onDestinationSelected: (index) {
                if (index == mobileNavs) {
                } else {
                  GoRouter.of(context).go(navList[index]['path'] ?? '/');
                }
              },
            ),
          )
        },
      ),
    );
  }
}
