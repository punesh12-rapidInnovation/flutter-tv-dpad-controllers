import 'package:flutter/material.dart';
import 'widgets/sidebar.dart';
import 'widgets/top_nav.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;

  const BaseLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF13141D),
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: Column(
              children: [
                TopNav(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 