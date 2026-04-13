enum QuestionType { dragDrop, speedTap }

class DragDropPair {
  const DragDropPair({required this.id, required this.label, required this.imageAsset});
  final String id;
  final String label;
  final String imageAsset;
}

class Question {
  const Question({
    required this.id,
    required this.type,
    required this.prompt,
    required this.promptTe,
    required this.promptHi,
    required this.difficulty,
    this.options = const [],
    this.correctOptionId = '',
    this.dragPairs = const [],
  });

  final String id;
  final QuestionType type;
  final String prompt;
  final String promptTe;
  final String promptHi;
  final int difficulty; // 1–5
  final List<({String id, String label})> options;
  final String correctOptionId;
  final List<DragDropPair> dragPairs;

  String promptFor(String locale) => switch (locale) {
        'te' => promptTe,
        'hi' => promptHi,
        _ => prompt,
      };
}

/// Demo questions for "Telugu Letters I" at difficulty 1-3.
final kDemoQuestions = <Question>[
  Question(
    id: 'q-drag-1',
    type: QuestionType.dragDrop,
    prompt: 'Match the letter to its picture',
    promptTe: 'అక్షరాన్ని దాని చిత్రానికి సరిపోల్చండి',
    promptHi: 'अक्षर को उसके चित्र से मिलाएं',
    difficulty: 1,
    dragPairs: const [
      DragDropPair(id: 'అ', label: 'అ', imageAsset: 'assets/images/apple.png'),
      DragDropPair(id: 'ఆ', label: 'ఆ', imageAsset: 'assets/images/sky.png'),
      DragDropPair(id: 'ఇ', label: 'ఇ', imageAsset: 'assets/images/house.png'),
    ],
  ),
  Question(
    id: 'q-tap-1',
    type: QuestionType.speedTap,
    prompt: 'Which letter sounds like "Aa"?',
    promptTe: '"ఆ" అనే శబ్దం ఏ అక్షరం?',
    promptHi: '"ఆ" की ध्वनि कौन सा अक्षर है?',
    difficulty: 1,
    options: const [
      (id: 'అ', label: 'అ'),
      (id: 'ఆ', label: 'ఆ'),
      (id: 'ఇ', label: 'ఇ'),
      (id: 'ఈ', label: 'ఈ'),
    ],
    correctOptionId: 'ఆ',
  ),
  Question(
    id: 'q-tap-2',
    type: QuestionType.speedTap,
    prompt: 'Which letter starts "Illu" (house)?',
    promptTe: '"ఇల్లు" ఏ అక్షరంతో మొదలవుతుంది?',
    promptHi: '"ఇల్లు" (घर) किस अक्षर से शुरू होता है?',
    difficulty: 2,
    options: const [
      (id: 'అ', label: 'అ'),
      (id: 'ఇ', label: 'ఇ'),
      (id: 'ఈ', label: 'ఈ'),
      (id: 'ఉ', label: 'ఉ'),
    ],
    correctOptionId: 'ఇ',
  ),
  Question(
    id: 'q-tap-3',
    type: QuestionType.speedTap,
    prompt: 'How many vowels are in "అ ఆ ఇ ఈ"?',
    promptTe: '"అ ఆ ఇ ఈ" లో ఎన్ని స్వరాలు ఉన్నాయి?',
    promptHi: '"అ ఆ ఇ ఈ" में कितने स्वर हैं?',
    difficulty: 3,
    options: const [
      (id: '2', label: '2'),
      (id: '3', label: '3'),
      (id: '4', label: '4'),
      (id: '5', label: '5'),
    ],
    correctOptionId: '4',
  ),
];
