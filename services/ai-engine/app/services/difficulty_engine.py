"""
ADL (Adaptive Difficulty Loop) Engine.

Algorithm from plan:
  weighted_score = 0.6 * accuracy + 0.4 * (1 - response_time / max_time)
  - score > 0.7  → difficulty + 1 (max 5)
  - score < 0.3  → difficulty - 1 (min 1)
  - else         → maintain
"""

from dataclasses import dataclass

MAX_RESPONSE_TIME_MS = 15_000


@dataclass
class ADLResult:
    new_difficulty: int
    weighted_score: float
    performance_label: str
    encouragement: str


_encouragements = {
    "excellent": [
        "Incredible speed! Boss level unlocked! 🚀",
        "You're a cyber-genius! Level up! ⚡",
        "Lightning fast! Arya would be proud! ✨",
    ],
    "good": [
        "Nice work! Keep the streak alive! 🔥",
        "Good answer! You're leveling up fast! 💫",
        "Well done! The quest continues! 🎯",
    ],
    "needs_practice": [
        "Keep going! Every legend starts here! 💪",
        "Don't give up — Arya believes in you! 🌟",
        "Try again — the knowledge is in you! 🧠",
    ],
}


def compute_difficulty(
    is_correct: bool,
    response_time_ms: int,
    current_difficulty: int,
) -> ADLResult:
    accuracy = 1.0 if is_correct else 0.0
    time_normalized = min(response_time_ms / MAX_RESPONSE_TIME_MS, 1.0)
    time_score = 1.0 - time_normalized

    weighted = round(0.6 * accuracy + 0.4 * time_score, 4)

    if weighted > 0.7:
        new_diff = min(current_difficulty + 1, 5)
        label = "excellent"
    elif weighted < 0.3:
        new_diff = max(current_difficulty - 1, 1)
        label = "needs_practice"
    else:
        new_diff = current_difficulty
        label = "good"

    import random
    encouragement = random.choice(_encouragements[label])

    return ADLResult(
        new_difficulty=new_diff,
        weighted_score=weighted,
        performance_label=label,
        encouragement=encouragement,
    )
