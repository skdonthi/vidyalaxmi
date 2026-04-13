import { Request, Response, NextFunction } from 'express';
import { createClient } from '@supabase/supabase-js';

const supabasePublic = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_ANON_KEY!,
);

export interface AuthedRequest extends Request {
  userId?: string;
  userEmail?: string;
}

export async function supabaseAuth(
  req: AuthedRequest,
  res: Response,
  next: NextFunction,
): Promise<void> {
  const authHeader = req.headers.authorization;

  if (!authHeader?.startsWith('Bearer ')) {
    res.status(401).json({ error: 'Missing or invalid Authorization header' });
    return;
  }

  const token = authHeader.split(' ')[1];

  try {
    const { data, error } = await supabasePublic.auth.getUser(token);

    if (error || !data.user) {
      res.status(401).json({ error: 'Invalid or expired token' });
      return;
    }

    req.userId = data.user.id;
    req.userEmail = data.user.email;
    next();
  } catch {
    res.status(401).json({ error: 'Authentication failed' });
  }
}
