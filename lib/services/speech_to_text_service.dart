import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';

class SpeechToTextService with ChangeNotifier {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final GoogleTranslator _translator = GoogleTranslator();

  bool _isSpeakingEnglish = false;
  bool _isSpeakingSpanish = false;
  bool _isListening = false;

  List<Map<String, dynamic>> _messages = [];
  Timer? _stopListeningTimer;

  // Getters
  bool get isSpeakingEnglish => _isSpeakingEnglish;
  bool get isSpeakingSpanish => _isSpeakingSpanish;
  bool get isListening => _isListening;
  List<Map<String, dynamic>> get messages => _messages;

  // Start listening
  Future<void> startListening(String languageCode, String targetLanguage, bool isEnglish) async {

    if (_isListening) {
      print("Already listening...");
      return;
    }

    bool available = await _speech.initialize();
    if (available) {
      _isSpeakingEnglish = isEnglish;
      _isSpeakingSpanish = !isEnglish;
      _isListening = true;
      notifyListeners();

      print("Listening in $languageCode");

      _speech.listen(
        localeId: languageCode,
        onResult: (result) async {
          if (result.recognizedWords.isNotEmpty) {
            String spokenText = result.recognizedWords;
            String liveTranslation = await _translateText(spokenText, targetLanguage);

            if (_messages.isEmpty || _messages.last["isLive"] == false) {
              _messages.add({
                "text": spokenText,
                "translation": liveTranslation,
                "language": targetLanguage,
                "isLive": true,
              });
            } else {
              _messages.last["text"] = spokenText;
              _messages.last["translation"] = liveTranslation;
            }

            notifyListeners();
            _resetStopListeningTimer(targetLanguage);
          }

          if (result.finalResult) {
            await _finalizeTranslation(result.recognizedWords, targetLanguage);
          }
        },
      );

      _resetStopListeningTimer(targetLanguage);
    }
  }

  // Live translation updates
  Future<String> _translateText(String text, String targetLanguage) async {
    var translation = await _translator.translate(text, to: targetLanguage);
    return translation.text;
  }

  // Finalize last message
  Future<void> _finalizeTranslation(String text, String targetLanguage) async {
    String translation = await _translateText(text, targetLanguage);

    if (_messages.isNotEmpty && _messages.last["isLive"] == true) {
      _messages.last["text"] = text;
      _messages.last["translation"] = translation;
      _messages.last["isLive"] = false;
      notifyListeners();
    }
  }

  // Stop listening after inactivity
  void _resetStopListeningTimer(String targetLanguage) {
    _stopListeningTimer?.cancel();
    _stopListeningTimer = Timer(Duration(seconds: 3), () {
      if (_speech.isListening) {
        stopListening();
      }
    });
  }

  // Stop listening
  Future<void> stopListening() async {
    await _speech.stop();
    _isListening = false;
    _isSpeakingEnglish = false;
    _isSpeakingSpanish = false;

    if (_messages.isNotEmpty && _messages.last["isLive"] == true) {
      await _finalizeTranslation(_messages.last["text"], _messages.last["language"]);
    }

    notifyListeners();
    print("Stopped listening");
  }

  // Clear messages
  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
