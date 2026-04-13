// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appTitle => 'విద్యాలక్ష్మి';

  @override
  String get startLearning => 'నేర్చుకోవడం ప్రారంభించండి';

  @override
  String get continueQuest => 'ప్రయాణం కొనసాగించండి';

  @override
  String get skillTreeTitle => 'నైపుణ్య చెట్టు';

  @override
  String streakDays(int count) {
    return '$count రోజుల స్ట్రీక్';
  }

  @override
  String lCoins(int count) {
    return '$count ఎల్-కాయిన్లు';
  }

  @override
  String get jingleTitle => 'పాట నేర్పు';

  @override
  String get jingleSkip => 'దాటవేయి';

  @override
  String get jingleContinue => 'కొనసాగు';

  @override
  String get bossFightTitle => 'బాస్ పోరాటం';

  @override
  String get bossFightDragInstruction => 'సరిపోల్చడానికి లాగండి';

  @override
  String get bossFightTapInstruction => 'సరైన సమాధానం నొక్కండి';

  @override
  String livesRemaining(int count) {
    return '$count జీవితాలు మిగిలి ఉన్నాయి';
  }

  @override
  String get correct => 'సరైనది!';

  @override
  String get wrong => 'మళ్ళీ ప్రయత్నించండి!';

  @override
  String get rewardTitle => 'అద్భుతం!';

  @override
  String get rewardSubtitle => 'మీరు సంపాదించారు';

  @override
  String get rewardContinue => 'ప్రయాణం కొనసాగించండి';

  @override
  String get rewardCustomize => 'మెంటర్‌ని అనుకూలీకరించండి';

  @override
  String get scrollTitle => 'మీ చీట్ షీట్';

  @override
  String get scrollDownload => 'PDF డౌన్‌లోడ్ చేయండి';

  @override
  String get profileTitle => 'నా ప్రొఫైల్';

  @override
  String get settingsLanguage => 'భాష';

  @override
  String get settingsEnglish => 'ఇంగ్లీష్';

  @override
  String get settingsTelugu => 'తెలుగు';

  @override
  String get settingsHindi => 'హిందీ';

  @override
  String get mentorZayn => 'జేన్';

  @override
  String get mentorArya => 'ఆర్య';

  @override
  String get mentorDhara => 'ధర';

  @override
  String get mentorSubjectPhysics => 'భౌతిక & సాంకేతిక';

  @override
  String get mentorSubjectMath => 'గణిత & తర్కం';

  @override
  String get mentorSubjectBio => 'జీవ & సామాజిక';

  @override
  String get topicLocked => 'లాక్';

  @override
  String get topicComplete => 'పూర్తి';

  @override
  String get topicAvailable => 'ప్రారంభించు';

  @override
  String get errorGeneral => 'ఏదో తప్పు జరిగింది. మళ్ళీ ప్రయత్నించండి.';

  @override
  String get loading => 'లోడవుతోంది...';
}
