// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'विद्यालक्ष्मी';

  @override
  String get startLearning => 'सीखना शुरू करें';

  @override
  String get continueQuest => 'यात्रा जारी रखें';

  @override
  String get skillTreeTitle => 'कौशल वृक्ष';

  @override
  String streakDays(int count) {
    return '$count दिन की स्ट्रीक';
  }

  @override
  String lCoins(int count) {
    return '$count एल-कॉइन';
  }

  @override
  String get jingleTitle => 'कॉन्सेप्ट गाना';

  @override
  String get jingleSkip => 'छोड़ें';

  @override
  String get jingleContinue => 'जारी रखें';

  @override
  String get bossFightTitle => 'बॉस फाइट';

  @override
  String get bossFightDragInstruction => 'मिलाने के लिए खींचें';

  @override
  String get bossFightTapInstruction => 'सही उत्तर टैप करें';

  @override
  String livesRemaining(int count) {
    return '$count जीवन बचे हैं';
  }

  @override
  String get correct => 'सही!';

  @override
  String get wrong => 'फिर कोशिश करें!';

  @override
  String get rewardTitle => 'क्वेस्ट पूरी!';

  @override
  String get rewardSubtitle => 'आपने कमाया';

  @override
  String get rewardContinue => 'यात्रा जारी रखें';

  @override
  String get rewardCustomize => 'मेंटर कस्टमाइज़ करें';

  @override
  String get scrollTitle => 'आपकी चीट शीट';

  @override
  String get scrollDownload => 'PDF डाउनलोड करें';

  @override
  String get profileTitle => 'मेरी प्रोफाइल';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsEnglish => 'अंग्रेज़ी';

  @override
  String get settingsTelugu => 'तेलुगू';

  @override
  String get settingsHindi => 'हिंदी';

  @override
  String get mentorZayn => 'ज़ैन';

  @override
  String get mentorArya => 'आर्या';

  @override
  String get mentorDhara => 'धरा';

  @override
  String get mentorSubjectPhysics => 'भौतिकी और तकनीक';

  @override
  String get mentorSubjectMath => 'गणित और तर्क';

  @override
  String get mentorSubjectBio => 'जीव विज्ञान और सामाजिक';

  @override
  String get topicLocked => 'लॉक्ड';

  @override
  String get topicComplete => 'पूर्ण';

  @override
  String get topicAvailable => 'शुरू करें';

  @override
  String get errorGeneral => 'कुछ गलत हो गया। फिर कोशिश करें।';

  @override
  String get loading => 'लोड हो रहा है...';
}
