import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sca_translator_app/core/theme/colors.dart';
import 'package:sca_translator_app/core/utils/images.dart';
import 'package:sca_translator_app/features/screens/home/home_page.dart';
import 'package:sca_translator_app/features/screens/home/home_screen.dart';
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
              EnglishSpanishContainer(
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
