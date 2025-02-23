import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sca_translator_app/core/theme/colors.dart';
import 'package:sca_translator_app/core/utils/images.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: ListView(
        children: [
          SizedBox(
            height: 40,
          ),
          SvgPicture.asset(AppIcons.appLogo),
          SizedBox(
            height: 21,
          ),
          Center(
            child: Text(
              "TRANSLATE ON THE GO",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: AppColors.black),
            ),
          ),
          SizedBox(
            height: 91,
          ),
          ListTile(
            leading: SvgPicture.asset(AppIcons.shareApp),
            title: Text(
              "Share App",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(AppIcons.rate),
            title: Text(
              "Rate Us",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(AppIcons.privacy),
            title: Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(AppIcons.feedBack),
            title: Text(
              "Feedback",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
