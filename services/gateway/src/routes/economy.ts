import { Router } from 'express';
import { z } from 'zod';
import { supabase } from '../lib/supabase';
import type { AuthedRequest } from '../middleware/supabase-auth';

export const economyRouter = Router();

economyRouter.get('/balance', async (req: AuthedRequest, res) => {
  const { data, error } = await supabase
    .from('users')
    .select('l_coins, streak_days')
    .eq('id', req.userId!)
    .single();

  if (error) return res.status(404).json({ error: 'User not found' });
  return res.json(data);
});

economyRouter.get('/transactions', async (req: AuthedRequest, res) => {
  const { data, error } = await supabase
    .from('lcoin_transactions')
    .select('*')
    .eq('user_id', req.userId!)
    .order('created_at', { ascending: false })
    .limit(50);

  if (error) return res.status(500).json({ error: error.message });
  return res.json(data);
});

const transactionSchema = z.object({
  amount: z.number().int().positive(),
  description: z.string().max(200),
});

economyRouter.post('/award', async (req: AuthedRequest, res) => {
  const parsed = transactionSchema.safeParse(req.body);
  if (!parsed.success) return res.status(400).json({ error: parsed.error.flatten() });

  const { data, error } = await supabase.rpc('award_l_coins', {
    p_user_id: req.userId!,
    p_amount: parsed.data.amount,
    p_description: parsed.data.description,
  });

  if (error) return res.status(500).json({ error: error.message });
  return res.json({ newBalance: data });
});

economyRouter.post('/spend', async (req: AuthedRequest, res) => {
  const parsed = transactionSchema.safeParse(req.body);
  if (!parsed.success) return res.status(400).json({ error: parsed.error.flatten() });

  const { data, error } = await supabase.rpc('spend_l_coins', {
    p_user_id: req.userId!,
    p_amount: parsed.data.amount,
    p_description: parsed.data.description,
  });

  if (error) return res.status(500).json({ error: error.message });
  return res.json({ newBalance: data });
});

economyRouter.post('/streak/update', async (req: AuthedRequest, res) => {
  const { data, error } = await supabase.rpc('update_streak', {
    p_user_id: req.userId!,
  });

  if (error) return res.status(500).json({ error: error.message });
  return res.json({ streakDays: data });
});
