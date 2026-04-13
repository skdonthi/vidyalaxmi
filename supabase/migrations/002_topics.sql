-- Topics (learning content)
CREATE TABLE IF NOT EXISTS public.topics (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title_en        TEXT NOT NULL,
  title_te        TEXT NOT NULL DEFAULT '',
  title_hi        TEXT NOT NULL DEFAULT '',
  subject_domain  TEXT NOT NULL CHECK (subject_domain IN ('physics', 'math', 'bio', 'social', 'language')),
  mentor_id       TEXT NOT NULL CHECK (mentor_id IN ('zayn', 'arya', 'dhara')),
  base_difficulty INTEGER NOT NULL DEFAULT 1 CHECK (base_difficulty BETWEEN 1 AND 5),
  jingle_config   JSONB NOT NULL DEFAULT '{}',
  boss_fight_config JSONB NOT NULL DEFAULT '{}',
  is_published    BOOLEAN NOT NULL DEFAULT false,
  sort_order      INTEGER NOT NULL DEFAULT 0,
  prerequisite_ids UUID[] NOT NULL DEFAULT '{}',
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX topics_subject_idx ON public.topics(subject_domain);
CREATE INDEX topics_mentor_idx ON public.topics(mentor_id);
