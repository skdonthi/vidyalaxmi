import { Router } from 'express';
import { z } from 'zod';
import { supabase } from '../lib/supabase';

export const authRouter = Router();

const signUpSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  displayName: z.string().min(2).max(50),
});

authRouter.post('/signup', async (req, res) => {
  const parsed = signUpSchema.safeParse(req.body);
  if (!parsed.success) {
    return res.status(400).json({ error: parsed.error.flatten() });
  }

  const { email, password, displayName } = parsed.data;

  const { data, error } = await supabase.auth.admin.createUser({
    email,
    password,
    email_confirm: true,
    user_metadata: { display_name: displayName },
  });

  if (error) return res.status(400).json({ error: error.message });

  // Create user profile row
  await supabase.from('users').insert({
    id: data.user.id,
    display_name: displayName,
    preferred_locale: 'en',
    l_coins: 0,
    streak_days: 0,
  });

  return res.status(201).json({ userId: data.user.id });
});

authRouter.post('/anonymous', async (_req, res) => {
  const { data, error } = await supabase.auth.admin.createUser({
    email: `anon_${Date.now()}@vidyalaxmi.local`,
    password: Math.random().toString(36),
    email_confirm: true,
    user_metadata: { is_anonymous: true },
  });

  if (error) return res.status(400).json({ error: error.message });

  await supabase.from('users').insert({
    id: data.user.id,
    display_name: 'Learner',
    preferred_locale: 'en',
    l_coins: 0,
    streak_days: 0,
  });

  return res.status(201).json({ userId: data.user.id });
});
