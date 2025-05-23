import 'package:flutter/material.dart';
import 'base_layout.dart';
import 'screens/home_screen.dart';
import 'screens/library_page.dart';
import 'screens/account_page.dart';
import 'screens/login_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String library = '/library';
  static const String account = '/account';
  static const String login = '/login';
  // Add other static route names as needed

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
            builder: (_) => BaseLayout(key: ValueKey('home'), child: HomeScreen()), settings: settings);
      case library:
        return MaterialPageRoute(
            builder: (_) => BaseLayout(key: ValueKey('library'), child: const LibraryPage()), settings: settings);
      case account:
        return MaterialPageRoute(
            builder: (_) => BaseLayout(key: ValueKey('account'), child: const AccountPage()), settings: settings);
      case login:
        return MaterialPageRoute(
            builder: (_) => BaseLayout(key: ValueKey('login'), child: const LoginPage()), settings: settings);
      // Add more cases for other routes here
      default:
        return _errorRoute("Route not found");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: Center(child: Text(message)),
      ),
    );
  }
} 