import type { Metadata } from "next";
import { Lexend } from "next/font/google";
import "./globals.css";

const lexend = Lexend({
  variable: "--font-lexend",
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
});

export const metadata: Metadata = {
  title: "VyL — Learn. Earn. Own.",
  description:
    "India's first gamified K-12 learning ecosystem. Duolingo meets Valorant — powered by AI, built for Bharat.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={`${lexend.variable} dark h-full antialiased`}>
      <body className="min-h-full flex flex-col bg-[#050505] text-[#EAEAEA] font-[family-name:var(--font-lexend)]">
        {children}
      </body>
    </html>
  );
}
