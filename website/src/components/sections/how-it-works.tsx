"use client";

import React from "react";
import { motion } from "framer-motion";
import { Music, Swords, Trophy, BookOpen, ArrowDown } from "lucide-react";

const STEPS = [
  {
    icon: Music,
    title: "Jingle Hook",
    time: "60 seconds",
    description: "A catchy song teaches the core concept. Karaoke-style lyrics in your language.",
    color: "#00F2FF",
  },
  {
    icon: Swords,
    title: "Boss Fight",
    time: "3-5 minutes",
    description: "Drag-drop and speed-tap challenges. AI adapts difficulty to your skill level.",
    color: "#FF00E5",
  },
  {
    icon: Trophy,
    title: "Earn Rewards",
    time: "Instant",
    description: "Collect VyL Coins for speed and accuracy. Unlock cosmetics for your mentor.",
    color: "#FFD700",
  },
  {
    icon: BookOpen,
    title: "Get Your Scroll",
    time: "Auto-generated",
    description: "Manga-style cheat sheet PDF. Your permanent revision companion.",
    color: "#39FF14",
  },
];

export default function HowItWorks() {
  return (
    <section id="how-it-works" className="relative py-24 sm:py-32">
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[80%] h-px bg-gradient-to-r from-transparent via-white/10 to-transparent" />

      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="text-center mb-16"
        >
          <span className="inline-block text-xs font-semibold uppercase tracking-wider text-[#39FF14] mb-4">
            The Learning Loop
          </span>
          <h2 className="text-4xl sm:text-5xl font-bold tracking-tight text-white mb-4">
            Four steps.{" "}
            <span className="text-[#39FF14]">One quest.</span>
          </h2>
          <p className="max-w-2xl mx-auto text-lg text-[#6B7280]">
            Every topic follows this loop. No lectures. No boredom. Pure active-play.
          </p>
        </motion.div>

        {/* Steps — vertical on mobile, horizontal on desktop */}
        <div className="relative max-w-3xl mx-auto">
          {STEPS.map((step, i) => (
            <motion.div
              key={i}
              initial={{ opacity: 0, x: i % 2 === 0 ? -30 : 30 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              transition={{ delay: i * 0.15, duration: 0.5 }}
              className="relative flex gap-6 mb-8 last:mb-0"
            >
              {/* Timeline */}
              <div className="flex flex-col items-center">
                <motion.div
                  whileHover={{ scale: 1.1 }}
                  className="flex h-14 w-14 shrink-0 items-center justify-center rounded-2xl border"
                  style={{
                    backgroundColor: `${step.color}10`,
                    borderColor: `${step.color}30`,
                    boxShadow: `0 0 20px ${step.color}20`,
                  }}
                >
                  <step.icon className="h-6 w-6" style={{ color: step.color }} />
                </motion.div>
                {i < STEPS.length - 1 && (
                  <div className="flex flex-col items-center py-2">
                    <div
                      className="w-px h-12"
                      style={{
                        background: `linear-gradient(to bottom, ${step.color}40, ${STEPS[i + 1].color}40)`,
                      }}
                    />
                    <ArrowDown className="w-3 h-3 text-[#6B7280] my-1" />
                  </div>
                )}
              </div>

              {/* Content */}
              <div className="pt-2 pb-4">
                <div className="flex items-center gap-3 mb-2">
                  <h3 className="text-lg font-bold text-white">{step.title}</h3>
                  <span
                    className="text-[10px] uppercase tracking-wider font-medium px-2 py-0.5 rounded-full"
                    style={{
                      color: step.color,
                      backgroundColor: `${step.color}15`,
                    }}
                  >
                    {step.time}
                  </span>
                </div>
                <p className="text-sm text-[#6B7280] leading-relaxed">{step.description}</p>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
