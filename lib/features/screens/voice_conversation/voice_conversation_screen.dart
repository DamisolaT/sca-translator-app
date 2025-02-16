import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sca_translator_app/core/theme/colors.dart';
import 'package:sca_translator_app/core/utils/images.dart';
import 'package:sca_translator_app/features/screens/home/home_screen.dart';

class VoiceConversationScreen extends StatefulWidget {
  const VoiceConversationScreen({super.key});

  @override
  State<VoiceConversationScreen> createState() =>
      _VoiceConversationScreenState();
}

class _VoiceConversationScreenState extends State<VoiceConversationScreen> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> messages = [
      {
        "text": "Hello how are you?",
        "translation": "¿Hola como estas?",
        "isSender": false
      },
      {"text": "Hola", "translation": "Hello", "isSender": true},
      {
        "text": "Hello how are you?",
        "translation": "¿Hola como estas?",
        "isSender": false
      },
      {"text": "Hola", "translation": "Hello", "isSender": true},
      {
        "text": "Hello how are you?",
        "translation": "¿Hola como estas?",
        "isSender": false
      },
      {"text": "Hola", "translation": "Hello", "isSender": true},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appbar,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SvgPicture.asset(
            AppIcons.backIcon,
          ),
        ),
        title: Text(
          "Voice Conversation",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.white),
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
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                  itemCount: messages.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return VoiceCard(
                      message: message["text"],
                      translation: message["translation"],
                      isSender: message["isSender"],
                    );
                  },
                ),
              ),
              EnglishSpanishContainer(
                englishImage: AppIcons.englishMicIcon,
                spanishImage: AppIcons.spanishMicIcon,
                imagePadding: EdgeInsets.all(4.0),
              )
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
    required this.isSender,
  });

  final String message;
  final String translation;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 0.6;

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
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
                    padding: const EdgeInsets.only(right: 45.0),
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
                    padding: const EdgeInsets.only(right: 45.0),
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

// class VoiceCard extends StatelessWidget {
//   const VoiceCard({
//     super.key,
//     required this.message,
//     required this.translation,
//     required this.isSender,
//   });
//
//   final String message;
//   final String translation;
//   final bool isSender;
//
//   @override
//   Widget build(BuildContext context) {
//     double maxWidth = MediaQuery.of(context).size.width * 0.6;
//
//     return Row(
//       mainAxisAlignment:
//           isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         Container(
//           child: IntrinsicWidth(
//             child: Card(
//               elevation: 3,
//               color: AppColors.cardColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(11),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(18),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 16.0, right: 55.0),
//                       child: Text(
//                         message,
//                         style: TextStyle(
//                           color: AppColors.appbar,
//                           fontSize: 14,
//                         ),
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                     Divider(
//                       color: AppColors.grey,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 16.0, right: 55.0),
//                       child: Text(
//                         translation,
//                         style: TextStyle(color: AppColors.orange, fontSize: 14),
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
