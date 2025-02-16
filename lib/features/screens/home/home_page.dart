import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sca_translator_app/core/utils/images.dart';
import 'package:sca_translator_app/features/screens/camera_translation/camera_translation_screen.dart';
import 'package:sca_translator_app/features/screens/favourite_page/favourite_page.dart';
import 'package:sca_translator_app/features/screens/voice_conversation/voice_conversation_screen.dart';

import '../../../core/theme/colors.dart';
import '../history/history_page.dart';
import 'home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentindex = 0;
  final screens = [
    VoiceConversationScreen(),
    CameraTranslationScreen(),
    HomeScreen(),
    HistoryPage(),
    FavouritePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        currentIndex: currentindex,
        type: BottomNavigationBarType.fixed,
        //fixedColor: AppColors.white,
        iconSize: 30,
        // selectedItemColor: AppColors.grey,
        // unselectedItemColor: AppColors.mainBae,
        onTap: (value) {
          currentindex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.chatIcon,
              ),
              label: "Chat"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppIcons.camIcon), label: "Camera"),
          BottomNavigationBarItem(
              icon: Container(
                  width: 49,
                  height: 49,
                  decoration: BoxDecoration(
                    color: AppColors.appbar,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: SvgPicture.asset(AppIcons.axIcon))),
              label: ""),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppIcons.historyIcon), label: "History"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppIcons.favIcon), label: "Favourite"),
        ],
      ),
      body: screens[currentindex],
    );
  }
}
