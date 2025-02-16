import 'package:flutter/material.dart';

import 'config/route_strings.dart';
import 'config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(scrolledUnderElevation: 0),
        useMaterial3: true,
      ),
      navigatorKey: AppRouter.navKey,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouteStrings.base,
    );
  }
}
