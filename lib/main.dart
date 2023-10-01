import 'package:app_ui/pages/log_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:mysql1/mysql1.dart';
import 'package:app_ui/mysql/market_db.dart';

void main() async {
  // Initialize the database connection here
  final MySqlConnection connection = await Mysql().getConnection();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) =>
          MyApp(connection: connection), // Pass the connection to your app
    ),
  );
}

class MyApp extends StatelessWidget {
  final MySqlConnection connection; // Add a MySqlConnection property

  const MyApp({Key? key, required this.connection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFDEEFF9),
      ),
      home: Homescreen(
          connection: connection), // Pass the connection to your Homescreen
    );
  }
}
