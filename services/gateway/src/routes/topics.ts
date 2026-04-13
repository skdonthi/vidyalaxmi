import { Router } from 'express';
import { supabase } from '../lib/supabase';
import type { AuthedRequest } from '../middleware/supabase-auth';

export const topicsRouter = Router();

topicsRouter.get('/', async (_req, res) => {
  const { data, error } = await supabase
    .from('topics')
    .select('*')
    .order('created_at', { ascending: true });

  if (error) return res.status(500).json({ error: error.message });
  return res.json(data);
});

topicsRouter.get('/:id', async (req, res) => {
  const { data, error } = await supabase
    .from('topics')
    .select('*')
    .eq('id', req.params.id)
    .single();

  if (error) return res.status(404).json({ error: 'Topic not found' });
  return res.json(data);
});

topicsRouter.get('/:id/jingle', async (req, res) => {
  const { data, error } = await supabase
    .from('topics')
    .select('jingle_config')
    .eq('id', req.params.id)
    .single();

  if (error) return res.status(404).json({ error: 'Topic not found' });
  return res.json(data?.jingle_config ?? {});
});

topicsRouter.get('/:id/boss-fight', async (req, res) => {
  const { data, error } = await supabase
    .from('topics')
    .select('boss_fight_config')
    .eq('id', req.params.id)
    .single();

  if (error) return res.status(404).json({ error: 'Topic not found' });
  return res.json(data?.boss_fight_config ?? {});
});
