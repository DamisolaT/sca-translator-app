import 'package:flutter/cupertino.dart';
import 'package:sca_translator_app/config/route_strings.dart';

import '../features/screens/splash/splash_screen.dart';

class AppRouter {
  static final navKey = GlobalKey<NavigatorState>();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteStrings.base:
        return CupertinoPageRoute(builder: (_) => SplashScreen());

      default:
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
