import { Router } from 'express';
import { z } from 'zod';
import { supabase } from '../lib/supabase';
import type { AuthedRequest } from '../middleware/supabase-auth';

export const progressRouter = Router();

progressRouter.get('/', async (req: AuthedRequest, res) => {
  const { data, error } = await supabase
    .from('progress')
    .select('*')
    .eq('user_id', req.userId!);

  if (error) return res.status(500).json({ error: error.message });
  return res.json(data);
});

const upsertSchema = z.object({
  topicId: z.string().uuid(),
  score: z.number().int().min(0),
  accuracyAvg: z.number().min(0).max(1),
  currentDifficulty: z.number().int().min(1).max(5),
  completed: z.boolean().default(false),
  responseTimeAvg: z.number().min(0).optional(),
});

progressRouter.post('/upsert', async (req: AuthedRequest, res) => {
  const parsed = upsertSchema.safeParse(req.body);
  if (!parsed.success) return res.status(400).json({ error: parsed.error.flatten() });

  const { topicId, score, accuracyAvg, currentDifficulty, completed, responseTimeAvg } = parsed.data;

  const { data, error } = await supabase
    .from('progress')
    .upsert({
      user_id: req.userId!,
      topic_id: topicId,
      score,
      accuracy_avg: accuracyAvg,
      current_difficulty: currentDifficulty,
      response_time_avg: responseTimeAvg,
      completed,
      completed_at: completed ? new Date().toISOString() : null,
      attempts: 1, // Supabase RPC handles incrementing
    }, { onConflict: 'user_id,topic_id' })
    .select()
    .single();

  if (error) return res.status(500).json({ error: error.message });
  return res.json(data);
});
