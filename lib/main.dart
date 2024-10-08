import 'package:ecom/app_router.dart';
import 'package:ecom/constants.dart';
import 'package:ecom/firebase_options.dart';
 
import 'package:ecom/services/auth_service.dart';
import 'package:ecom/services/product_service.dart';
import 'package:ecom/services/remote_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(providers: [
      Provider<FirebaseAuthMethods>(
        create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
      ),
      ChangeNotifierProvider(
        create: (_) => ProductProvider(),
      ),
      ChangeNotifierProvider(create: (_) => RemoteConfigService()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dummy Ecom',
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: "Plus Jakarta",
        primarySwatch: primaryMaterialColor,
        primaryColor: primaryColor,
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black54,
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(defaultPadding),
            minimumSize: const Size(double.infinity, 32),
            side: const BorderSide(width: 1.5, color: blackColor10),
            shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(defaultBorderRadious)),
            ),
          ),
        ),
        dataTableTheme: DataTableThemeData(
          dataRowMaxHeight: double.infinity,
          headingRowColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.primaryContainer,
          ),
          headingRowHeight: 36,
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          dataTextStyle: const TextStyle(
            fontSize: 12,
          ),
          dataRowMinHeight: 36,
          columnSpacing: 16,
        ),
        tabBarTheme: const TabBarTheme(
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xff0161a4),
                width: 2,
              ),
            ),
            color: Color(0xffd1e4ff),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: color1,
          brightness: Brightness.light,
        ),
        navigationBarTheme: NavigationBarThemeData(
          // elevation: 8,
          shadowColor: color1,
          overlayColor: const WidgetStatePropertyAll(color4),
          backgroundColor: Colors.white,
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 12,
              color: color2,
              fontWeight: FontWeight.w500,
            ),
          ),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          indicatorColor: Colors.transparent,
        ),
        visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
        scaffoldBackgroundColor: Colors.white,
        // navigationRailTheme: const NavigationRailThemeData(
        //   indicatorColor: Color(0xff0161a4),
        //   selectedIconTheme: IconThemeData(color: Colors.white),
        // ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: color1,
          brightness: Brightness.dark,
        ),
        visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
        scaffoldBackgroundColor: Colors.black,
        // navigationRailTheme: const NavigationRailThemeData(
        //   indicatorColor: Color(0xff0161a4),
        //   selectedIconTheme: IconThemeData(color: Colors.black),
        // ),
      ),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.instance.router,
    );
  }
}
