-- Enable RLS on all tables
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lcoin_transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.scroll_pdfs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.topics ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.analytics_events ENABLE ROW LEVEL SECURITY;

-- ── users ──────────────────────────────────────────────────────
CREATE POLICY "Users can view own profile"
  ON public.users FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
  ON public.users FOR UPDATE
  USING (auth.uid() = id);

-- ── topics (public read) ────────────────────────────────────────
CREATE POLICY "Topics are publicly readable"
  ON public.topics FOR SELECT
  USING (is_published = true);

-- ── progress ───────────────────────────────────────────────────
CREATE POLICY "Users can read own progress"
  ON public.progress FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own progress"
  ON public.progress FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own progress"
  ON public.progress FOR UPDATE
  USING (auth.uid() = user_id);

-- ── lcoin_transactions ─────────────────────────────────────────
CREATE POLICY "Users can read own transactions"
  ON public.lcoin_transactions FOR SELECT
  USING (auth.uid() = user_id);

-- ── scroll_pdfs ────────────────────────────────────────────────
CREATE POLICY "Users can read own scrolls"
  ON public.scroll_pdfs FOR SELECT
  USING (auth.uid() = user_id);

-- ── analytics (insert only, no user reads) ─────────────────────
CREATE POLICY "Analytics insert allowed"
  ON public.analytics_events FOR INSERT
  WITH CHECK (true);
