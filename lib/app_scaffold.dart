import 'package:ecom/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        'selectedIcon':   svgIcon("assets/icons/Shop.svg", color: primaryColor),
        'label': 'Home',
        'path': '/',
      },
      {
        'icon': svgIcon("assets/icons/Category.svg"),
        'selectedIcon':   svgIcon("assets/icons/Category.svg", color: primaryColor),
        'label': 'Discover',
        'path': '/discover',
      },
      {
        'icon':  svgIcon("assets/icons/Bookmark.svg"),
        'selectedIcon':  svgIcon("assets/icons/Bookmark.svg"),
        'label': 'Bookmarks',
        'path': '/bookmarks',
      },
      {
        'icon':  svgIcon("assets/icons/Bag.svg"),
        'selectedIcon':  svgIcon("assets/icons/Bag.svg", color: primaryColor),
        'label': 'Cart',
        'path': '/cart',
      },
      {
        'icon':  svgIcon("assets/icons/Profile.svg"),
        'selectedIcon': svgIcon("assets/icons/Profile.svg", color: primaryColor),
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
      primaryNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.mediumAndUp: SlotLayout.from(
            // inAnimation: AdaptiveScaffold.leftOutIn,
            key: const Key('Primary Navigation Medium'),
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              leading: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Image.asset(
                  'assets/images/jaya_logo.png',
                  height: 40,
                  width: 40,
                ),
              ),
              width: 88,
              trailing: Expanded(
                child: Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('v1.0.0',
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(0),
              destinations: navList
                  .map(
                    (e) => NavigationRailDestination(
                      icon: e['icon'],
                      selectedIcon: e['selectedIcon'],
                      label: const Text(''),
                    ),
                  )
                  .toList(),
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                if (navList[index]['path'] == '/logout') {
                  FirebaseAuth.instance.signOut();
                  return;
                }

                GoRouter.of(context).go(navList[index]['path'] ?? '/');
              },
              labelType: NavigationRailLabelType.all,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.12),
            ),
          ),
        },
      ),
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
          Breakpoints.small: SlotLayout.from(
            key: const Key('Bottom Navigation Small'),
            builder: (_) => 
            // BottomNavigationBar(
            //   currentIndex: _currentIndex,
            //   onTap: (index) {
            //     if (index != _currentIndex) {
            //       setState(() {
            //         _currentIndex = index;
            //       });
            //     }
            //   },
            //   backgroundColor: Theme.of(context).brightness == Brightness.light
            //       ? Colors.white
            //       : const Color(0xFF101015),
            //   type: BottomNavigationBarType.fixed,
            //   // selectedLabelStyle: TextStyle(color: primaryColor),
            //   selectedFontSize: 12,
            //   // selectedItemColor: primaryColor,
            //   unselectedItemColor: Colors.transparent,
            //   items: [
            //     BottomNavigationBarItem(
            //       icon: svgIcon("assets/icons/Shop.svg"),
            //       activeIcon:
            //           svgIcon("assets/icons/Shop.svg", color: primaryColor),
            //       label: "Shop",
            //     ),
            //     BottomNavigationBarItem(
            //       icon: svgIcon("assets/icons/Category.svg"),
            //       activeIcon:
            //           svgIcon("assets/icons/Category.svg", color: primaryColor),
            //       label: "Discover",
            //     ),
            //     BottomNavigationBarItem(
            //       icon: svgIcon("assets/icons/Bookmark.svg"),
            //       activeIcon:
            //           svgIcon("assets/icons/Bookmark.svg", color: primaryColor),
            //       label: "Bookmark",
            //     ),
            //     BottomNavigationBarItem(
            //       icon: svgIcon("assets/icons/Bag.svg"),
            //       activeIcon:
            //           svgIcon("assets/icons/Bag.svg", color: primaryColor),
            //       label: "Cart",
            //     ),
            //     BottomNavigationBarItem(
            //       icon: svgIcon("assets/icons/Profile.svg"),
            //       activeIcon:
            //           svgIcon("assets/icons/Profile.svg", color: primaryColor),
            //       label: "Profile",
            //     ),
            //   ],
            // ),
            AdaptiveScaffold.standardBottomNavigationBar(
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
