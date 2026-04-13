import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

/// Haptic feedback patterns from DESIGN.md.
abstract final class ZHaptics {
  /// Short, sharp — correct answer (50ms, intensity 0.7).
  static Future<void> correct() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 50, amplitude: 178); // 0.7 * 255 ≈ 178
    } else {
      HapticFeedback.lightImpact();
    }
  }

  /// Double buzz — wrong answer (80ms + 80ms, intensity 1.0).
  static Future<void> wrong() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(pattern: [0, 80, 60, 80], amplitudes: [0, 255, 0, 255]);
    } else {
      await HapticFeedback.heavyImpact();
      await Future.delayed(const Duration(milliseconds: 140));
      HapticFeedback.heavyImpact();
    }
  }

  /// Long rumble — level up (400ms, intensity 0.9).
  static Future<void> levelUp() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 400, amplitude: 230); // 0.9 * 255 ≈ 230
    } else {
      HapticFeedback.heavyImpact();
    }
  }

  /// Minimal tick — UI tap (20ms, intensity 0.3).
  static Future<void> tap() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 20, amplitude: 76); // 0.3 * 255 ≈ 76
    } else {
      HapticFeedback.selectionClick();
    }
  }

  /// Triple pulse — reward collect (30ms × 3, intensity 0.8).
  static Future<void> reward() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(
        pattern: [0, 30, 30, 30, 30, 30],
        amplitudes: [0, 204, 0, 204, 0, 204],
      );
    } else {
      HapticFeedback.mediumImpact();
    }
  }
}
