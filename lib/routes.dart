import 'package:blog_app/global_resources.dart';
import 'package:blog_app/view/screens/dashboard.dart';
import 'package:blog_app/view/screens/myBlogs/myBlogs.dart';
import 'package:blog_app/view/screens/login.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case rLogin:
        return MaterialPageRoute(builder: (_) => Login());
      case rDashboard:
        return MaterialPageRoute(builder: (_) => Dashboard());

      default:
        return null;
    }
  }
}
