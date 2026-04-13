-- L-Coin transaction ledger
CREATE TABLE IF NOT EXISTS public.lcoin_transactions (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  amount      INTEGER NOT NULL,  -- positive = award, negative = spend
  type        TEXT NOT NULL CHECK (type IN ('award', 'spend')),
  description TEXT NOT NULL DEFAULT '',
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX lcoin_user_idx ON public.lcoin_transactions(user_id, created_at DESC);

-- Scroll PDF records
CREATE TABLE IF NOT EXISTS public.scroll_pdfs (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  topic_id      UUID NOT NULL REFERENCES public.topics(id) ON DELETE CASCADE,
  storage_path  TEXT NOT NULL,
  locale        TEXT NOT NULL DEFAULT 'en',
  generated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Analytics events (anonymized — no user PII)
CREATE TABLE IF NOT EXISTS public.analytics_events (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  topic_id    TEXT NOT NULL,
  event_type  TEXT NOT NULL,
  locale      TEXT NOT NULL DEFAULT 'en',
  payload     JSONB NOT NULL DEFAULT '{}',
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Award L-Coins RPC
CREATE OR REPLACE FUNCTION public.award_l_coins(
  p_user_id    UUID,
  p_amount     INTEGER,
  p_description TEXT
) RETURNS INTEGER LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE v_new_balance INTEGER;
BEGIN
  INSERT INTO public.lcoin_transactions (user_id, amount, type, description)
  VALUES (p_user_id, p_amount, 'award', p_description);

  UPDATE public.users SET l_coins = l_coins + p_amount WHERE id = p_user_id
  RETURNING l_coins INTO v_new_balance;

  RETURN v_new_balance;
END;
$$;

-- Spend L-Coins RPC
CREATE OR REPLACE FUNCTION public.spend_l_coins(
  p_user_id    UUID,
  p_amount     INTEGER,
  p_description TEXT
) RETURNS INTEGER LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_balance    INTEGER;
  v_new_balance INTEGER;
BEGIN
  SELECT l_coins INTO v_balance FROM public.users WHERE id = p_user_id FOR UPDATE;

  IF v_balance < p_amount THEN
    RAISE EXCEPTION 'Insufficient L-Coins: have %, need %', v_balance, p_amount;
  END IF;

  INSERT INTO public.lcoin_transactions (user_id, amount, type, description)
  VALUES (p_user_id, -p_amount, 'spend', p_description);

  UPDATE public.users SET l_coins = l_coins - p_amount WHERE id = p_user_id
  RETURNING l_coins INTO v_new_balance;

  RETURN v_new_balance;
END;
$$;

-- Update streak RPC
CREATE OR REPLACE FUNCTION public.update_streak(p_user_id UUID)
RETURNS INTEGER LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_last_active TIMESTAMPTZ;
  v_streak      INTEGER;
BEGIN
  SELECT last_active, streak_days INTO v_last_active, v_streak
  FROM public.users WHERE id = p_user_id;

  IF v_last_active IS NULL OR v_last_active::DATE < (NOW() - INTERVAL '1 day')::DATE THEN
    -- Streak broken or first time
    IF v_last_active IS NULL OR v_last_active::DATE < (NOW() - INTERVAL '2 days')::DATE THEN
      v_streak := 1;
    ELSE
      v_streak := v_streak + 1;
    END IF;
  END IF;

  UPDATE public.users
  SET last_active = NOW(), streak_days = v_streak
  WHERE id = p_user_id;

  RETURN v_streak;
END;
$$;
