import 'package:blog_app/global_resources.dart';
import 'package:blog_app/provider/loadingProvider.dart';
import 'package:blog_app/routes.dart';
import 'package:blog_app/view/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LoadingProvider())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Media Player',
      theme: ThemeData(
        appBarTheme: AppBarTheme(),
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
      ),
      initialRoute: rDashboard,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
