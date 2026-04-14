import Navbar from "@/components/sections/navbar";
import HeroSection from "@/components/ui/glassmorphism-trust-hero";
import Features from "@/components/sections/features";
import Mentors from "@/components/sections/mentors";
import HowItWorks from "@/components/sections/how-it-works";
import CTA from "@/components/sections/cta";
import Footer from "@/components/sections/footer";

export default function Home() {
  return (
    <main className="flex flex-col min-h-screen bg-[#050505]">
      <Navbar />
      <HeroSection />
      <Features />
      <Mentors />
      <HowItWorks />
      <CTA />
      <Footer />
    </main>
  );
}
