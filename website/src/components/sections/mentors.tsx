"use client";

import React from "react";
import { motion } from "framer-motion";
import { Cpu, Calculator, Leaf } from "lucide-react";
import { asset } from "@/lib/base-path";

const MENTORS = [
  {
    name: "Zayn",
    title: "The Fixer",
    domain: "Physics & Tech",
    vibe: "Cool older brother who makes circuits feel like superpowers.",
    icon: Cpu,
    color: "#00F2FF",
    gradient: "from-[#00F2FF]/20 to-transparent",
    avatar: "/characters/zayn_idle.png",
  },
  {
    name: "Arya",
    title: "The Speedster",
    domain: "Math & Logic",
    vibe: "High-energy leader who turns equations into speed runs.",
    icon: Calculator,
    color: "#FF00E5",
    gradient: "from-[#FF00E5]/20 to-transparent",
    avatar: "/characters/arya_idle.png",
  },
  {
    name: "Dhara",
    title: "The Guardian",
    domain: "Bio & Social Studies",
    vibe: "Calm, wise mentor who reveals the living world's hidden patterns.",
    icon: Leaf,
    color: "#39FF14",
    gradient: "from-[#39FF14]/20 to-transparent",
    avatar: "/characters/dhara_idle.png",
  },
];

export default function Mentors() {
  return (
    <section id="mentors" className="relative py-24 sm:py-32">
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[80%] h-px bg-gradient-to-r from-transparent via-white/10 to-transparent" />

      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="text-center mb-16"
        >
          <span className="inline-block text-xs font-semibold uppercase tracking-wider text-[#FF00E5] mb-4">
            The Mentor Trinity
          </span>
          <h2 className="text-4xl sm:text-5xl font-bold tracking-tight text-white mb-4">
            Three AI mentors.{" "}
            <span className="bg-gradient-to-r from-[#00F2FF] via-[#FF00E5] to-[#39FF14] bg-clip-text text-transparent">
              Your guides.
            </span>
          </h2>
          <p className="max-w-2xl mx-auto text-lg text-[#6B7280]">
            Original character IPs designed for Indian learners. Each mentor owns a domain,
            a personality, and a color signature.
          </p>
        </motion.div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {MENTORS.map((m, i) => (
            <motion.div
              key={m.name}
              initial={{ opacity: 0, y: 24 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: i * 0.15, duration: 0.5 }}
              whileHover={{ y: -6, transition: { duration: 0.2 } }}
              className="group relative overflow-hidden rounded-2xl border border-white/[0.06] bg-[#0F1117]"
            >
              {/* Glow */}
              <div
                className={`absolute inset-0 bg-gradient-to-b ${m.gradient} opacity-0 group-hover:opacity-100 transition-opacity duration-500`}
              />

              <div className="relative z-10 p-8">
                {/* Character image */}
                <div className="flex justify-center mb-6">
                  <div
                    className="relative w-32 h-32 rounded-2xl overflow-hidden"
                    style={{
                      boxShadow: `0 0 40px ${m.color}20`,
                    }}
                  >
                    <img
                      src={asset(m.avatar)}
                      alt={m.name}
                      className="w-full h-full object-cover"
                    />
                    <div
                      className="absolute inset-0"
                      style={{
                        background: `linear-gradient(135deg, ${m.color}15 0%, transparent 60%)`,
                      }}
                    />
                  </div>
                </div>

                <div className="text-center mb-4">
                  <h3 className="text-xl font-bold text-white">{m.name}</h3>
                  <p className="text-sm font-medium" style={{ color: m.color }}>
                    {m.title}
                  </p>
                </div>

                {/* Domain badge */}
                <div className="flex justify-center mb-4">
                  <div
                    className="inline-flex items-center gap-2 rounded-full px-3 py-1 text-xs font-medium"
                    style={{
                      backgroundColor: `${m.color}15`,
                      color: m.color,
                      border: `1px solid ${m.color}30`,
                    }}
                  >
                    <m.icon className="w-3.5 h-3.5" />
                    {m.domain}
                  </div>
                </div>

                <p className="text-sm text-[#6B7280] leading-relaxed text-center">{m.vibe}</p>

                {/* Bottom glow line */}
                <div
                  className="absolute bottom-0 left-0 right-0 h-px opacity-0 group-hover:opacity-100 transition-opacity"
                  style={{
                    background: `linear-gradient(to right, transparent, ${m.color}, transparent)`,
                  }}
                />
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
