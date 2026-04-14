"use client";

import React from "react";
import { ExternalLink, MessageCircle } from "lucide-react";

export default function Footer() {
  return (
    <footer className="border-t border-white/5 bg-[#050505]">
      <div className="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
        <div className="flex flex-col md:flex-row items-center justify-between gap-6">
          <div className="flex items-center gap-2">
            <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-[#00F2FF]/10">
              <span className="text-xs font-bold text-[#00F2FF]">V</span>
            </div>
            <span className="text-lg font-bold tracking-tight">
              Vy<span className="text-[#00F2FF]">L</span>
            </span>
            <span className="text-xs text-[#6B7280] ml-2">by VidyaLaxmi</span>
          </div>

          <div className="flex items-center gap-6 text-sm text-[#6B7280]">
            <a href="#" className="hover:text-white transition-colors">Privacy</a>
            <a href="#" className="hover:text-white transition-colors">Terms</a>
            <a href="https://github.com/skdonthi/vidyalaxmi" className="hover:text-white transition-colors">
              <ExternalLink className="w-4 h-4" />
            </a>
            <a href="#" className="hover:text-white transition-colors">
              <MessageCircle className="w-4 h-4" />
            </a>
          </div>

          <p className="text-xs text-[#6B7280]">
            © {new Date().getFullYear()} VidyaLaxmi. Built for Bharat.
          </p>
        </div>
      </div>
    </footer>
  );
}
