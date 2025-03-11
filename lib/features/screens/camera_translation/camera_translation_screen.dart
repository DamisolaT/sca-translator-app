import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sca_translator_app/core/theme/colors.dart';
import 'package:sca_translator_app/core/utils/images.dart';
import 'package:sca_translator_app/features/screens/home/home_screen.dart';

class CameraTranslationScreen extends StatefulWidget {
  const CameraTranslationScreen({super.key});

  @override
  State<CameraTranslationScreen> createState() =>
      _CameraTranslationScreenState();
}

class _CameraTranslationScreenState extends State<CameraTranslationScreen> {
  File? _image;
  final ImagePicker imagePicker = ImagePicker();

  Future<void> getImage() async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

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
        child: Column(
          children: [
            _image == null ? Text("No Image selected") : Image.file(_image!),
            EnglishSpanishContainer(
              englishImage: AppIcons.engLogo,
              spanishImage: AppIcons.spanLogo,
            ),
            Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(child: Image.asset(AppImages.previewImg)),
                  GestureDetector(
                    onTap: getImage,
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
      ),
    );
  }
}
