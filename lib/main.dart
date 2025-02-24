import 'package:flutter/material.dart';
import 'package:sca_translator_app/services/speech_to_text_service.dart';
import 'config/route_strings.dart';
import 'config/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => SpeechToTextService()),
      ],
      child: const MyApp(),
    ),
  );
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
