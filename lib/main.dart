import 'package:ecom/app_router.dart';
import 'package:ecom/constants.dart';
import 'package:ecom/firebase_options.dart';
import 'package:ecom/screens/theme/button_theme.dart';
import 'package:ecom/screens/theme/checkbox_themedata.dart';
import 'package:ecom/screens/theme/input_decoration_theme.dart';
import 'package:ecom/screens/theme/theme_data.dart';
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
      theme:ThemeData(
      brightness: Brightness.light,
      fontFamily: "Plus Jakarta",
      primarySwatch: primaryMaterialColor,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: blackColor),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: blackColor40),
      ),
      elevatedButtonTheme: elevatedButtonThemeData,
      textButtonTheme: textButtonThemeData,
      outlinedButtonTheme: outlinedButtonTheme(),
      inputDecorationTheme: lightInputDecorationTheme,
      checkboxTheme: checkboxThemeData.copyWith(
        side: const BorderSide(color: blackColor40),
      ),
      appBarTheme: appBarLightTheme,
      scrollbarTheme: scrollbarThemeData,
      dataTableTheme: dataTableLightThemeData,
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
