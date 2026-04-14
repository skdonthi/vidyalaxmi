"use client";

import React from "react";
import { motion } from "framer-motion";

const draw = {
  hidden: { pathLength: 0, opacity: 0 },
  visible: (i: number) => ({
    pathLength: 1,
    opacity: 1,
    transition: {
      pathLength: { delay: i * 0.25, duration: 0.8, ease: "easeInOut" as const },
      opacity: { delay: i * 0.25, duration: 0.01 },
    },
  }),
};

const fillIn = {
  hidden: { fillOpacity: 0 },
  visible: (i: number) => ({
    fillOpacity: 1,
    transition: { delay: 0.8 + i * 0.25, duration: 0.5, ease: "easeOut" as const },
  }),
};

interface VyLLogoProps {
  size?: number;
  className?: string;
  animate?: boolean;
}

export default function VyLLogo({ size = 40, className = "", animate = true }: VyLLogoProps) {
  const initial = animate ? "hidden" : "visible";
  const anim = animate ? "visible" : "visible";

  return (
    <motion.svg
      viewBox="0 0 120 120"
      width={size}
      height={size}
      initial={initial}
      animate={anim}
      className={className}
    >
      {/* Background hexagon */}
      <motion.path
        d="M60 5 L110 32.5 L110 87.5 L60 115 L10 87.5 L10 32.5 Z"
        stroke="#00F2FF"
        strokeWidth="2"
        fill="none"
        variants={draw}
        custom={0}
      />
      <motion.path
        d="M60 5 L110 32.5 L110 87.5 L60 115 L10 87.5 L10 32.5 Z"
        fill="#00F2FF"
        stroke="none"
        variants={fillIn}
        custom={0}
        style={{ fillOpacity: 0 }}
      />

      {/* V */}
      <motion.path
        d="M30 35 L48 80 L66 35"
        stroke="#050505"
        strokeWidth="6"
        strokeLinecap="round"
        strokeLinejoin="round"
        fill="none"
        variants={draw}
        custom={1}
      />

      {/* y — descender goes below */}
      <motion.path
        d="M54 35 L68 65 M82 35 L64 80 L58 95"
        stroke="#050505"
        strokeWidth="5"
        strokeLinecap="round"
        strokeLinejoin="round"
        fill="none"
        variants={draw}
        custom={2}
      />

      {/* L */}
      <motion.path
        d="M78 35 L78 80 L98 80"
        stroke="#050505"
        strokeWidth="6"
        strokeLinecap="round"
        strokeLinejoin="round"
        fill="none"
        variants={draw}
        custom={3}
      />

      {/* Accent dot / spark */}
      <motion.circle
        cx="98"
        cy="32"
        r="4"
        fill="#FF00E5"
        variants={fillIn}
        custom={3}
      />
    </motion.svg>
  );
}
