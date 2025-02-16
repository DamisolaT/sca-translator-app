import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sca_translator_app/core/theme/colors.dart';
import 'package:sca_translator_app/core/utils/images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appbar,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SvgPicture.asset(
            AppIcons.menuLogo,
          ),
        ),
        title: Text(
          "language Translator,",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.white),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            EnglishSpanishContainer(
              englishImage: AppIcons.engLogo,
              spanishImage: AppIcons.spanLogo,
            ),
            SizedBox(
              height: 20,
            ),
            LanguageContainer(
              language: 'English',
              cancelIcon: true,
              translateContainer: true,
              monogram: true,
            ),
            SizedBox(
              height: 20,
            ),
            LanguageContainer(
              language: 'Spanish',
              cancelIcon: false,
              translateContainer: false,
              monogram: false,
            ),
          ],
        ),
      )),
    );
  }
}
class EnglishSpanishContainer extends StatelessWidget {
  const EnglishSpanishContainer({
    super.key,
    required this.englishImage,
    required this.spanishImage,
    this.imagePadding = const EdgeInsets.all(12.0),
  });
  final String englishImage;
  final String spanishImage;
  final EdgeInsets imagePadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: 320,
        height: 47,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // English Section
            Padding(
              padding: imagePadding,
              child: Row(
                children: [
                  SvgPicture.asset(englishImage),
                  SizedBox(width: 8),
                  Text(
                    "English",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),

            Center(child: SvgPicture.asset(AppIcons.arLogo)),
            Row(
              children: [
                Text(
                  "Spanish",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.black,
                  ),
                ),
                Padding(
                  padding: imagePadding,
                  child: SvgPicture.asset(spanishImage),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageContainer extends StatelessWidget {
  const LanguageContainer({
    super.key,
    required this.language,
    this.cancelIcon = false,
    this.translateContainer = false,
    this.monogram = false,
  });
  final String language;
  final bool cancelIcon;
  final bool translateContainer;
  final bool monogram;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 17,
            ),
            Row(
              children: [
                Text(
                  language,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appbar),
                ),
                SizedBox(
                  width: 11,
                ),
                SvgPicture.asset(AppIcons.speakerIcon),
                Spacer(),
                if (cancelIcon) SvgPicture.asset(AppIcons.exitIcon)
              ],
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter text here...",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: AppColors.lightGrey,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 89,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (monogram) SvgPicture.asset(AppIcons.monogramIcon),
                Spacer(),
                if (translateContainer)
                  Container(
                    width: 108,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        "Translate",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.materialIcon),
                      SizedBox(
                        width: 20,
                      ),
                      SvgPicture.asset(AppIcons.shareIcon),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: AppColors.white,
                                  child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              AppImages.ratingImage,
                                              height: 140,
                                              width: 140,
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              "Did you enjoy our app?",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "Please rate your experience \nso we can improve further",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.grey,
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: List.generate(
                                                5,
                                                (index) => Icon(
                                                  Icons.star_border,
                                                  color: Colors.black,
                                                  size: 32,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 24),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .lightGrey,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          AppColors.buttonColor,
                                                      minimumSize:
                                                          Size(115, 40),
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: Text(
                                                      "Exit",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              AppColors.white),
                                                    ),
                                                  ),
                                                ])
                                          ])));
                            },
                          );
                        },
                        child: SvgPicture.asset(AppIcons.starIcon),
                      )
                    ],
                  )
              ],
            ),
            SizedBox(
              height: 19,
            )
          ],
        ),
      ),
    );
  }
}
