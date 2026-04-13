import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_provider.dart';

part 'progress_provider.g.dart';

enum TopicState { locked, available, completed }

class TopicProgress {
  const TopicProgress({
    required this.topicId,
    required this.state,
    this.score = 0,
    this.currentDifficulty = 1,
    this.accuracyAvg = 0,
  });

  final String topicId;
  final TopicState state;
  final int score;
  final int currentDifficulty;
  final double accuracyAvg;

  factory TopicProgress.fromJson(Map<String, dynamic> json) => TopicProgress(
        topicId: json['topic_id'] as String,
        state: (json['completed'] as bool? ?? false)
            ? TopicState.completed
            : TopicState.available,
        score: json['score'] as int? ?? 0,
        currentDifficulty: json['current_difficulty'] as int? ?? 1,
        accuracyAvg: (json['accuracy_avg'] as num?)?.toDouble() ?? 0,
      );
}

@riverpod
class UserProgress extends _$UserProgress {
  @override
  Future<Map<String, TopicProgress>> build() async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return {};

    final response = await Supabase.instance.client
        .from('progress')
        .select()
        .eq('user_id', user.id);

    final list = (response as List).cast<Map<String, dynamic>>();
    return {
      for (final row in list)
        row['topic_id'] as String: TopicProgress.fromJson(row),
    };
  }

  Future<void> updateProgress({
    required String topicId,
    required int score,
    required double accuracy,
    required int difficulty,
    bool completed = false,
  }) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    await Supabase.instance.client.from('progress').upsert({
      'user_id': user.id,
      'topic_id': topicId,
      'score': score,
      'accuracy_avg': accuracy,
      'current_difficulty': difficulty,
      'completed': completed,
      'completed_at': completed ? DateTime.now().toIso8601String() : null,
    });

    ref.invalidateSelf();
  }
}

@riverpod
Stream<Map<String, dynamic>> userStats(Ref ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return const Stream.empty();

  return Supabase.instance.client
      .from('users')
      .stream(primaryKey: ['id'])
      .eq('id', user.id)
      .map((rows) => rows.isNotEmpty ? rows.first : <String, dynamic>{});
}
