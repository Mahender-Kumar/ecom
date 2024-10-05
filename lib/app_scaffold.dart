import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.selectedIndex,
    required this.body,
    this.secondaryBody,
    this.mobileNavs = 4,
    required this.navList,
  });

  final Widget body;
  final Widget? secondaryBody;
  final int selectedIndex;
  final int mobileNavs;
  final List<Map<String, dynamic>> navList;
 

 
  @override
  Widget build(BuildContext context) {
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
                      child: Text('v1.0.0', style: Theme.of(context).textTheme.bodySmall),
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
            builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
              destinations: [
                ...navList.take(mobileNavs).map(
                      (e) => NavigationDestination(
                        icon: e['icon'],
                        selectedIcon: e['selectedIcon'],
                        label: '',
                      ),
                    ),
                if (navList.length > mobileNavs)
                  const NavigationDestination(
                    icon: Icon(Icons.more_horiz_outlined),
                    selectedIcon: Icon(Icons.more_horiz),
                    label: '',
                  ),
              ],
              currentIndex: selectedIndex >= mobileNavs ? mobileNavs : selectedIndex,
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
