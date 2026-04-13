import '../../../shared/providers/progress_provider.dart';

enum MentorId { zayn, arya, dhara }

class SkillNode {
  const SkillNode({
    required this.id,
    required this.titleEn,
    required this.titleTe,
    required this.titleHi,
    required this.subject,
    required this.mentor,
    required this.position,
    this.prerequisiteIds = const [],
  });

  final String id;
  final String titleEn;
  final String titleTe;
  final String titleHi;
  final String subject;
  final MentorId mentor;
  final ({double x, double y}) position;
  final List<String> prerequisiteIds;

  String titleFor(String locale) => switch (locale) {
        'te' => titleTe,
        'hi' => titleHi,
        _ => titleEn,
      };
}

class SkillNodeWithState {
  const SkillNodeWithState({required this.node, required this.state});
  final SkillNode node;
  final TopicState state;
}

/// Demo topic seed — matches supabase seed.sql.
final List<SkillNode> kDemoTopics = [
  const SkillNode(
    id: 'telugu-letters-1',
    titleEn: 'Telugu Letters I',
    titleTe: 'తెలుగు అక్షరాలు I',
    titleHi: 'तेलुगू अक्षर I',
    subject: 'bio',
    mentor: MentorId.arya,
    position: (x: 0.5, y: 0.15),
  ),
  const SkillNode(
    id: 'telugu-letters-2',
    titleEn: 'Telugu Letters II',
    titleTe: 'తెలుగు అక్షరాలు II',
    titleHi: 'तेलुगू अक्षर II',
    subject: 'math',
    mentor: MentorId.arya,
    position: (x: 0.5, y: 0.35),
    prerequisiteIds: ['telugu-letters-1'],
  ),
  const SkillNode(
    id: 'numbers-1',
    titleEn: 'Numbers & Counting',
    titleTe: 'సంఖ్యలు మరియు లెక్కింపు',
    titleHi: 'संख्याएं और गिनती',
    subject: 'math',
    mentor: MentorId.arya,
    position: (x: 0.25, y: 0.55),
    prerequisiteIds: ['telugu-letters-1'],
  ),
  const SkillNode(
    id: 'physics-intro',
    titleEn: 'Forces & Motion',
    titleTe: 'శక్తులు మరియు చలనం',
    titleHi: 'बल और गति',
    subject: 'physics',
    mentor: MentorId.zayn,
    position: (x: 0.75, y: 0.55),
    prerequisiteIds: ['telugu-letters-1'],
  ),
  const SkillNode(
    id: 'nature-1',
    titleEn: 'Plants & Life',
    titleTe: 'మొక్కలు మరియు జీవితం',
    titleHi: 'पौधे और जीवन',
    subject: 'bio',
    mentor: MentorId.dhara,
    position: (x: 0.5, y: 0.75),
    prerequisiteIds: ['numbers-1', 'physics-intro'],
  ),
];
