import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import rateLimit from 'express-rate-limit';

import { authRouter } from './routes/auth';
import { topicsRouter } from './routes/topics';
import { progressRouter } from './routes/progress';
import { economyRouter } from './routes/economy';
import { supabaseAuth } from './middleware/supabase-auth';

const app = express();
const PORT = process.env.PORT ?? 3000;

app.use(helmet());
app.use(cors({
  origin: process.env.ALLOWED_ORIGINS?.split(',') ?? ['http://localhost:*'],
  credentials: true,
}));
app.use(morgan('combined'));
app.use(express.json());

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 500,
  message: { error: 'Too many requests, please try again later.' },
});
app.use(limiter);

app.get('/health', (_, res) => res.json({ status: 'ok', service: 'vidyalaxmi-gateway' }));

app.use('/auth', authRouter);
app.use('/topics', supabaseAuth, topicsRouter);
app.use('/progress', supabaseAuth, progressRouter);
app.use('/economy', supabaseAuth, economyRouter);

app.use((err: Error, _req: express.Request, res: express.Response, _next: express.NextFunction) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Internal server error' });
});

app.listen(PORT, () => {
  console.log(`VidyaLaxmi Gateway running on port ${PORT}`);
});

export default app;
