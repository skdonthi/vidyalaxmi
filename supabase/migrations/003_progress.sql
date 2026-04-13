-- User progress per topic
CREATE TABLE IF NOT EXISTS public.progress (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id             UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  topic_id            UUID NOT NULL REFERENCES public.topics(id) ON DELETE CASCADE,
  current_difficulty  INTEGER NOT NULL DEFAULT 1 CHECK (current_difficulty BETWEEN 1 AND 5),
  accuracy_avg        FLOAT NOT NULL DEFAULT 0 CHECK (accuracy_avg BETWEEN 0 AND 1),
  response_time_avg   FLOAT,
  attempts            INTEGER NOT NULL DEFAULT 1,
  completed           BOOLEAN NOT NULL DEFAULT false,
  score               INTEGER NOT NULL DEFAULT 0,
  completed_at        TIMESTAMPTZ,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, topic_id)
);

CREATE INDEX progress_user_idx ON public.progress(user_id);
CREATE INDEX progress_topic_idx ON public.progress(topic_id);
CREATE INDEX progress_completed_idx ON public.progress(user_id, completed);

CREATE TRIGGER progress_updated_at
  BEFORE UPDATE ON public.progress
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
