import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('te')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'VidyaLaxmi'**
  String get appTitle;

  /// No description provided for @startLearning.
  ///
  /// In en, this message translates to:
  /// **'Start Learning'**
  String get startLearning;

  /// No description provided for @continueQuest.
  ///
  /// In en, this message translates to:
  /// **'Continue Quest'**
  String get continueQuest;

  /// No description provided for @skillTreeTitle.
  ///
  /// In en, this message translates to:
  /// **'Skill Tree'**
  String get skillTreeTitle;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{count} Day Streak'**
  String streakDays(int count);

  /// No description provided for @lCoins.
  ///
  /// In en, this message translates to:
  /// **'{count} L-Coins'**
  String lCoins(int count);

  /// No description provided for @jingleTitle.
  ///
  /// In en, this message translates to:
  /// **'Concept Song'**
  String get jingleTitle;

  /// No description provided for @jingleSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get jingleSkip;

  /// No description provided for @jingleContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get jingleContinue;

  /// No description provided for @bossFightTitle.
  ///
  /// In en, this message translates to:
  /// **'Boss Fight'**
  String get bossFightTitle;

  /// No description provided for @bossFightDragInstruction.
  ///
  /// In en, this message translates to:
  /// **'Drag to match'**
  String get bossFightDragInstruction;

  /// No description provided for @bossFightTapInstruction.
  ///
  /// In en, this message translates to:
  /// **'Tap the correct answer'**
  String get bossFightTapInstruction;

  /// No description provided for @livesRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} lives remaining'**
  String livesRemaining(int count);

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// No description provided for @wrong.
  ///
  /// In en, this message translates to:
  /// **'Try Again!'**
  String get wrong;

  /// No description provided for @rewardTitle.
  ///
  /// In en, this message translates to:
  /// **'Quest Complete!'**
  String get rewardTitle;

  /// No description provided for @rewardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You earned'**
  String get rewardSubtitle;

  /// No description provided for @rewardContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue Quest'**
  String get rewardContinue;

  /// No description provided for @rewardCustomize.
  ///
  /// In en, this message translates to:
  /// **'Customize Mentor'**
  String get rewardCustomize;

  /// No description provided for @scrollTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Cheat Sheet'**
  String get scrollTitle;

  /// No description provided for @scrollDownload.
  ///
  /// In en, this message translates to:
  /// **'Download PDF'**
  String get scrollDownload;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profileTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsEnglish;

  /// No description provided for @settingsTelugu.
  ///
  /// In en, this message translates to:
  /// **'Telugu'**
  String get settingsTelugu;

  /// No description provided for @settingsHindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get settingsHindi;

  /// No description provided for @mentorZayn.
  ///
  /// In en, this message translates to:
  /// **'Zayn'**
  String get mentorZayn;

  /// No description provided for @mentorArya.
  ///
  /// In en, this message translates to:
  /// **'Arya'**
  String get mentorArya;

  /// No description provided for @mentorDhara.
  ///
  /// In en, this message translates to:
  /// **'Dhara'**
  String get mentorDhara;

  /// No description provided for @mentorSubjectPhysics.
  ///
  /// In en, this message translates to:
  /// **'Physics & Tech'**
  String get mentorSubjectPhysics;

  /// No description provided for @mentorSubjectMath.
  ///
  /// In en, this message translates to:
  /// **'Math & Logic'**
  String get mentorSubjectMath;

  /// No description provided for @mentorSubjectBio.
  ///
  /// In en, this message translates to:
  /// **'Bio & Social'**
  String get mentorSubjectBio;

  /// No description provided for @topicLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get topicLocked;

  /// No description provided for @topicComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get topicComplete;

  /// No description provided for @topicAvailable.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get topicAvailable;

  /// No description provided for @errorGeneral.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get errorGeneral;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'te'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
