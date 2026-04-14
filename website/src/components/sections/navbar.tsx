"use client";

import React, { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Menu, X, ArrowRight } from "lucide-react";
import VyLLogo from "@/components/ui/vyl-logo";

const LINKS = [
  { label: "Features", href: "#features" },
  { label: "Mentors", href: "#mentors" },
  { label: "How It Works", href: "#how-it-works" },
  { label: "Languages", href: "#languages" },
];

export default function Navbar() {
  const [open, setOpen] = useState(false);

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 border-b border-white/5 bg-[#050505]/80 backdrop-blur-xl">
      <div className="mx-auto flex max-w-7xl items-center justify-between px-4 py-3 sm:px-6 lg:px-8">
        {/* Logo */}
        <a href="#" className="flex items-center gap-2.5">
          <VyLLogo size={36} animate={true} />
          <span className="text-xl font-bold tracking-tight">
            Vy<span className="text-[#00F2FF]">L</span>
          </span>
        </a>

        {/* Desktop Links */}
        <div className="hidden md:flex items-center gap-8">
          {LINKS.map((link) => (
            <a
              key={link.href}
              href={link.href}
              className="text-sm text-[#6B7280] transition-colors hover:text-white"
            >
              {link.label}
            </a>
          ))}
        </div>

        {/* CTA */}
        <div className="hidden md:flex items-center gap-3">
          <motion.a
            href="#"
            whileHover={{ scale: 1.03 }}
            whileTap={{ scale: 0.97 }}
            className="inline-flex items-center gap-2 rounded-xl bg-[#00F2FF] px-5 py-2.5 text-sm font-semibold text-[#050505] shadow-[0_0_16px_rgba(0,242,255,0.35)] transition-shadow hover:shadow-[0_0_24px_rgba(0,242,255,0.5)]"
          >
            Get Started
            <ArrowRight className="w-3.5 h-3.5" />
          </motion.a>
        </div>

        {/* Mobile toggle */}
        <button className="md:hidden text-white" onClick={() => setOpen(!open)}>
          {open ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
        </button>
      </div>

      {/* Mobile menu */}
      <AnimatePresence>
        {open && (
          <motion.div
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: "auto" }}
            exit={{ opacity: 0, height: 0 }}
            className="md:hidden border-t border-white/5 bg-[#050505]/95 backdrop-blur-xl overflow-hidden"
          >
            <div className="px-4 py-6 space-y-4">
              {LINKS.map((link) => (
                <a
                  key={link.href}
                  href={link.href}
                  className="block text-base text-[#6B7280] hover:text-white"
                  onClick={() => setOpen(false)}
                >
                  {link.label}
                </a>
              ))}
              <a
                href="#"
                className="block w-full text-center rounded-xl bg-[#00F2FF] px-5 py-3 text-sm font-semibold text-[#050505]"
              >
                Get Started
              </a>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </nav>
  );
}
