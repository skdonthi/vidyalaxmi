// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'VidyaLaxmi';

  @override
  String get startLearning => 'Start Learning';

  @override
  String get continueQuest => 'Continue Quest';

  @override
  String get skillTreeTitle => 'Skill Tree';

  @override
  String streakDays(int count) {
    return '$count Day Streak';
  }

  @override
  String lCoins(int count) {
    return '$count L-Coins';
  }

  @override
  String get jingleTitle => 'Concept Song';

  @override
  String get jingleSkip => 'Skip';

  @override
  String get jingleContinue => 'Continue';

  @override
  String get bossFightTitle => 'Boss Fight';

  @override
  String get bossFightDragInstruction => 'Drag to match';

  @override
  String get bossFightTapInstruction => 'Tap the correct answer';

  @override
  String livesRemaining(int count) {
    return '$count lives remaining';
  }

  @override
  String get correct => 'Correct!';

  @override
  String get wrong => 'Try Again!';

  @override
  String get rewardTitle => 'Quest Complete!';

  @override
  String get rewardSubtitle => 'You earned';

  @override
  String get rewardContinue => 'Continue Quest';

  @override
  String get rewardCustomize => 'Customize Mentor';

  @override
  String get scrollTitle => 'Your Cheat Sheet';

  @override
  String get scrollDownload => 'Download PDF';

  @override
  String get profileTitle => 'My Profile';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsEnglish => 'English';

  @override
  String get settingsTelugu => 'Telugu';

  @override
  String get settingsHindi => 'Hindi';

  @override
  String get mentorZayn => 'Zayn';

  @override
  String get mentorArya => 'Arya';

  @override
  String get mentorDhara => 'Dhara';

  @override
  String get mentorSubjectPhysics => 'Physics & Tech';

  @override
  String get mentorSubjectMath => 'Math & Logic';

  @override
  String get mentorSubjectBio => 'Bio & Social';

  @override
  String get topicLocked => 'Locked';

  @override
  String get topicComplete => 'Complete';

  @override
  String get topicAvailable => 'Start';

  @override
  String get errorGeneral => 'Something went wrong. Try again.';

  @override
  String get loading => 'Loading...';
}
