import 'package:ecom/app_router.dart';
import 'package:ecom/firebase_options.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dummy Ecom',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.instance.router,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
 