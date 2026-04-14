"use client";

import React from "react";
import { motion } from "framer-motion";
import {
  ArrowRight,
  Play,
  Zap,
  Trophy,
  Star,
  Gamepad2,
  Brain,
  Globe,
  Sparkles,
  BookOpen,
} from "lucide-react";

const STATS = [
  { value: "10+", label: "Subjects" },
  { value: "3", label: "AI Mentors" },
  { value: "∞", label: "Replay" },
];

const LANGUAGES = [
  "English",
  "తెలుగు",
  "हिंदी",
  "தமிழ்",
  "ಕನ್ನಡ",
  "मराठी",
  "বাংলা",
  "ગુજરાતી",
  "ਪੰਜਾਬੀ",
  "മലയാളം",
  "English",
  "తెలుగు",
  "हिंदी",
  "தமிழ்",
  "ಕನ್ನಡ",
  "मराठी",
  "বাংলা",
  "ગુજરાતી",
  "ਪੰਜਾਬੀ",
  "മലയാളം",
];

const fadeUp = {
  hidden: { opacity: 0, y: 24 },
  visible: (i: number) => ({
    opacity: 1,
    y: 0,
    transition: { delay: i * 0.12, duration: 0.6, ease: [0.25, 0.46, 0.45, 0.94] as [number, number, number, number] },
  }),
};

const StatItem = ({ value, label }: { value: string; label: string }) => (
  <div className="flex flex-col items-center justify-center transition-transform hover:-translate-y-1 cursor-default">
    <span className="text-xl font-bold text-white sm:text-2xl">{value}</span>
    <span className="text-[10px] uppercase tracking-wider text-[#6B7280] font-medium sm:text-xs">
      {label}
    </span>
  </div>
);

