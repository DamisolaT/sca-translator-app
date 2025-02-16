import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sca_translator_app/core/theme/colors.dart';
import 'package:sca_translator_app/core/utils/images.dart';

class CameraTranslationScreen extends StatefulWidget {
  const CameraTranslationScreen({super.key});

  @override
  State<CameraTranslationScreen> createState() =>
      _CameraTranslationScreenState();
}

class _CameraTranslationScreenState extends State<CameraTranslationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          backgroundColor: AppColors.appbar,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              AppIcons.backIcon,
            ),
          ),
          title: Text(
            "Camera Translation",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.white),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(child: Image.asset(AppImages.previewImg)),
                    GestureDetector(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.appbar,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 4),
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      AppIcons.flashOffIcon,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
