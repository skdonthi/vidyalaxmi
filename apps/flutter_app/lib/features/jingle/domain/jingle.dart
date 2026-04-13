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
  durationMs: 18000,
  titleEn: 'The Akshara Song',
  lyrics: const [
    LyricLine(
      startMs: 0,
      endMs: 3000,
      textEn: 'A is for Amma, she loves me so!',
      textTe: 'అ అంటే అమ్మ, నన్ను ఎంతో ప్రేమిస్తుంది!',
      textHi: 'अ से अम्मा, वह मुझे बहुत प्यार करती है!',
    ),
    LyricLine(
      startMs: 3000,
      endMs: 6000,
      textEn: 'Aa is for Aavu, giving milk to grow!',
      textTe: 'ఆ అంటే ఆవు, పాలు ఇస్తుంది మనకు!',
      textHi: 'आ से आलू, सबको भाता है!',
    ),
    LyricLine(
      startMs: 6000,
      endMs: 9000,
      textEn: 'I is for Illu, where we stay and play!',
      textTe: 'ఇ అంటే ఇల్లు, మనం ఆడుకునే చోటు!',
      textHi: 'इ से इमली, खट्टी-मीठी!',
    ),
    LyricLine(
      startMs: 9000,
      endMs: 12000,
      textEn: 'Ee is for Eega, flying far away!',
      textTe: 'ఈ అంటే ఈగ, దూరం ఎగిరిపోతుంది!',
      textHi: 'ई से ईख, मीठा-मीठा!',
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
