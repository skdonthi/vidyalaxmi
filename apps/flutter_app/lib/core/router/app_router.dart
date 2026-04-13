import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/boss_fight/presentation/boss_fight_screen.dart';
import '../../features/jingle/presentation/jingle_screen.dart';
import '../../features/mentor/presentation/mentor_customizer_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/reward/presentation/reward_screen.dart';
import '../../features/scroll/presentation/scroll_screen.dart';
import '../../features/skill_tree/presentation/skill_tree_screen.dart';
import '../../shared/providers/auth_provider.dart';

part 'app_router.g.dart';

/// Named route paths.
abstract final class ZRoutes {
  static const login = '/login';
  static const skillTree = '/';
  static const jingle = '/jingle/:topicId';
  static const bossFight = '/boss-fight/:topicId';
  static const reward = '/reward/:topicId';
  static const scroll = '/scroll/:topicId';
  static const profile = '/profile';
  static const mentorCustomizer = '/mentor';
}

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: ZRoutes.skillTree,
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isLoginRoute = state.matchedLocation == ZRoutes.login;

      if (!isLoggedIn && !isLoginRoute) return ZRoutes.login;
      if (isLoggedIn && isLoginRoute) return ZRoutes.skillTree;
      return null;
    },
    routes: [
      GoRoute(
        path: ZRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: ZRoutes.skillTree,
        name: 'skill-tree',
        builder: (context, state) => const SkillTreeScreen(),
      ),
      GoRoute(
        path: ZRoutes.jingle,
        name: 'jingle',
        builder: (context, state) {
          final topicId = state.pathParameters['topicId']!;
          return JingleScreen(topicId: topicId);
        },
      ),
      GoRoute(
        path: ZRoutes.bossFight,
        name: 'boss-fight',
        builder: (context, state) {
          final topicId = state.pathParameters['topicId']!;
          return BossFightScreen(topicId: topicId);
        },
      ),
      GoRoute(
        path: ZRoutes.reward,
        name: 'reward',
        builder: (context, state) {
          final topicId = state.pathParameters['topicId']!;
          final coinsEarned = int.tryParse(
                state.uri.queryParameters['coins'] ?? '0',
              ) ??
              0;
          return RewardScreen(topicId: topicId, coinsEarned: coinsEarned);
        },
      ),
      GoRoute(
        path: ZRoutes.scroll,
        name: 'scroll',
        builder: (context, state) {
          final topicId = state.pathParameters['topicId']!;
          return ScrollScreen(topicId: topicId);
        },
      ),
      GoRoute(
        path: ZRoutes.profile,
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: ZRoutes.mentorCustomizer,
        name: 'mentor',
        builder: (context, state) => const MentorCustomizerScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: Center(
        child: Text(
          'Route not found: ${state.matchedLocation}',
          style: const TextStyle(color: Color(0xFF00F2FF)),
        ),
      ),
    ),
  );
}
