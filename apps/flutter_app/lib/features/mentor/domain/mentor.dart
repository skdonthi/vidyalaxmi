import 'package:flutter/material.dart';

import '../../../core/theme/z_colors.dart';

enum MentorId { zayn, arya, dhara }

class Mentor {
  const Mentor({
    required this.id,
    required this.name,
    required this.subject,
    required this.glowColor,
    required this.description,
    required this.iconAsset,
  });

  final MentorId id;
  final String name;
  final String subject;
  final Color glowColor;
  final String description;
  final String iconAsset;
}

const kMentors = [
  Mentor(
    id: MentorId.zayn,
    name: 'Zayn',
    subject: 'Physics & Tech',
    glowColor: ZColors.primary,
    description: 'The Cool Genius older brother. Master of forces, circuits, and code.',
    iconAsset: 'assets/characters/zayn_idle.png',
  ),
  Mentor(
    id: MentorId.arya,
    name: 'Arya',
    subject: 'Math & Logic',
    glowColor: ZColors.secondary,
    description: 'The Speedster who loves patterns. Lightning-fast with numbers.',
    iconAsset: 'assets/characters/arya_idle.png',
  ),
  Mentor(
    id: MentorId.dhara,
    name: 'Dhara',
    subject: 'Bio & Social',
    glowColor: ZColors.success,
    description: 'The Guardian of the environment. Eco-warrior with leaf-tech armor.',
    iconAsset: 'assets/characters/dhara_idle.png',
  ),
];

class CosmeticItem {
  const CosmeticItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.mentorId,
  });

  final String id;
  final String name;
  final String category;
  final int price;
  final MentorId mentorId;
}

const kCosmeticItems = [
  CosmeticItem(id: 'neon-visor', name: 'Neon Visor', category: 'headwear', price: 100, mentorId: MentorId.arya),
  CosmeticItem(id: 'cyber-crown', name: 'Cyber Crown', category: 'headwear', price: 200, mentorId: MentorId.zayn),
  CosmeticItem(id: 'leaf-halo', name: 'Leaf Halo', category: 'headwear', price: 150, mentorId: MentorId.dhara),
];
