import 'package:flutter/material.dart';
import 'app.dart';

Future<void> main() async {
  try {
    // Ensure Flutter is initialized
    WidgetsFlutterBinding.ensureInitialized();

    runApp(App());
  } catch (e) {
    print('Fatal error during initialization: $e');
    // You might want to show an error screen or handle this differently
    rethrow;
  }
}
