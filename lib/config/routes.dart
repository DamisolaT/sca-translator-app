import 'package:flutter/cupertino.dart';
import 'package:sca_translator_app/config/route_strings.dart';
import 'package:sca_translator_app/features/screens/home/home_screen.dart';

import '../features/screens/splash/splash_screen.dart';

class AppRouter {
  static final navKey = GlobalKey<NavigatorState>();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRouteStrings.base:
      //   return CupertinoPageRoute(builder: (_) => SplashScreen());
      case AppRouteStrings.base:
        return CupertinoPageRoute(builder: (_) => HomeScreen());

      default:
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
