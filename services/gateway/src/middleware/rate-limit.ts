import rateLimit from 'express-rate-limit';

export const strictLimiter = rateLimit({
  windowMs: 60 * 1000,
  max: 30,
  message: { error: 'Too many requests on this endpoint.' },
  standardHeaders: true,
  legacyHeaders: false,
});

export const aiLimiter = rateLimit({
  windowMs: 60 * 1000,
  max: 10,
  message: { error: 'AI engine rate limit reached. Try again in a minute.' },
  standardHeaders: true,
  legacyHeaders: false,
});
