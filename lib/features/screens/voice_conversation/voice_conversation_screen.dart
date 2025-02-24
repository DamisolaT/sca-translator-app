import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sca_translator_app/core/theme/colors.dart';
import 'package:sca_translator_app/core/utils/images.dart';
import 'package:sca_translator_app/features/screens/home/home_page.dart';
import 'package:sca_translator_app/services/speech_to_text_service.dart';

class VoiceConversationScreen extends StatefulWidget {
  const VoiceConversationScreen({super.key});

  @override
  State<VoiceConversationScreen> createState() =>
      _VoiceConversationScreenState();
}

class _VoiceConversationScreenState extends State<VoiceConversationScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final speechService =
        Provider.of<SpeechToTextService>(context, listen: false);
    speechService.addListener(() {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final speechService = Provider.of<SpeechToTextService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appbar,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              AppIcons.backIcon,
            ),
          ),
        ),
        title: Text(
          "Voice Conversation",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                  itemCount: speechService.messages.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final message = speechService.messages[index];
                    return VoiceCard(
                      message: message["text"],
                      translation: message["translation"],
                      language: message["language"],
                    );
                  },
                ),
              ),
              SpeechTranslationContainer(
                englishImage: AppIcons.englishMicIcon,
                spanishImage: AppIcons.spanishMicIcon,
                imagePadding: EdgeInsets.all(4.0),
                onEnglishMicTap: () =>
                    speechService.startListening('en-US', 'es', true),
                onSpanishMicTap: () =>
                    speechService.startListening('es-ES', 'en', false),
                speakingEnglish: speechService.isSpeakingEnglish,
                speakingSpanish: speechService.isSpeakingSpanish,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VoiceCard extends StatelessWidget {
  const VoiceCard({
    super.key,
    required this.message,
    required this.translation,
    required this.language,
  });

  final String message;
  final String translation;
  final String language;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 0.6;

    return Align(
      alignment:
          language == 'es' ? Alignment.centerLeft : Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: IntrinsicWidth(
          child: Card(
            elevation: 1.5,
            color: AppColors.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: AppColors.appbar,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.left,
                      softWrap: true,
                    ),
                  ),
                  Divider(color: AppColors.grey),
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Text(
                      translation,
                      style: TextStyle(color: AppColors.orange, fontSize: 14),
                      textAlign: TextAlign.left,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SpeechTranslationContainer extends StatelessWidget {
  const SpeechTranslationContainer({
    super.key,
    required this.englishImage,
    required this.spanishImage,
    this.imagePadding = const EdgeInsets.all(12.0),
    this.onEnglishMicTap,
    this.onSpanishMicTap,
    this.speakingEnglish = false,
    this.speakingSpanish = false,
  });
  final String englishImage;
  final String spanishImage;
  final EdgeInsets imagePadding;
  final VoidCallback? onEnglishMicTap;
  final VoidCallback? onSpanishMicTap;
  final bool speakingEnglish;
  final bool speakingSpanish;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: 320,
        height: 47,
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // English Section
            Padding(
              padding: imagePadding,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onEnglishMicTap,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(
                              begin: 0.0, end: speakingEnglish ? 1.0 : 0.0),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          builder: (context, value, child) {
                            return Container(
                              padding: value > 0
                                  ? EdgeInsets.all(value * 2)
                                  : EdgeInsets.zero,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.appbar
                                      .withAlpha((value * 120).toInt()),
                                  width: value > 0 ? 2 : 0,
                                ),
                              ),
                              child: child,
                            );
                          },
                          child: SvgPicture.asset(englishImage),
                        ),
                      ],
                    ),
                  ),
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
                  child: GestureDetector(
                    onTap: onSpanishMicTap,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(
                              begin: 0.0, end: speakingSpanish ? 1.0 : 0.0),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          builder: (context, value, child) {
                            return Container(
                              padding: value > 0
                                  ? EdgeInsets.all(value * 2)
                                  : EdgeInsets.zero,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.orange
                                      .withAlpha((value * 120).toInt()),
                                  width: value > 0 ? 2 : 0,
                                ),
                              ),
                              child: child,
                            );
                          },
                          child: SvgPicture.asset(spanishImage),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