export default function HeroSection() {
  return (
    <section className="relative w-full overflow-hidden">
      {/* Grid background */}
      <div className="absolute inset-0 z-0">
        <div
          className="absolute inset-0 opacity-[0.04]"
          style={{
            backgroundImage: `linear-gradient(rgba(0,242,255,0.3) 1px, transparent 1px), linear-gradient(90deg, rgba(0,242,255,0.3) 1px, transparent 1px)`,
            backgroundSize: "40px 40px",
          }}
        />
        {/* Cyan orb */}
        <div className="absolute -top-32 -right-32 w-[500px] h-[500px] rounded-full bg-[#00F2FF]/[0.06] blur-[120px] animate-pulse-glow" />
        {/* Magenta orb */}
        <div className="absolute -bottom-32 -left-32 w-[400px] h-[400px] rounded-full bg-[#FF00E5]/[0.05] blur-[100px] animate-pulse-glow" style={{ animationDelay: "1.5s" }} />
      </div>

      <div className="relative z-10 mx-auto max-w-7xl px-4 pt-28 pb-16 sm:px-6 md:pt-36 md:pb-24 lg:px-8">
        <div className="grid grid-cols-1 gap-12 lg:grid-cols-12 lg:gap-8 items-start">
          {/* LEFT COLUMN */}
          <div className="lg:col-span-7 flex flex-col justify-center space-y-8 pt-8">
            {/* Badge */}
            <motion.div variants={fadeUp} initial="hidden" animate="visible" custom={0}>
              <div className="inline-flex items-center gap-2 rounded-full border border-white/10 bg-white/5 px-4 py-2 backdrop-blur-md">
                <span className="text-[10px] sm:text-xs font-semibold uppercase tracking-wider text-zinc-300 flex items-center gap-2">
                  India&apos;s First Gamified K-12 Platform
                  <Star className="w-3.5 h-3.5 text-[#FFD700] fill-[#FFD700]" />
                </span>
              </div>
            </motion.div>

            {/* Heading */}
            <motion.h1
              variants={fadeUp}
              initial="hidden"
              animate="visible"
              custom={1}
              className="text-5xl sm:text-6xl lg:text-7xl xl:text-8xl font-bold tracking-tighter leading-[0.9]"
            >
              <span className="text-white">Learn.</span>{" "}
              <span className="bg-gradient-to-r from-[#00F2FF] to-[#FF00E5] bg-clip-text text-transparent">
                Earn.
              </span>{" "}
              <span className="text-white">Own.</span>
              <br />
              <span className="text-3xl sm:text-4xl lg:text-5xl font-medium text-[#6B7280] mt-2 block">
                Knowledge is your Power-Up.
              </span>
            </motion.h1>

            {/* Description */}
            <motion.p
              variants={fadeUp}
              initial="hidden"
              animate="visible"
              custom={2}
              className="max-w-xl text-lg text-[#6B7280] leading-relaxed"
            >
              VyL transforms boring textbooks into epic quests. AI mentors guide you through
              jingle-powered lessons, boss-fight challenges, and earn L-Coins while mastering
              STEM & Social Studies — in your language.
            </motion.p>

            {/* CTA Buttons */}
            <motion.div
              variants={fadeUp}
              initial="hidden"
              animate="visible"
              custom={3}
              className="flex flex-col sm:flex-row gap-4"
            >
              <motion.button
                whileHover={{ scale: 1.03 }}
                whileTap={{ scale: 0.97 }}
                className="group inline-flex items-center justify-center gap-2 rounded-xl bg-[#00F2FF] px-8 py-4 text-sm font-semibold text-[#050505] shadow-[0_0_24px_rgba(0,242,255,0.4)] transition-shadow hover:shadow-[0_0_32px_rgba(0,242,255,0.6)]"
              >
                Start Playing Free
                <ArrowRight className="w-4 h-4 transition-transform group-hover:translate-x-1" />
              </motion.button>

              <motion.button
                whileHover={{ scale: 1.03 }}
                whileTap={{ scale: 0.97 }}
                className="group inline-flex items-center justify-center gap-2 rounded-xl border border-[#FF00E5]/40 bg-[#FF00E5]/10 px-8 py-4 text-sm font-semibold text-[#FF00E5] backdrop-blur-sm transition-all hover:bg-[#FF00E5]/20 hover:shadow-[0_0_24px_rgba(255,0,229,0.3)]"
              >
                <Play className="w-4 h-4 fill-current" />
                Watch Demo
              </motion.button>
            </motion.div>

            {/* Proof bar */}
            <motion.div
              variants={fadeUp}
              initial="hidden"
              animate="visible"
              custom={4}
              className="flex items-center gap-6 pt-4"
            >
              <div className="flex items-center gap-2">
                <div className="flex -space-x-2">
                  {[0, 1, 2, 3].map((i) => (
                    <div
                      key={i}
                      className="w-8 h-8 rounded-full border-2 border-[#050505] bg-[#1A1D27]"
                      style={{
                        backgroundImage: `url(https://i.pravatar.cc/32?img=${20 + i})`,
                        backgroundSize: "cover",
                      }}
                    />
                  ))}
                </div>
                <span className="text-xs text-[#6B7280]">10K+ students learning</span>
              </div>
            </motion.div>
          </div>

          {/* RIGHT COLUMN */}
          <div className="lg:col-span-5 space-y-5 lg:mt-12">
            {/* Stats Card */}
            <motion.div
              variants={fadeUp}
              initial="hidden"
              animate="visible"
              custom={4}
              className="relative overflow-hidden rounded-2xl border border-white/10 bg-white/5 p-8 backdrop-blur-xl shadow-2xl"
            >
              <div className="absolute top-0 right-0 -mr-16 -mt-16 h-64 w-64 rounded-full bg-[#00F2FF]/[0.05] blur-3xl pointer-events-none" />

              <div className="relative z-10">
                <div className="flex items-center gap-4 mb-8">
                  <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-[#00F2FF]/10 ring-1 ring-[#00F2FF]/30">
                    <Gamepad2 className="h-6 w-6 text-[#00F2FF]" />
                  </div>
                  <div>
                    <div className="text-3xl font-bold tracking-tight text-white">
                      The Learning Loop
                    </div>
                  </div>
                </div>

                {/* Loop steps */}
                <div className="space-y-3 mb-6">
                  {[
                    { icon: Sparkles, text: "Jingle Hook — 60s song per concept", color: "#00F2FF" },
                    { icon: Zap, text: "Boss Fight — ADL-powered quiz", color: "#FF00E5" },
                    { icon: Trophy, text: "Earn L-Coins & unlock gear", color: "#FFD700" },
                    { icon: BookOpen, text: "Manga Cheat Sheet for revision", color: "#39FF14" },
                  ].map((step, i) => (
                    <div key={i} className="flex items-center gap-3">
                      <div
                        className="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg"
                        style={{ backgroundColor: `${step.color}15` }}
                      >
                        <step.icon className="h-4 w-4" style={{ color: step.color }} />
                      </div>
                      <span className="text-sm text-zinc-300">{step.text}</span>
                    </div>
                  ))}
                </div>

                <div className="h-px w-full bg-white/10 mb-6" />

                {/* Mini Stats */}
                <div className="grid grid-cols-3 gap-4 text-center">
                  {STATS.map((s, i) => (
                    <StatItem key={i} value={s.value} label={s.label} />
                  ))}
                </div>

                {/* Tags */}
                <div className="mt-6 flex flex-wrap gap-2">
                  <div className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 px-3 py-1 text-[10px] font-medium tracking-wide text-zinc-300">
                    <span className="relative flex h-2 w-2">
                      <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-[#39FF14] opacity-75" />
                      <span className="relative inline-flex rounded-full h-2 w-2 bg-[#39FF14]" />
                    </span>
                    FREE TO PLAY
                  </div>
                  <div className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 px-3 py-1 text-[10px] font-medium tracking-wide text-zinc-300">
                    <Globe className="w-3 h-3 text-[#00F2FF]" />
                    10+ LANGUAGES
                  </div>
                  <div className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 px-3 py-1 text-[10px] font-medium tracking-wide text-zinc-300">
                    <Brain className="w-3 h-3 text-[#FF00E5]" />
                    AI-POWERED
                  </div>
                </div>
              </div>
            </motion.div>

            {/* Language Marquee Card */}
            <motion.div
              variants={fadeUp}
              initial="hidden"
              animate="visible"
              custom={5}
              className="relative overflow-hidden rounded-2xl border border-white/10 bg-white/5 py-6 backdrop-blur-xl"
            >
              <h3 className="mb-4 px-6 text-sm font-medium text-[#6B7280]">
                Powered by Bhashini — Learn in your language
              </h3>

              <div
                className="relative flex overflow-hidden"
                style={{
                  maskImage:
                    "linear-gradient(to right, transparent, black 20%, black 80%, transparent)",
                  WebkitMaskImage:
                    "linear-gradient(to right, transparent, black 20%, black 80%, transparent)",
                }}
              >
                <div className="animate-marquee flex gap-10 whitespace-nowrap px-4">
                  {[...LANGUAGES, ...LANGUAGES].map((lang, i) => (
                    <span
                      key={i}
                      className="text-lg font-semibold text-white/40 hover:text-[#00F2FF] transition-colors cursor-default"
                    >
                      {lang}
                    </span>
                  ))}
                </div>
              </div>
            </motion.div>
          </div>
        </div>
      </div>
    </section>
  );
}
