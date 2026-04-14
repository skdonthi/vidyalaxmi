"use client";

import React from "react";
import { motion } from "framer-motion";
import {
  Music,
  Swords,
  Coins,
  BookOpen,
  Brain,
  Globe,
  Gamepad2,
  Zap,
} from "lucide-react";

const FEATURES = [
  {
    icon: Music,
    title: "Jingle Hooks",
    description: "60-second catchy songs that encode concepts into memory through rhythm and melody.",
    color: "#00F2FF",
  },
  {
    icon: Swords,
    title: "Boss Fight Challenges",
    description: "Drag-drop and speed-tap quizzes powered by Adaptive Difficulty. No boring MCQs.",
    color: "#FF00E5",
  },
  {
    icon: Coins,
    title: "VyL Coin Economy",
    description: "Earn coins for accuracy and speed. Spend them to customize your AI mentor's gear.",
    color: "#FFD700",
  },
  {
    icon: BookOpen,
    title: "Manga Cheat Sheets",
    description: "Auto-generated comic-style revision PDFs after every completed quest.",
    color: "#39FF14",
  },
  {
    icon: Brain,
    title: "ADL Engine",
    description: "AI adjusts difficulty in real-time. Too easy? Level up. Struggling? Get support.",
    color: "#FF00E5",
  },
  {
    icon: Globe,
    title: "Bhashini Integration",
    description: "Learn in Telugu, Hindi, English, and 10+ Indian languages. Switch anytime.",
    color: "#00F2FF",
  },
  {
    icon: Gamepad2,
    title: "Skill Tree Progression",
    description: "Unlock topics in a visual node graph. See your journey mapped like a game world.",
    color: "#39FF14",
  },
  {
    icon: Zap,
    title: "Streak & Rewards",
    description: "Daily streaks, mentor cosmetics, and achievement badges keep you coming back.",
    color: "#FFD700",
  },
];

const containerVariants = {
  hidden: {},
  visible: { transition: { staggerChildren: 0.08 } },
};

const itemVariants = {
  hidden: { opacity: 0, y: 24 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.5, ease: "easeOut" as const } },
};

export default function Features() {
  return (
    <section id="features" className="relative py-24 sm:py-32">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="text-center mb-16"
        >
          <span className="inline-block text-xs font-semibold uppercase tracking-wider text-[#00F2FF] mb-4">
            Features
          </span>
          <h2 className="text-4xl sm:text-5xl font-bold tracking-tight text-white mb-4">
            Not just learning.{" "}
            <span className="bg-gradient-to-r from-[#00F2FF] to-[#FF00E5] bg-clip-text text-transparent">
              Active-Play.
            </span>
          </h2>
          <p className="max-w-2xl mx-auto text-lg text-[#6B7280]">
            Every feature is designed to make knowledge feel like a power-up, not a chore.
          </p>
        </motion.div>

        {/* Grid */}
        <motion.div
          variants={containerVariants}
          initial="hidden"
          whileInView="visible"
          viewport={{ once: true, margin: "-100px" }}
          className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5"
        >
          {FEATURES.map((f, i) => (
            <motion.div
              key={i}
              variants={itemVariants}
              whileHover={{ y: -4, transition: { duration: 0.15 } }}
              className="group relative overflow-hidden rounded-2xl border border-white/[0.06] bg-[#0F1117] p-6 transition-all hover:border-white/10"
            >
              <div
                className="absolute top-0 right-0 -mr-8 -mt-8 h-32 w-32 rounded-full blur-3xl pointer-events-none opacity-0 group-hover:opacity-100 transition-opacity duration-500"
                style={{ backgroundColor: `${f.color}10` }}
              />

              <div className="relative z-10">
                <div
                  className="mb-4 flex h-10 w-10 items-center justify-center rounded-xl"
                  style={{ backgroundColor: `${f.color}15` }}
                >
                  <f.icon className="h-5 w-5" style={{ color: f.color }} />
                </div>
                <h3 className="text-base font-semibold text-white mb-2">{f.title}</h3>
                <p className="text-sm text-[#6B7280] leading-relaxed">{f.description}</p>
              </div>
            </motion.div>
          ))}
        </motion.div>
      </div>
    </section>
  );
}
