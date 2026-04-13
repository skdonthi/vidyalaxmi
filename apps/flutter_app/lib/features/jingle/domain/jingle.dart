class LyricLine {
  const LyricLine({
    required this.startMs,
    required this.endMs,
    required this.textEn,
    required this.textTe,
    required this.textHi,
  });

  final int startMs;
  final int endMs;
  final String textEn;
  final String textTe;
  final String textHi;

  String textFor(String locale) => switch (locale) {
        'te' => textTe,
        'hi' => textHi,
        _ => textEn,
      };
}

class Jingle {
  const Jingle({
    required this.id,
    required this.topicId,
    required this.audioUrl,
    required this.durationMs,
    required this.lyrics,
    required this.titleEn,
  });

  final String id;
  final String topicId;
  final String audioUrl;
  final int durationMs;
  final List<LyricLine> lyrics;
  final String titleEn;
}

/// Demo jingle for "Telugu Letters I"
final kDemoJingle = Jingle(
  id: 'jingle-telugu-letters-1',
  topicId: 'telugu-letters-1',
  audioUrl: 'assets/audio/telugu_letters_1.mp3',
  durationMs: 30000,
  titleEn: 'The Akshara Song',
  lyrics: const [
    LyricLine(
      startMs: 0,
      endMs: 3000,
      textEn: 'అ is for Aapple, bright and red',
      textTe: 'అ అంటే ఆపిల్, ఎర్రగా ఉంది',
      textHi: 'అ से Apple, लाल और सुंदर',
    ),
    LyricLine(
      startMs: 3000,
      endMs: 6000,
      textEn: 'ఆ is for Aakaasham up ahead',
      textTe: 'ఆ అంటే ఆకాశం, పైన ఉంది',
      textHi: 'ఆ से Aakaasham, ऊपर है',
    ),
    LyricLine(
      startMs: 6000,
      endMs: 9000,
      textEn: 'ఇ is for Illu, our sweet home',
      textTe: 'ఇ అంటే ఇల్లు, మన ఇల్లు',
      textHi: 'ఇ से Illu, हमारा घर',
    ),
    LyricLine(
      startMs: 9000,
      endMs: 12000,
      textEn: 'ఈ is for Eega, they freely roam',
      textTe: 'ఈ అంటే ఈగ, స్వేచ్ఛగా తిరుగుతుంది',
      textHi: 'ఈ से Eega, स्वतंत्र उड़ान',
    ),
    LyricLine(
      startMs: 12000,
      endMs: 15000,
      textEn: 'Learn your letters, one by one',
      textTe: 'అక్షరాలు నేర్చుకో, ఒక్కొక్కటి',
      textHi: 'अक्षर सीखो, एक-एक करके',
    ),
    LyricLine(
      startMs: 15000,
      endMs: 18000,
      textEn: 'Telugu wisdom has just begun!',
      textTe: 'తెలుగు జ్ఞానం మొదలైంది!',
      textHi: 'तेलुगू ज्ञान शुरू हो गया!',
    ),
  ],
);
