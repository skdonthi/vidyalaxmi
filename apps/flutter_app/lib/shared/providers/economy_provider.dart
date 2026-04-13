import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_provider.dart';

part 'economy_provider.g.dart';

@riverpod
Stream<int> lCoinBalance(Ref ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value(0);

  return Supabase.instance.client
      .from('users')
      .stream(primaryKey: ['id'])
      .eq('id', user.id)
      .map((rows) => rows.isNotEmpty ? (rows.first['l_coins'] as int? ?? 0) : 0);
}

@riverpod
Stream<int> streakDays(Ref ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value(0);

  return Supabase.instance.client
      .from('users')
      .stream(primaryKey: ['id'])
      .eq('id', user.id)
      .map((rows) => rows.isNotEmpty ? (rows.first['streak_days'] as int? ?? 0) : 0);
}

@riverpod
class EconomyNotifier extends _$EconomyNotifier {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> awardCoins({
    required int amount,
    required String description,
  }) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client.rpc('award_l_coins', params: {
        'p_user_id': user.id,
        'p_amount': amount,
        'p_description': description,
      });
    });
  }

  Future<void> spendCoins({
    required int amount,
    required String description,
  }) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client.rpc('spend_l_coins', params: {
        'p_user_id': user.id,
        'p_amount': amount,
        'p_description': description,
      });
    });
  }
}
