import 'package:flutter/cupertino.dart';
import 'package:sca_translator_app/config/route_strings.dart';
import 'package:sca_translator_app/features/screens/camera_translation/camera_translation_screen.dart';
import 'package:sca_translator_app/features/screens/history/history_page.dart';
import 'package:sca_translator_app/features/screens/home/home_screen.dart';
import '../features/screens/home/home_page.dart';
import '../features/screens/splash/splash_screen.dart';
import '../features/screens/voice_conversation/voice_conversation_screen.dart';

class AppRouter {
  static final navKey = GlobalKey<NavigatorState>();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteStrings.base:
        return CupertinoPageRoute(builder: (_) => SplashScreen());
      case AppRouteStrings.homePage:
        return CupertinoPageRoute(builder: (_) => HomePage());
      case AppRouteStrings.homeScreen:
        return CupertinoPageRoute(builder: (_) => HomeScreen());
      case AppRouteStrings.historyPage:
        return CupertinoPageRoute(builder: (_) => HistoryPage());
      case AppRouteStrings.voiceConversationScreen:
        return CupertinoPageRoute(builder: (_) => VoiceConversationScreen());
      case AppRouteStrings.cameraTranslationScreen:
        return CupertinoPageRoute(builder: (_) => CameraTranslationScreen());
      default:
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
