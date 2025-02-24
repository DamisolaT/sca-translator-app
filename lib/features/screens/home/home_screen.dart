import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:sca_translator_app/core/theme/colors.dart';
import 'package:sca_translator_app/core/utils/images.dart';
import 'package:sca_translator_app/features/screens/home/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String translatedText = 'Translation';

  void updateTranslation(String text) {
    setState(() {
      translatedText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.appbar,
        title: Text(
          "Language Translator",
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
              SizedBox(height: 20),
              EnglishSpanishContainer(
                englishImage: AppIcons.engLogo,
                spanishImage: AppIcons.spanLogo,
              ),
              SizedBox(height: 20),
              LanguageContainer(
                language: 'English',
                cancelIcon: true,
                translateContainer: true,
                monogram: true,
                removeTextField: false,
                onTranslate: updateTranslation, // Pass the callback
              ),
              SizedBox(height: 20),
              LanguageContainer(
                language: 'Spanish',
                cancelIcon: false,
                translateContainer: false,
                monogram: false,
                removeTextField: true,
                translatedText: translatedText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EnglishSpanishContainer extends StatefulWidget {
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
  State<EnglishSpanishContainer> createState() =>
      _EnglishSpanishContainerState();
}

class _EnglishSpanishContainerState extends State<EnglishSpanishContainer> {
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
              padding: widget.imagePadding,
              child: Row(
                children: [
                  SvgPicture.asset(widget.englishImage),
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
                  padding: widget.imagePadding,
                  child: SvgPicture.asset(widget.spanishImage),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageContainer extends StatefulWidget {
  const LanguageContainer({
    super.key,
    required this.language,
    this.cancelIcon = false,
    this.translateContainer = false,
    this.monogram = false,
    this.removeTextField = false,
    this.translatedText,
    this.onTranslate,
  });

  final String language;
  final bool cancelIcon;
  final bool translateContainer;
  final bool monogram;
  final bool removeTextField;
  final String? translatedText;
  final Function(String)? onTranslate;

  @override
  State<LanguageContainer> createState() => _LanguageContainerState();
}

class _LanguageContainerState extends State<LanguageContainer> {
  final TextEditingController _controller = TextEditingController();

  Future<void> translateText() async {
    if (_controller.text.isEmpty) return;

    const apiKey = "AIzaSyAFBj69KQSOkyQYKS1Y1lZEcJBMmoWfIu8";
    const to = "es"; // Spanish

    final Uri url = Uri.https(
      "translation.googleapis.com",
      "/language/translate/v2",
      {
        "q": _controller.text,
        "target": to,
        "key": apiKey,
      },
    );

    final response = await http.post(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<dynamic> translations = body['data']['translations'];

      if (translations.isNotEmpty) {
        final translation =
            HtmlUnescape().convert(translations.first["translatedText"]);

        if (widget.onTranslate != null) {
          widget.onTranslate!(translation);
        }
      }
    } else {
      print("Error: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 17),

            // Language & Icons Row
            Row(
              children: [
                Text(
                  widget.language,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appbar),
                ),
                SizedBox(width: 11),
                SvgPicture.asset(AppIcons.speakerIcon), // Speaker icon
                Spacer(),
                if (widget.cancelIcon)
                  SvgPicture.asset(AppIcons.exitIcon), // Exit icon
              ],
            ),

            SizedBox(height: 16),

            // TextField or Translated Text
            if (!widget.removeTextField)
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Enter text here...",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: AppColors.lightGrey,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              )
            else
              Text(
                widget.translatedText ?? "Translation",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.appbar,
                ),
              ),

            SizedBox(height: 89),

            // Monogram & Translate Button Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.monogram) SvgPicture.asset(AppIcons.monogramIcon),
                Spacer(),
                if (widget.translateContainer)
                  GestureDetector(
                    onTap: translateText,
                    child: Container(
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
                    ),
                  ),
              ],
            ),

            SizedBox(height: 16),

            if (!widget.translateContainer) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(AppIcons.materialIcon),
                  SizedBox(
                    width: 20,
                  ),
                  SvgPicture.asset(AppIcons.shareIcon),
                  SizedBox(
                    width: 20,
                  ), // Share icon
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: AppColors.lightGrey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.buttonColor,
                                          minimumSize: Size(115, 40),
                                        ),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text(
                                          "Exit",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: SvgPicture.asset(AppIcons.starIcon),
                  ),
                ],
              ),
            ],

            SizedBox(height: 19),
          ],
        ),
      ),
    );
  }
}
